package cn.qihangerp.api.common;

import cn.qihangerp.common.enums.PddRefundStatusEnum;
import cn.qihangerp.model.entity.ORefund;

public class ShopRefundTransform {
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
        refund.setGoodsName(jdRefund.getWareName());
//        refund.setGoodsImage(pddRefund.getGoodImage());
        refund.setQuantity(jdRefund.getServiceCount());
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
        refund.setGoodsName(pddRefund.getGoodsName());
        refund.setGoodsImage(pddRefund.getGoodImage());
        refund.setQuantity(pddRefund.getGoodsNumber());
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
}
