package cn.qihangerp.api.common;

import cn.qihangerp.model.entity.OOrder;
import cn.qihangerp.model.entity.OOrderItem;
import cn.qihangerp.open.jd.response.JdOrderListResponse;
import cn.qihangerp.open.pdd.model.OrderItem;
import cn.qihangerp.open.tao.response.TaoOrderListResponse;
import com.alibaba.fastjson2.JSONObject;
import org.springframework.util.StringUtils;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ShopOrderTransform {

    public static OOrder transformTaoOrder(TaoOrderListResponse order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getTid());
        String buyerMemo = "";
        if(StringUtils.hasText(order.getBuyer_memo())){
            buyerMemo += order.getBuyer_memo();
        }
        if(StringUtils.hasText(order.getBuyer_message())){
            buyerMemo += order.getBuyer_message();
        }
        shopOrder.setBuyerMemo(buyerMemo);
        shopOrder.setSellerMemo(order.getSeller_memo());
        shopOrder.setPlatformOrderStatus(order.getStatus());
        //	交易状态。可选值:
        //	* TRADE_NO_CREATE_PAY(没有创建支付宝交易) * WAIT_BUYER_PAY(等待买家付款)
        //	* SELLER_CONSIGNED_PART(卖家部分发货)
        //	* WAIT_SELLER_SEND_GOODS(等待卖家发货,即:买家已付款) * WAIT_BUYER_CONFIRM_GOODS(等待买家确认收货,即:卖家已发货)
        //	* TRADE_BUYER_SIGNED(买家已签收,货到付款专用) * TRADE_FINISHED(交易成功) * TRADE_CLOSED(付款以后用户退款成功，交易自动关闭)
        //	* TRADE_CLOSED_BY_TAOBAO(付款以前，卖家或买家主动关闭交易)
        //	* PAY_PENDING(国际信用卡支付付款确认中) * WAIT_PRE_AUTH_CONFIRM(0元购合约中)
        //	* PAID_FORBID_CONSIGN(拼团中订单或者发货强管控的订单，已付款但禁止发货)


        //订单状态 0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12已关闭；12退款中；21待付款；22锁定，29删除，101部分发货
        if(order.getStatus().equals("TRADE_NO_CREATE_PAY")){
            shopOrder.setOrderStatus(21);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("没有创建支付宝交易");
        }else if (order.getStatus().equals("WAIT_BUYER_PAY")){
            shopOrder.setOrderStatus(21);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("等待买家付款");
        }else if (order.getStatus().equals("SELLER_CONSIGNED_PART")){
            shopOrder.setOrderStatus(101);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("卖家部分发货");
        }else if (order.getStatus().equals("WAIT_SELLER_SEND_GOODS")){
            shopOrder.setOrderStatus(1);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("等待卖家发货");
        }else if (order.getStatus().equals("WAIT_BUYER_CONFIRM_GOODS")){
            shopOrder.setOrderStatus(2);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("等待买家确认收货");
        }else if (order.getStatus().equals("TRADE_BUYER_SIGNED")){
            shopOrder.setOrderStatus(3);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("买家已签收");
        }else if (order.getStatus().equals("TRADE_FINISHED")){
            shopOrder.setOrderStatus(3);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("交易成功");
        }else if (order.getStatus().equals("TRADE_CLOSED")){
            shopOrder.setOrderStatus(12);
            shopOrder.setRefundStatus(4);
            shopOrder.setPlatformOrderStatusText("付款以后用户退款成功，交易自动关闭");
        }else if (order.getStatus().equals("TRADE_CLOSED_BY_TAOBAO")){
            shopOrder.setOrderStatus(11);
            shopOrder.setRefundStatus(4);
            shopOrder.setPlatformOrderStatusText("付款以前，卖家或买家主动关闭交易");
        }

        // 时间
        shopOrder.setOrderCreated(order.getCreated());
        shopOrder.setOrderUpdated(order.getModified());
        shopOrder.setOrderPayTime(order.getPay_time());
        shopOrder.setOrderFinishTime(order.getEnd_time());

        // 价格
        shopOrder.setGoodsAmount(Double.parseDouble(order.getTotal_fee()));
        shopOrder.setChangeAmount(Double.parseDouble(order.getAdjust_fee()));
        shopOrder.setPostFee(Double.parseDouble(order.getPost_fee()));
        shopOrder.setSellerDiscount(Double.parseDouble(order.getDiscount_fee()));
        shopOrder.setPlatformDiscount(0.0);
        shopOrder.setPayment(Double.parseDouble(order.getPayment()));
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(Double.parseDouble(order.getTotal_fee()));
        // 收货地址
        shopOrder.setReceiverName(order.getReceiver_name());
        shopOrder.setReceiverMobile(order.getReceiver_mobile());
        shopOrder.setAddress(order.getReceiver_address());
        shopOrder.setProvince(order.getReceiver_state());
        shopOrder.setCity(order.getReceiver_city());
        shopOrder.setTown(order.getReceiver_district());



        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getOrders() != null) {
            for (var line : order.getOrders()) {
                OOrderItem item = new OOrderItem();
                item.setOrderNum(shopOrder.getOrderNum());
                item.setSubOrderNum(line.getOid());
                item.setSkuId(line.getSku_id());
                item.setProductId(line.getNum_iid()+"");
                item.setProductTitle(line.getTitle());
                item.setProductImage(line.getPic_path());
                item.setGoodsNum("");
                item.setSkuName(line.getSku_properties_name());
                item.setSkuNum(line.getOuter_sku_id());

                item.setPrice(Double.parseDouble(line.getPrice()));
                item.setItemAmount(Double.parseDouble(line.getTotal_fee()));
                item.setPayment(Double.parseDouble(line.getPayment()));
                item.setChangeAmount(Double.parseDouble(line.getAdjust_fee()));
                Double discount = Double.parseDouble(line.getDiscount_fee());
                Double mjDiscount = Double.parseDouble(line.getPart_mjz_discount());
                item.setSellerDiscount(mjDiscount);
                item.setPlatformDiscount(discount-mjDiscount);

                item.setQuantity(line.getNum());
                item.setRefundCount(0);
                item.setRefundStatus(1);
//                item.setOrderStatus(shopOrder.getOrderStatus());
                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }

    public static OOrder transformJdOrder(JdOrderListResponse order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrderId());
        shopOrder.setBuyerMemo(order.getOrderRemark());
        shopOrder.setSellerMemo(order.getVenderRemark());
        shopOrder.setPlatformOrderStatus(order.getOrderState());
        //	1）WAIT_SELLER_STOCK_OUT 等待出库 2）WAIT_GOODS_RECEIVE_CONFIRM 等待确认收货 3）WAIT_SELLER_DELIVERY 等待发货（只适用于海外购商家，含义为'等待境内发货'标签下的订单,非海外购商家无需使用）
        //	4) POP_ORDER_PAUSE POP暂停 5）FINISHED_L 完成 6）TRADE_CANCELED 取消 7）LOCKED 已锁定 8）WAIT_SEND_CODE 等待发码
        shopOrder.setPlatformOrderStatusText(order.getOrderStateRemark());
        //订单状态 0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12退款中；21待付款；22锁定，29删除，101部分发货

        if(order.getOrderState().equals("WAIT_SELLER_STOCK_OUT")||order.getOrderState().equals("WAIT_SELLER_DELIVERY")){
            shopOrder.setOrderStatus(1);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderState().equals("WAIT_GOODS_RECEIVE_CONFIRM")){
            shopOrder.setOrderStatus(2);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderState().equals("POP_ORDER_PAUSE")||order.getOrderState().equals("LOCKED")||order.getOrderState().equals("WAIT_SEND_CODE")){
            shopOrder.setOrderStatus(22);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderState().equals("FINISHED_L")){
            shopOrder.setOrderStatus(3);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderState().equals("TRADE_CANCELED")){
            shopOrder.setOrderStatus(11);
            shopOrder.setRefundStatus(4);
        }

        // 时间
        shopOrder.setOrderCreated(order.getOrderStartTime());
        shopOrder.setOrderUpdated(order.getModified());
        shopOrder.setOrderPayTime(order.getPaymentConfirmTime());
        shopOrder.setOrderFinishTime(order.getOrderEndTime());

        // 价格
        shopOrder.setGoodsAmount(Double.parseDouble(order.getOrderTotalPrice()));
        shopOrder.setChangeAmount(0.0);
        shopOrder.setPostFee(Double.parseDouble(order.getFreightPrice()));
        shopOrder.setSellerDiscount(Double.parseDouble(order.getSellerDiscount()));
        shopOrder.setPlatformDiscount(0.0);
        shopOrder.setPayment(Double.parseDouble(order.getOrderPayment()));
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(Double.parseDouble(order.getOrderTotalPrice()));
        // 收货地址
        shopOrder.setReceiverName(order.getConsigneeInfo().getFullname());
        shopOrder.setReceiverMobile(order.getConsigneeInfo().getMobile());
        shopOrder.setAddress(order.getConsigneeInfo().getFullAddress());
        shopOrder.setProvince(order.getConsigneeInfo().getProvince());
        shopOrder.setCity(order.getConsigneeInfo().getCity());
        shopOrder.setTown(order.getConsigneeInfo().getTown());

        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getItemInfoList() != null) {
            for (var line : order.getItemInfoList()) {
                OOrderItem item = new OOrderItem();
                item.setOrderNum(shopOrder.getOrderNum());
                item.setSubOrderNum(shopOrder.getOrderNum()+"-"+line.getSkuId());
                item.setProductId(line.getWareId());
                item.setSkuId(line.getSkuId());
                item.setProductTitle(line.getSkuName());
                item.setProductImage("");
                item.setGoodsNum("");
                item.setSkuName("");
                item.setPrice(Double.parseDouble(line.getJdPrice()));
                item.setSkuNum(line.getOuterSkuId());
                item.setItemAmount(item.getPrice()* Double.parseDouble(line.getItemTotal()));
                item.setChangeAmount(0.0);
                item.setSellerDiscount(0.0);
                item.setPlatformDiscount(0.0);
                item.setPayment(item.getItemAmount());
                item.setQuantity(Integer.parseInt(line.getItemTotal()));
                item.setRefundCount(0);
                item.setRefundStatus(1);
//                item.setOrderStatus(shopOrder.getOrderStatus());
                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }

    public static OOrder transformDouOrder(cn.qihangerp.open.dou.model.order.Order order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrderId());
        shopOrder.setBuyerMemo(order.getBuyerWords());
        shopOrder.setSellerMemo(order.getSellerWords());
        shopOrder.setPlatformOrderStatus(order.getOrderStatus().toString());
        shopOrder.setPlatformOrderStatusText(order.getOrderStatusDesc());
        //订单状态 0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12退款中；21待付款；22锁定，29删除，101部分发货
        //订单状态 1 待确认/待支付（订单创建完毕）105 已支付 2 备货中 101 部分发货 3 已发货（全部发货）4 已取消5 已完成（已收货）
        if(order.getOrderStatus()==1){
            shopOrder.setOrderStatus(21);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==2){
            shopOrder.setOrderStatus(1);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==3){
            shopOrder.setOrderStatus(2);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==4){
            shopOrder.setOrderStatus(11);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==5){
            shopOrder.setOrderStatus(3);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==105){
            shopOrder.setOrderStatus(0);
            shopOrder.setRefundStatus(1);
        }else if (order.getOrderStatus()==101){
            shopOrder.setOrderStatus(101);
            shopOrder.setRefundStatus(1);
        }

        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime createTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getCreateTime()), ZoneId.of("UTC"));
        LocalDateTime updateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getUpdateTime()), ZoneId.of("UTC"));
        LocalDateTime payTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getPayTime()), ZoneId.of("UTC"));
        LocalDateTime finishTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getFinishTime()), ZoneId.of("UTC"));

        shopOrder.setOrderCreated(createTime.format(formatter));
        shopOrder.setOrderUpdated(updateTime.format(formatter));
        shopOrder.setOrderPayTime(payTime.format(formatter));
        shopOrder.setOrderFinishTime(finishTime.format(formatter));

        // 价格
        Double orderAmount = order.getOrderAmount().doubleValue() / 100;
        Double postAmount = order.getPostAmount().doubleValue() / 100;
        Double payAmount = order.getPayAmount().doubleValue() / 100;
        Double modifyAmount = order.getModifyAmount().doubleValue() / 100;
        Double promotionShopAmount = order.getPromotionShopAmount().doubleValue() / 100;
        Double promotionPlatformAmount = order.getPromotionPlatformAmount().doubleValue() / 100;


        shopOrder.setGoodsAmount(orderAmount);
        shopOrder.setChangeAmount(modifyAmount);
        shopOrder.setPostFee(postAmount);
        shopOrder.setSellerDiscount(promotionShopAmount);
        shopOrder.setPlatformDiscount(promotionPlatformAmount);
        shopOrder.setPayment(payAmount);
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(orderAmount);
        // 收货地址
        shopOrder.setProvince(order.getMaskPostAddr().getProvince().getName());
        shopOrder.setCity(order.getMaskPostAddr().getCity().getName());
        shopOrder.setTown(order.getMaskPostAddr().getTown().getName());
        if(order.getOrderStatus()==2){
            shopOrder.setAddress(order.getMaskPostAddr().getDetail());
//            shopOrder.setReceiverName(order.getMaskPostReceiver());
            shopOrder.setReceiverName(order.getSkuOrderList().get(0).getMaskPostReceiver());
            shopOrder.setReceiverMobile(order.getMaskPostTel());
        }


        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getSkuOrderList() != null) {
            for (cn.qihangerp.open.dou.model.order.OrderItem line : order.getSkuOrderList()) {

                OOrderItem item = new OOrderItem();
                item.setOrderNum(line.getParentOrderId());
                item.setSubOrderNum(line.getOrderId());
                item.setProductId(line.getProductIdStr());
                item.setSkuId(line.getSkuId()+"");
                item.setProductTitle(line.getProductName());
                item.setProductImage(line.getProductPic());
                item.setGoodsNum(line.getOutProductId());
                item.setSkuName(JSONObject.toJSONString(line.getSpec()));
                item.setSkuNum(line.getOutSkuId());

                item.setPrice(line.getGoodsPrice().doubleValue()/100);
                item.setItemAmount( line.getOrderAmount().doubleValue()/100);
                item.setPayment(line.getPayAmount().doubleValue()/100);
                item.setSellerDiscount(line.getPromotionShopAmount().doubleValue()/100);
                item.setPlatformDiscount(line.getPromotionShopAmount().doubleValue()/100);
                item.setChangeAmount(line.getModifyAmount().doubleValue()/100);

                item.setQuantity(line.getItemNum());
                //主流程状态，1 待确认/待支付（订单创建完毕）103 部分支付105 已支付2 备货中101 部分发货3 已发货（全部发货）4 已取消5 已完成（已收货）21 发货前退款完结22 发货后退款完结39 收货后退款完结
                if(line.getMainStatus() == 4 || line.getMainStatus() == 21 || line.getMainStatus() == 22 || line.getMainStatus() == 39){
                    item.setRefundCount(line.getItemNum());
                    item.setRefundStatus(4);
                }else{
                    item.setRefundCount(0);
                    item.setRefundStatus(1);
                }
//                item.setOrderStatus(line.getOrderStatus());

                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }

    public static OOrder transformPddOrder(cn.qihangerp.open.pdd.model.Order order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrderSn());
        shopOrder.setBuyerMemo(order.getBuyerMemo());
        shopOrder.setSellerMemo(order.getRemark());
        shopOrder.setRefundStatus(order.getRefundStatus());
        if(order.getRefundStatus()==1){
            shopOrder.setOrderStatus(order.getOrderStatus());
        }else{
            shopOrder.setOrderStatus(11);//已取消
        }
        shopOrder.setPlatformOrderStatus(order.getOrderStatus()+"");
        //发货状态，枚举值：1：待发货，2：已发货待签收，3：已签收
        if(order.getOrderStatus()==1){
            shopOrder.setPlatformOrderStatusText("待发货");
        }else if (order.getOrderStatus()==2){
            shopOrder.setPlatformOrderStatusText("已发货待签收");
        }else if (order.getOrderStatus()==3){
            shopOrder.setPlatformOrderStatusText("已签收");
        }
        shopOrder.setOrderCreated(order.getCreatedTime());
        shopOrder.setOrderUpdated(order.getUpdatedAt());
        shopOrder.setOrderPayTime(order.getPayTime());
        shopOrder.setOrderFinishTime(order.getReceiveTime());
        // 价格
        shopOrder.setGoodsAmount(order.getGoodsAmount());
        shopOrder.setChangeAmount(order.getOrderChangeAmount());
        shopOrder.setPostFee(order.getPostage());
        shopOrder.setSellerDiscount(order.getSellerDiscount());
        shopOrder.setPlatformDiscount(order.getPlatformDiscount());
        shopOrder.setPayment(order.getPayAmount());
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(shopOrder.getGoodsAmount());
        // 收货地址
        shopOrder.setProvince(order.getProvince());
        shopOrder.setCity(order.getCity());
        shopOrder.setTown(order.getTown());
        if(order.getOrderStatus()==1){
            shopOrder.setAddress(order.getReceiverAddressMask());
            shopOrder.setReceiverName(order.getReceiverNameMask());
            shopOrder.setReceiverMobile(order.getReceiverPhoneMask());
        }


        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getItemList() != null) {
            for (OrderItem line : order.getItemList()) {
                OOrderItem item = new OOrderItem();
                item.setOrderNum(shopOrder.getOrderNum());
                item.setSubOrderNum(shopOrder.getOrderNum()+"-"+line.getSkuId());
                item.setProductId(line.getGoodsId()+"");
                item.setSkuId(line.getSkuId()+"");
                item.setProductTitle(line.getGoodsName());
                item.setProductImage(line.getGoodsImg());
                item.setGoodsNum(line.getOuterGoodsId());
                item.setSkuName(line.getGoodsSpec());
                item.setPrice(line.getGoodsPrice());
                item.setSkuNum(line.getOuterId());
                item.setItemAmount(shopOrder.getAmount());
                item.setSellerDiscount(shopOrder.getSellerDiscount());
                item.setPlatformDiscount(shopOrder.getPlatformDiscount());
                item.setChangeAmount(shopOrder.getChangeAmount());
                item.setPayment(shopOrder.getPayment());
                item.setQuantity(line.getGoodsCount());
                item.setRefundStatus(order.getRefundStatus());
                if(order.getRefundStatus()==1){
                    item.setRefundCount(0);
                }else {
                    item.setRefundStatus(line.getGoodsCount());
                }
//                item.setOrderStatus(order.getOrderStatus());

                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }

    public static OOrder transformWeiOrder(cn.qihangerp.open.wei.model.Order order) {
        OOrder shopOrder = new OOrder();
        shopOrder.setOrderNum(order.getOrder_id());
        shopOrder.setBuyerMemo("");
        shopOrder.setSellerMemo("");
        shopOrder.setPlatformOrderStatus(order.getStatus().toString());
        //	状态
        //	10	待付款；20	待发货；21	部分发货；30	待收货；100	完成；200	全部商品售后之后，订单取消；250	未付款用户主动取消或超时未付款订单自动取消；


        //订单状态 0：新订单，1：待发货，2：已发货，3：已完成，11已取消；12已关闭；12退款中；21待付款；22锁定，29删除，101部分发货
        if(order.getStatus().intValue()==10){
            shopOrder.setOrderStatus(21);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("待付款");
        }else if (order.getStatus().intValue()==21){
            shopOrder.setOrderStatus(101);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("部分发货");
        }else if (order.getStatus().intValue()==20){
            shopOrder.setOrderStatus(1);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("待发货");
        }else if (order.getStatus().intValue()==30){
            shopOrder.setOrderStatus(2);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("待收货");
        }else if (order.getStatus().intValue()==100){
            shopOrder.setOrderStatus(3);
            shopOrder.setRefundStatus(1);
            shopOrder.setPlatformOrderStatusText("完成");
        }else if (order.getStatus().intValue()==200){
            shopOrder.setOrderStatus(12);
            shopOrder.setRefundStatus(4);
            shopOrder.setPlatformOrderStatusText("全部商品售后之后，订单取消");
        }else if (order.getStatus().intValue()==250){
            shopOrder.setOrderStatus(11);
            shopOrder.setRefundStatus(4);
            shopOrder.setPlatformOrderStatusText("未付款用户主动取消或超时未付款订单自动取消");
        }

        // 定义日期时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime createTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getCreate_time()), ZoneId.of("UTC"));
        LocalDateTime updateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getUpdate_time()), ZoneId.of("UTC"));
        LocalDateTime payTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getOrder_detail().getPay_info().getLong("prepay_time")), ZoneId.of("UTC"));
        LocalDateTime finishTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(order.getOrder_detail().getSettle_info().getLong("settle_time")), ZoneId.of("UTC"));
        shopOrder.setOrderCreated(createTime.format(formatter));
        shopOrder.setOrderUpdated(updateTime.format(formatter));
        shopOrder.setOrderPayTime(payTime.format(formatter));
        shopOrder.setOrderFinishTime(finishTime.format(formatter));

        // 价格
        Integer goodsAmount = order.getOrder_detail().getPrice_info().getInteger("product_price");
        Integer orderAmount = order.getOrder_detail().getPrice_info().getInteger("order_price");
        Integer freight = order.getOrder_detail().getPrice_info().getInteger("freight");
        Integer discounted = order.getOrder_detail().getPrice_info().getInteger("discounted_price");

        shopOrder.setGoodsAmount(goodsAmount.doubleValue()/100);
        shopOrder.setChangeAmount(0.0);
        shopOrder.setPostFee(freight.doubleValue()/100);
        shopOrder.setSellerDiscount(discounted.doubleValue()/100);
        shopOrder.setPlatformDiscount(0.0);
        shopOrder.setPayment(orderAmount.doubleValue()/100);
        shopOrder.setServiceFee(0.0);
        shopOrder.setAmount(orderAmount.doubleValue()/100);
        // 收货地址
        var addressInfo = order.getOrder_detail().getDelivery_info().getAddress_info();
        shopOrder.setReceiverName(addressInfo.getUser_name());
        shopOrder.setReceiverMobile(addressInfo.getTel_number());
        shopOrder.setAddress(addressInfo.getDetail_info());
        shopOrder.setProvince(addressInfo.getProvince_name());
        shopOrder.setCity(addressInfo.getCity_name());
        shopOrder.setTown(addressInfo.getCounty_name());



        // 订单明细
        List<OOrderItem> itemList = new ArrayList<>();
        if (order.getOrder_detail().getProduct_infos() != null) {
            for (var line : order.getOrder_detail().getProduct_infos()) {
                OOrderItem item = new OOrderItem();
                item.setOrderNum(shopOrder.getOrderNum());
                item.setSubOrderNum(shopOrder.getOrderNum()+"-"+line.getSku_id());
                item.setProductId(line.getProduct_id());
                item.setSkuId(line.getSku_id());
                item.setProductTitle(line.getTitle());
                item.setProductImage(line.getThumb_img());
                item.setGoodsNum(line.getOut_product_id());
                item.setSkuName(JSONObject.toJSONString(line.getSku_attrs()));
                item.setSkuNum(line.getOut_sku_id());
                // 价格
                item.setPrice(line.getSale_price().doubleValue()/100);
                item.setItemAmount(line.getReal_price().doubleValue()/100);
                if(line.getChange_price()==null){
                    line.setChange_price(0);
                }
                Integer changeAmount = line.getSale_price() * line.getSku_cnt() - line.getChange_price();
                item.setChangeAmount(changeAmount.doubleValue()/100);
                item.setSellerDiscount(line.getMerchant_discounted_price().doubleValue()/100);
                item.setPlatformDiscount(0.0);

                item.setPayment(item.getItemAmount());
                item.setQuantity(line.getSku_cnt());
                item.setRefundCount(0);
                item.setRefundStatus(1);
//                item.setOrderStatus(shopOrder.getOrderStatus());
                itemList.add(item);
            }
        }
        shopOrder.setItemList(itemList);
        return shopOrder;
    }

}
