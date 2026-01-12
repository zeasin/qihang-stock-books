package cn.qihangerp.api.controller.oms;

import cn.qihangerp.api.common.ShopApiCommon;
import cn.qihangerp.api.common.ShopRefundTransform;
import cn.qihangerp.api.request.PullRequest;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.common.ResultVoEnum;
import cn.qihangerp.common.enums.EnumShopType;
import cn.qihangerp.common.enums.HttpStatus;
import cn.qihangerp.model.entity.ORefund;
import cn.qihangerp.model.entity.OShopPullLogs;
import cn.qihangerp.open.common.ApiResultVo;
import cn.qihangerp.open.pdd.PddRefundApiHelper;
import cn.qihangerp.open.pdd.model.AfterSale;
import cn.qihangerp.service.service.ORefundService;
import cn.qihangerp.service.service.OShopPullLogsService;
import com.alibaba.fastjson2.JSONObject;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 店铺退款
 */
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/shop/refund")
public class ShopRefundApiController {
    private final ORefundService oRefundService;
    private final ShopApiCommon shopApiCommon;
    private final OShopPullLogsService pullLogsService;
    private final String DATE_PATTERN =
            "^(?:(?:(?:\\d{4}-(?:0?[1-9]|1[0-2])-(?:0?[1-9]|1\\d|2[0-8]))|(?:(?:(?:\\d{2}(?:0[48]|[2468][048]|[13579][26])|(?:(?:0[48]|[2468][048]|[13579][26])00))-0?2-29))$)|(?:(?:(?:\\d{4}-(?:0?[13578]|1[02]))-(?:0?[1-9]|[12]\\d|30))$)|(?:(?:(?:\\d{4}-0?[13-9]|1[0-2])-(?:0?[1-9]|[1-2]\\d|30))$)|(?:(?:(?:\\d{2}(?:0[48]|[13579][26]|[2468][048])|(?:(?:0[48]|[13579][26]|[2468][048])00))-0?2-29))$)$";
    private final Pattern DATE_FORMAT = Pattern.compile(DATE_PATTERN);


    /**
     * 增量更新订单
     * @param req
     * @
     * @throws
     */
    @PostMapping("/pull_list")
    @ResponseBody
    public AjaxResult pullRefundList(@RequestBody PullRequest req) throws Exception {
        log.info("===============拉取pdd退款=================");
        if (req.getShopId() == null || req.getShopId() <= 0) {
            return AjaxResult.error(HttpStatus.PARAMS_ERROR, "参数错误，没有店铺Id");
        }
        if (req.getCreateTime() == null) return AjaxResult.error("缺少参数：下单时间");

        // 判断时间格式
        Matcher matcher = DATE_FORMAT.matcher(req.getCreateTime());
        boolean b = matcher.find();
        if (!b) {
            return AjaxResult.error("创建日期格式错误");
        }

        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        var checkResult = shopApiCommon.checkBefore(req.getShopId());
        if (checkResult.getCode() != HttpStatus.SUCCESS) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();
        Long shopId = checkResult.getData().getShopId();
        int shopType = checkResult.getData().getShopType();
        //api返回
        int apiResponseCode = 0;
        String apiResponseMsg = "";
        int insertSuccess = 0;//新增成功的订单
        int totalError = 0;
        int hasExistOrder = 0;//已存在的订单数
        //api参数
        String pullParams = "{}";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        if(shopType==EnumShopType.PDD.getIndex()) {
            log.info("=============拉取PDD店铺订单。开始时间：{} ", req.getCreateTime());
            LocalDateTime startTime = LocalDateTime.parse(req.getCreateTime() + " 00:00:01", formatter);
//            LocalDateTime  endTime = LocalDateTime.parse(req.getCreateTime() + " 23:59:59", formatter);

            Long startTimestamp = startTime.toEpochSecond(ZoneOffset.ofHours(8));
            for(int i=0;i<48;i++){
                Long endTimestamp = startTimestamp+30*60;
                // 转换为 LocalDateTime
                LocalDateTime start = Instant.ofEpochSecond(startTimestamp).atZone(ZoneId.systemDefault()).toLocalDateTime();
                LocalDateTime end = Instant.ofEpochSecond(endTimestamp).atZone(ZoneId.systemDefault()).toLocalDateTime();
                pullParams = "{startTime:" + start.format(formatter) + ",endTime:" + end.format(formatter) + "}";

                ApiResultVo<AfterSale> upResult = PddRefundApiHelper.pullRefundList(appKey, appSecret, accessToken, startTimestamp.intValue(), endTimestamp.intValue(), 1, 100);
                apiResponseCode = upResult.getCode();
                apiResponseMsg = upResult.getMsg();
                if(apiResponseCode!=0) {
                    log.info("======循环拉取PDD一天的退款：{} result:{}-{}", pullParams, upResult.getCode(), upResult.getMsg());
                    break;
                }
                if(apiResponseCode==0) {
                    log.info("======循环拉取PDD一天的退款：{} result:{}-{}", pullParams, upResult.getCode(), upResult.getList().size());
                    //循环插入订单数据到数据库
                    for (var refund : upResult.getList()) {
                        ORefund oRefund = ShopRefundTransform.transformPddRefund(refund);
                        oRefund.setShopId(shopId);
                        oRefund.setShopType(shopType);

                        //插入订单数据
                        var result =  oRefundService.saveAndUpdateRefund(oRefund);
                        if (result.getCode() == ResultVoEnum.DataExist.getIndex()) {
                            //已经存在
                            log.info("/**************主动更新pdd退款：开始更新数据库：" + refund.getId() + "存在、更新****************/");

                            hasExistOrder++;
                        } else if (result.getCode() == ResultVoEnum.SUCCESS.getIndex()) {
                            log.info("/**************主动更新pdd退款：开始更新数据库：" + refund.getId() + "不存在、新增****************/");

                            insertSuccess++;
                        } else {
                            log.info("/**************主动更新pdd退款：开始更新数据库：" + refund.getId() + "报错****************/");
                            totalError++;
                        }
                    }
                    startTimestamp = endTimestamp;
                }
            }

        }else{
            return AjaxResult.error("暂时不支持！");
        }

        if (apiResponseCode != 0) {
            OShopPullLogs logs = new OShopPullLogs();
            logs.setShopId(shopId);
            logs.setShopType(shopType);
            logs.setPullType("REFUND");
            logs.setPullWay("主动拉取退款");
            logs.setPullParams(pullParams);
            logs.setPullResult(apiResponseMsg);
            logs.setPullTime(currDateTime);
            logs.setDuration(System.currentTimeMillis() - beginTime);
            pullLogsService.save(logs);
            return AjaxResult.error(apiResponseMsg);
        }else {
            OShopPullLogs logs = new OShopPullLogs();
            logs.setShopType(shopType);
            logs.setShopId(shopId);
            logs.setPullType("REFUND");
            logs.setPullWay("主动拉取退款");
            logs.setPullParams(pullParams);
            logs.setPullResult("{insert:" + insertSuccess + ",update:" + hasExistOrder + ",fail:" + totalError + "}");
            logs.setPullTime(currDateTime);
            logs.setDuration(System.currentTimeMillis() - beginTime);
            pullLogsService.save(logs);
        }

        return AjaxResult.success();
    }

    @PostMapping("/pull_detail")
    @ResponseBody
    public AjaxResult pullRefundDetail(@RequestBody PullRequest req) throws Exception {
        log.info("==========拉取退款详情：{}", JSONObject.toJSONString(req));
        if(req.getRefundId()==null) return AjaxResult.error("缺少参数：RefundId");
        ORefund refund = oRefundService.getById(req.getRefundId());
        if(refund==null) return AjaxResult.error("找不到售后单数据");
        var checkResult = shopApiCommon.checkBefore(refund.getShopId());
        if (checkResult.getCode() != HttpStatus.SUCCESS) {
            return AjaxResult.error(checkResult.getCode(), checkResult.getMsg(), checkResult.getData());
        }
        String accessToken = checkResult.getData().getAccessToken();
        String appKey = checkResult.getData().getAppKey();
        String appSecret = checkResult.getData().getAppSecret();
        //api返回
        int apiResponseCode = 0;
        String apiResponseMsg = "";
        Date currDateTime = new Date();
        long beginTime = System.currentTimeMillis();

        if(refund.getShopType().intValue()==EnumShopType.PDD.getIndex()) {
            ApiResultVo<AfterSale> apiResultVo = PddRefundApiHelper.pullRefundDetil(appKey, appSecret, accessToken, refund.getRefundNum(), refund.getOrderNum());
            apiResponseCode = apiResultVo.getCode();
            apiResponseMsg = apiResultVo.getMsg();
            AfterSale afterSale = apiResultVo.getData();
            afterSale.setAfterSalesType(afterSale.getAfterSalesStatus()+1);
            afterSale.setTrackingNumber(afterSale.getExpressNo());
            afterSale.setRefundAmount(afterSale.getRefundAmount()/100);
            afterSale.setOrderAmount(afterSale.getOrderAmount()/100);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            LocalDateTime updateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(Long.parseLong(afterSale.getUpdatedTime())), ZoneId.of("UTC"));
            LocalDateTime orderTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(Long.parseLong(afterSale.getConfirmTime())), ZoneId.of("UTC"));

            afterSale.setUpdatedTime(updateTime.format(formatter));
            afterSale.setConfirmTime(orderTime.format(formatter));
            ORefund oRefund = ShopRefundTransform.transformPddRefund(afterSale);
            oRefund.setShopId(refund.getShopId());
            oRefund.setShopType(refund.getShopType());
            oRefund.setId(refund.getId());
            //插入订单数据
            var result =  oRefundService.saveAndUpdateRefund(oRefund);
            log.info("===========主动更新pdd退款:{}", JSONObject.toJSONString(result));


        }else return AjaxResult.error("暂时不支持");

        OShopPullLogs logs = new OShopPullLogs();
        logs.setShopId(refund.getShopId());
        logs.setShopType(refund.getShopType());
        logs.setPullType("REFUND");
        logs.setPullWay("更新退款");
        logs.setPullParams(refund.getRefundNum());
        logs.setPullResult(apiResponseMsg);
        logs.setPullTime(currDateTime);
        logs.setDuration(System.currentTimeMillis() - beginTime);
        pullLogsService.save(logs);
        if (apiResponseCode != 0) {
            return AjaxResult.error(apiResponseMsg);
        }
        return AjaxResult.success();
    }
}
