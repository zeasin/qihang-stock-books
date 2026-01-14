package cn.qihangerp.model.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.util.Date;

@Data
public class OrderItemImportVo {

    private String subOrderNum;
    private String orderNum;
    private Integer shopId;

    private String goodsImg;
    private String goodsNum;
    private String goodsTitle;
    private String goodsSpec;

    private String skuId;
    private String goodsId;
    private String skuNum;

    private Double goodsAmount;
    private Double itemAmount;
    private Double postAmount;
    private Double sellerDiscount;
    private Double platformDiscount;
    private Double paymentDiscount;
    private Double payment;
    private Double sellerAmount;

    private Integer quantity;
    private String remark;

    private String orderTime;
    private String refundStatusText;
    private String orderStatusText;

    private String shipTime;//发货时间
    private String deliveryTime;//收货时间
    private String expressCompany;
    private String expressCode;
}
