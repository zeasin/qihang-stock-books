package cn.qihangerp.api.request;

import lombok.Data;

@Data
public class OrderItemUpdateSkuRequest {
    private Long id;//订单itemId
    private String erpSkuId;//系统skuId
}
