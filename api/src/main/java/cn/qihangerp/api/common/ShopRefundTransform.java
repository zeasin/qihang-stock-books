package cn.qihangerp.api.common;

import cn.qihangerp.common.enums.PddRefundStatusEnum;
import cn.qihangerp.model.entity.ORefund;
import cn.qihangerp.open.tao.response.TaoRefundResponse;
import cn.qihangerp.open.wei.model.AfterSaleOrder;
import com.alibaba.fastjson2.JSONObject;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ShopRefundTransform {
    public static ORefund transformTaoRefund(TaoRefundResponse taoRefund) {
        ORefund refund = new ORefund();
        refund.setRefundNum(taoRefund.getRefundId());
        // 类型(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)
        Integer refundType = null;
        //退款类型，可选值REFUND(退款不退货),REFUND_AND_RETURN(退货退款),TMALL_EXCHANGE(天猫换货),TAOBAO_EXCHANGE(淘宝换货),REPAIR(维修),RESHIPPING(补寄),OTHERS(其他)
        if(taoRefund.getDisputeType().equals("REFUND")){
            refundType = 11;
        }else if(taoRefund.getDisputeType().equals("REFUND_AND_RETURN")){
            refundType = 10;
        }else if(taoRefund.getDisputeType().equals("TMALL_EXCHANGE")||taoRefund.getDisputeType().equals("TAOBAO_EXCHANGE")){
            refundType = 20;
        }else if(taoRefund.getDisputeType().equals("RESHIPPING")){
            refundType = 80;
        }else if(taoRefund.getDisputeType().equals("REPAIR")){
            refundType = 30;
        }else if(taoRefund.getDisputeType().equals("OTHERS")){
            refundType = -1;//其他
        }
        refund.setRefundType(refundType);
//        refund.setOrderAmount(Double.parseDouble(taoRefund.getPayment()));
        refund.setOrderAmount(Double.parseDouble(taoRefund.getTotalFee()));
        refund.setOrderNum(taoRefund.getTid());
        refund.setOrderItemNum(taoRefund.getOid());
        refund.setRefundAmount(Double.parseDouble(taoRefund.getRefundFee()));
        refund.setRefundReason(taoRefund.getReason()    );
        refund.setSkuId(taoRefund.getNumIid().toString());
        refund.setSkuNum(taoRefund.getOuterId());
        refund.setSkuName(taoRefund.getSku());
        refund.setProductId(taoRefund.getNumIid().toString());
        refund.setProductName(taoRefund.getTitle());
        refund.setProductImage(null);
        refund.setAfterNum(taoRefund.getNum());
        refund.setBuyNum(taoRefund.getNum());
        //货物状态。可选值BUYER_NOT_RECEIVED (买家未收到货) BUYER_RECEIVED (买家已收到货) BUYER_RETURNED_GOODS (买家已退货)
        if(taoRefund.getGoodStatus().equals("BUYER_NOT_RECEIVED")) {
            refund.setUserShippingStatus("1");
        } else if(taoRefund.getGoodStatus().equals("BUYER_RECEIVED")) {
            refund.setUserShippingStatus("2");
        }else if(taoRefund.getGoodStatus().equals("BUYER_RETURNED_GOODS")) {
            refund.setUserShippingStatus("3");
        }else{
            refund.setUserShippingStatus("0");
        }
        refund.setPlatformStatus(taoRefund.getStatus());
        //退款状态。可选值
        // WAIT_SELLER_AGREE(买家已经申请退款，等待卖家同意) WAIT_BUYER_RETURN_GOODS(卖家已经同意退款，等待买家退货)
        // WAIT_SELLER_CONFIRM_GOODS(买家已经退货，等待卖家确认收货) SELLER_REFUSE_BUYER(卖家拒绝退款) CLOSED(退款关闭) SUCCESS(退款成功)
        if(taoRefund.getStatus().equals("WAIT_SELLER_AGREE")){
            refund.setPlatformStatusText("买家已经申请退款，等待卖家同意");
        }else if(taoRefund.getStatus().equals("WAIT_BUYER_RETURN_GOODS")){
            refund.setPlatformStatusText("卖家已经同意退款，等待买家退货");
        }else if(taoRefund.getStatus().equals("WAIT_SELLER_CONFIRM_GOODS")){
            refund.setPlatformStatusText("买家已经退货，等待卖家确认收货");
        }else if(taoRefund.getStatus().equals("SELLER_REFUSE_BUYER")){
            refund.setPlatformStatusText("卖家拒绝退款");
        }else if(taoRefund.getStatus().equals("CLOSED")){
            refund.setPlatformStatusText("退款关闭");
        }else if(taoRefund.getStatus().equals("SUCCESS")){
            refund.setPlatformStatusText("退款成功");
        }//退款对应的订单交易状态。可选值
        // TRADE_NO_CREATE_PAY(没有创建支付宝交易) WAIT_BUYER_PAY(等待买家付款) WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款)
        // WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货) TRADE_BUYER_SIGNED(买家已签收,货到付款专用) TRADE_FINISHED(交易成功)
        // TRADE_CLOSED(交易关闭) TRADE_CLOSED_BY_TAOBAO(交易被淘宝关闭)
        // ALL_WAIT_PAY(包含：WAIT_BUYER_PAY、TRADE_NO_CREATE_PAY)
        // ALL_CLOSED(包含：TRADE_CLOSED、TRADE_CLOSED_BY_TAOBAO)
        if(taoRefund.getOrderStatus().equals("TRADE_NO_CREATE_PAY")||taoRefund.getOrderStatus().equals("WAIT_BUYER_PAY")||taoRefund.getOrderStatus().equals("WAIT_SELLER_SEND_GOODS")||taoRefund.getOrderStatus().equals("ALL_WAIT_PAY")) {
            refund.setShippingStatus(0);
        }else if(taoRefund.getOrderStatus().equals("WAIT_BUYER_CONFIRM_GOODS")||taoRefund.getOrderStatus().equals("TRADE_BUYER_SIGNED")||taoRefund.getOrderStatus().equals("TRADE_FINISHED")){
            refund.setShippingStatus(1);
        }else if(taoRefund.getOrderStatus().equals("TRADE_CLOSED")||taoRefund.getOrderStatus().equals("TRADE_CLOSED_BY_TAOBAO")||taoRefund.getOrderStatus().equals("ALL_CLOSED")){
            refund.setShippingStatus(0);
        }

        refund.setRefundCreated(taoRefund.getCreated());
        refund.setRefundUpdated(taoRefund.getModified());
        refund.setOrderTime(null);

        refund.setReturnLogisticsCompany(taoRefund.getCompanyName());
        refund.setReturnLogisticsCode(taoRefund.getSid());
        return refund;
    }

    public static ORefund transformJdRefund(cn.qihangerp.open.jd.model.AfterSale jdRefund) {
        ORefund refund = new ORefund();
        refund.setRefundNum(jdRefund.getServiceId().toString());
        refund.setRefundType(jdRefund.getCustomerExpect());
//        refund.setOrderAmount(pddRefund.getOrderAmount());
        refund.setOrderNum(jdRefund.getOrderId().toString());
        refund.setOrderItemNum(jdRefund.getOrderId()+"-"+jdRefund.getSkuId());
//        refund.setRefundAmount(jdRefund.getapply());
//        refund.setRefundReason(jdRefund.get());
        refund.setSkuId(jdRefund.getSkuId()+"");
//        refund.setSkuNum(jdRefund.getOuterId());
        refund.setSkuName("");
        refund.setProductId("");
        refund.setProductName(jdRefund.getWareName());
//        refund.setGoodsImage(pddRefund.getGoodImage());
        refund.setAfterNum(jdRefund.getServiceCount());
//        refund.setUserShippingStatus(pddRefund.getUserShippingStatus());
        refund.setPlatformStatus(jdRefund.getServiceStatus()+"");
        refund.setPlatformStatusText(jdRefund.getServiceStatusName());
        refund.setRefundCreated(jdRefund.getApplyTime());
        refund.setRefundUpdated(jdRefund.getUpdateDate());
//        refund.setOrderTime(pddRefund.getConfirmTime());
//        refund.setReturnLogisticsCompany(pddRefund.getShippingName());
//        refund.setReturnLogisticsCode(pddRefund.getTrackingNumber());
        refund.setRefundCreated(jdRefund.getApplyTime());
        return refund;
    }

    public static ORefund transformPddRefund(cn.qihangerp.open.pdd.model.AfterSale pddRefund) {
        ORefund refund = new ORefund();
        refund.setRefundNum(pddRefund.getId().toString());
        // 类型(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)
        Integer refundType = null;
        //售后类型 1：全部 2：仅退款 3：退货退款 4：换货 5：缺货补寄 6：维修
        if(pddRefund.getAfterSalesType()==2){
            refundType = 11;
        }else if(pddRefund.getAfterSalesType()==3){
            refundType = 10;
        }else if(pddRefund.getAfterSalesType()==4){
            refundType = 20;
        }else if(pddRefund.getAfterSalesType()==5){
            refundType = 80;
        }else if(pddRefund.getAfterSalesType()==6){
            refundType = 30;
        }
        refund.setRefundType(refundType);
        refund.setOrderAmount(pddRefund.getOrderAmount());
        refund.setOrderNum(pddRefund.getOrderSn());
        refund.setOrderItemNum(pddRefund.getOrderSn()+"-"+pddRefund.getSkuId());
        refund.setRefundAmount(pddRefund.getRefundAmount());
        refund.setRefundReason(pddRefund.getAfterSaleReason());
        refund.setSkuId(pddRefund.getSkuId());
        refund.setSkuNum(pddRefund.getOuterId());
        refund.setSkuName("");
        refund.setProductId(pddRefund.getGoodsId().toString());
        refund.setProductName(pddRefund.getGoodsName());
        refund.setProductImage(pddRefund.getGoodImage());
        refund.setAfterNum(pddRefund.getGoodsNumber());
        refund.setBuyNum(pddRefund.getGoodsNumber());
        refund.setUserShippingStatus(pddRefund.getUserShippingStatus());
        refund.setPlatformStatus(pddRefund.getAfterSalesStatus()+"");
        //售后状态 0：无售后 2：买家申请退款，待商家处理 3：退货退款，待商家处理 4：商家同意退款，退款中 5：平台同意退款，退款中
        // 6：驳回退款，待买家处理 7：已同意退货退款,待用户发货 8：平台处理中 9：平台拒绝退款，退款关闭 10：退款成功
        // 11：买家撤销 12：买家逾期未处理，退款失败 13：买家逾期，超过有效期 14：换货补寄待商家处理 15：换货补寄待用户处理
        // 16：换货补寄成功 17：换货补寄失败 18：换货补寄待用户确认完成 21：待商家同意维修 22：待用户确认发货 24：维修关闭
        // 25：维修成功 27：待用户确认收货 31：已同意拒收退款，待用户拒收 32：补寄待商家发货
        refund.setPlatformStatusText(PddRefundStatusEnum.getName(pddRefund.getAfterSalesStatus()));
        refund.setRefundCreated(pddRefund.getCreatedTime());
        refund.setRefundUpdated(pddRefund.getUpdatedTime());
        refund.setOrderTime(pddRefund.getConfirmTime());
        refund.setShippingStatus(Integer.parseInt(pddRefund.getShippingStatus()));
        refund.setReturnLogisticsCompany(pddRefund.getShippingName());
        refund.setReturnLogisticsCode(pddRefund.getTrackingNumber());
        return refund;
    }

    public static List<ORefund> transformDouRefund(cn.qihangerp.open.dou.model.after.AfterSale douRefund) {
        List<ORefund> refunds = new ArrayList<ORefund>();

        ORefund refund = new ORefund();
        refund.setRefundNum(douRefund.getAftersaleInfo().getAftersaleId());
        // 类型(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)

        //售后类型；0-退货退款；1-已发货退款；2-未发货退款；3-换货；6-价保；7-补寄；8-维修
        if(douRefund.getAftersaleInfo().getAftersaleType()==0){
            refund.setRefundType(10);
            refund.setShippingStatus(1);
        }else if(douRefund.getAftersaleInfo().getAftersaleType()==1){
            refund.setRefundType(11);
            refund.setShippingStatus(1);
        }else if(douRefund.getAftersaleInfo().getAftersaleType()==2){
            refund.setRefundType(1);
            refund.setShippingStatus(0);
        }else if(douRefund.getAftersaleInfo().getAftersaleType()==3){
            refund.setRefundType(20);
            refund.setShippingStatus(1);
        }else if(douRefund.getAftersaleInfo().getAftersaleType()==6){
            refund.setRefundType(11);
            refund.setShippingStatus(1);
        }else if(douRefund.getAftersaleInfo().getAftersaleType()==7){
            refund.setRefundType(80);
            refund.setShippingStatus(1);
        }else if(douRefund.getAftersaleInfo().getAftersaleType()==8){
            refund.setRefundType(30);
            refund.setShippingStatus(1);
        }
        refund.setRefundReason(douRefund.getAftersaleInfo().getRiskDecisionReason());
        refund.setOrderNum(douRefund.getAftersaleInfo().getRelatedId());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        LocalDateTime createTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(douRefund.getAftersaleInfo().getCreateTime()), ZoneId.of("UTC"));
        LocalDateTime updateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(douRefund.getAftersaleInfo().getUpdateTime()), ZoneId.of("UTC"));
        refund.setRefundCreated(createTime.format(formatter));
        refund.setRefundUpdated(updateTime.format(formatter));
        refund.setUserShippingStatus(douRefund.getAftersaleInfo().getGotPkg()+"");
        refund.setReturnLogisticsCompany(douRefund.getAftersaleInfo().getReturnLogisticsCompanyName());
        refund.setReturnLogisticsCode(douRefund.getAftersaleInfo().getReturnLogisticsCode());

        refund.setPlatformStatus(douRefund.getAftersaleInfo().getAftersaleStatus()+"");
        //售后状态 3-换货待买家收货；6-待商家同意；7-待买家退货；8-待商家发货；11-待商家二次同意；12-售后成功；14-换货成功；27-商家一次拒绝；28-售后失败；29-商家二次拒绝；
        if(douRefund.getAftersaleInfo().getAftersaleStatus()==3){
            refund.setPlatformStatusText("换货待买家收货");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==6){
            refund.setPlatformStatusText("待商家同意");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==7){
            refund.setPlatformStatusText("待买家退货");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==8){
            refund.setPlatformStatusText("待商家发货");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==11){
            refund.setPlatformStatusText("待商家二次同意");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==12){
            refund.setPlatformStatusText("售后成功");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==14){
            refund.setPlatformStatusText("换货成功");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==27){
            refund.setPlatformStatusText("商家一次拒绝");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==28){
            refund.setPlatformStatusText("售后失败");
        }else if(douRefund.getAftersaleInfo().getAftersaleStatus()==29){
            refund.setPlatformStatusText("商家二次拒绝");
        }

        for(var item : douRefund.getOrderInfo().getRelatedOrderInfo()) {
            refund.setOrderAmount(item.getPayAmount().doubleValue() / 100);
            refund.setOrderItemNum(item.getSkuOrderId());
            refund.setRefundAmount(item.getAftersalePayAmount().doubleValue() / 100);
            refund.setSkuId(null);
            refund.setProductId(item.getProductId().toString());
            refund.setSkuName(JSONObject.toJSONString(item.getSkuSpec()));
            refund.setSkuNum(item.getShopSkuCode());
            refund.setProductName(item.getProductName());
            refund.setProductImage(item.getProductImage());
            refund.setBuyNum(item.getItemNum());
            refund.setAfterNum(item.getAftersaleItemNum());
            LocalDateTime orderTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(item.getCreateTime()), ZoneId.of("UTC"));
            refund.setOrderTime(orderTime.format(formatter));
            refunds.add(refund);
        }
        return refunds;
    }

    public static ORefund transformWeiRefund(AfterSaleOrder weiRefund) {
        ORefund refund = new ORefund();
        refund.setRefundNum(weiRefund.getAfter_sale_order_id());
        // 类型(1-售前退款 10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)

        //售后类型。REFUND:退款；RETURN:退货退款；EXCHANGE:换货。
        if(weiRefund.getType().equals("REFUND")){
            refund.setRefundType(11);
        }else if(weiRefund.getType().equals("RETURN")){
            refund.setRefundType(10);
            refund.setShippingStatus(1);
        }else if(weiRefund.getType().equals("EXCHANGE")){
            refund.setRefundType(20);
            refund.setShippingStatus(1);
        }
        refund.setRefundReason(weiRefund.getReason_text());
        refund.setOrderNum(weiRefund.getOrder_id());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime createTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(weiRefund.getCreate_time()), ZoneId.of("UTC"));
        LocalDateTime updateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(weiRefund.getUpdate_time()), ZoneId.of("UTC"));
        refund.setRefundCreated(createTime.format(formatter));
        refund.setRefundUpdated(updateTime.format(formatter));

        refund.setUserShippingStatus(weiRefund.getDetails().getReceive_product()?"1":"0");

        refund.setReturnLogisticsCompany(weiRefund.getReturn_info().getDelivery_name());
        refund.setReturnLogisticsCode(weiRefund.getReturn_info().getWaybill_id());

        refund.setPlatformStatus(weiRefund.getStatus());
        //售后状态 3-换货待买家收货；6-待商家同意；7-待买家退货；8-待商家发货；11-待商家二次同意；12-售后成功；14-换货成功；27-商家一次拒绝；28-售后失败；29-商家二次拒绝；
        if(weiRefund.getStatus().equals("USER_CANCELD")){
            refund.setPlatformStatusText("用户取消申请");
        }else if(weiRefund.getStatus().equals("MERCHANT_PROCESSING")){
            refund.setPlatformStatusText("商家受理中");
        }else if(weiRefund.getStatus().equals("MERCHANT_REJECT_REFUND")){
            refund.setPlatformStatusText("商家拒绝退款");
        }else if(weiRefund.getStatus().equals("MERCHANT_REJECT_RETURN")){
            refund.setPlatformStatusText("商家拒绝退货退款");
        }else if(weiRefund.getStatus().equals("USER_WAIT_RETURN")){
            refund.setPlatformStatusText("待买家退货");
        }else if(weiRefund.getStatus().equals("RETURN_CLOSED")){
            refund.setPlatformStatusText("退货退款关闭");
        }else if(weiRefund.getStatus().equals("MERCHANT_WAIT_RECEIPT")){
            refund.setPlatformStatusText("待商家收货");
        }else if(weiRefund.getStatus().equals("MERCHANT_OVERDUE_REFUND")){
            refund.setPlatformStatusText("商家逾期未退款");
        }else if(weiRefund.getStatus().equals("MERCHANT_REFUND_SUCCESS")){
            refund.setPlatformStatusText("退款完成");
        }else if(weiRefund.getStatus().equals("MERCHANT_RETURN_SUCCESS")){
            refund.setPlatformStatusText("退货退款完成");
        }
        else if(weiRefund.getStatus().equals("PLATFORM_REFUNDING")) refund.setPlatformStatusText("平台退款中");
        else if(weiRefund.getStatus().equals("PLATFORM_REFUND_FAIL")) refund.setPlatformStatusText("平台退款失败");
        else if(weiRefund.getStatus().equals("USER_WAIT_CONFIRM")) refund.setPlatformStatusText("待用户确认");
        else if(weiRefund.getStatus().equals("MERCHANT_REFUND_RETRY_FAIL")) refund.setPlatformStatusText("商家打款失败，客服关闭售后");
        else if(weiRefund.getStatus().equals("MERCHANT_FAIL")) refund.setPlatformStatusText("售后关闭");
        else if(weiRefund.getStatus().equals("USER_WAIT_CONFIRM_UPDATE")) refund.setPlatformStatusText("待用户处理商家协商");
        else if(weiRefund.getStatus().equals("USER_WAIT_HANDLE_MERCHANT_AFTER_SALE")) refund.setPlatformStatusText("待用户处理商家代发起的售后申请");
        else if(weiRefund.getStatus().equals("WAIT_PACKAGE_INTERCEPT")) refund.setPlatformStatusText("物流线上拦截中");
        else if(weiRefund.getStatus().equals("MERCHANT_REJECT_EXCHANGE")) refund.setPlatformStatusText("商家拒绝换货");
        else if(weiRefund.getStatus().equals("MERCHANT_REJECT_RESHIP")) refund.setPlatformStatusText("商家拒绝发货");
        else if(weiRefund.getStatus().equals("USER_WAIT_RECEIPT")) refund.setPlatformStatusText("待用户收货");
        else if(weiRefund.getStatus().equals("MERCHANT_EXCHANGE_SUCCESS")) refund.setPlatformStatusText("换货完成");

//        refund.setOrderAmount(item.getPayAmount().doubleValue() / 100);
//        refund.setOrderItemNum(item.getSkuOrderId());
        refund.setRefundAmount(weiRefund.getRefund_info().getDouble("amount")/100);
        refund.setProductId(weiRefund.getProduct_info().getProduct_id());
        refund.setSkuId(weiRefund.getProduct_info().getSku_id());
        refund.setSkuName("");
        refund.setSkuNum(weiRefund.getProduct_info().getSku_code());
//        refund.setGoodsName(item.getProductName());
//        refund.setGoodsImage(item.getProductImage());
        refund.setBuyNum(weiRefund.getProduct_info().getCount());
        refund.setAfterNum(weiRefund.getProduct_info().getCount());
//        LocalDateTime orderTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(item.getCreateTime()), ZoneId.of("UTC"));
//        refund.setOrderTime(orderTime.format(formatter));

        return refund;
    }
}
