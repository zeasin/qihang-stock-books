package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 退换货表
 * @TableName o_refund
 */
@Data
public class ORefund implements Serializable {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private String id;

    /**
     * 退货单号
     */
    private String refundNum;

    /**
     * 类型(10-退货 20-换货 30-维修 40-大家电安装 50-大家电移机 60-大家电增值服务 70-上门维修 90-优鲜赔 80-补发商品 100-试用收回 11-仅退款)
     */
    private Integer refundType;

    /**
     * 店铺id
     */
    private Long shopId;

    /**
     * 店铺类型
     */
    private Integer shopType;

    /**
     * 源订单号
     */
    private String orderNum;
    private Double orderAmount;
    private Double refundAmount;
    private String refundReason;

    /**
     * 子订单号或id
     */
    private String orderItemNum;

    /**
     * 源skuId
     */
    private String skuId;

    /**
     * erp商品id
     */
    private Long goodsId;

    /**
     * erp sku id
     */
    private Long goodsSkuId;
    private Long orderId;
    private Long orderItemId;

    private String userShippingStatus;
    private Integer hasGoodReturn;

    /**
     * sku编码
     */
    private String skuNum;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 商品sku
     */
    private String skuName;

    /**
     * 商品图片
     */
    private String goodsImage;

    /**
     * 退货数量
     */
    private Integer quantity;

    /**
     * 退货物流公司
     */
    private String returnLogisticsCompany;

    /**
     * 退货物流单号
     */
    private String returnLogisticsCode;

    /**
     * 收货时间
     */
    private Date receiveTime;

    /**
     * 备注
     */
    private String remark;



    /**
     * 状态（0待发货1待收货2已收货3已完成）
     */
    private Integer status;
    private String platformStatus;
    private String platformStatusText;
    private String refundCreated;
    private String refundUpdated;
    private String orderTime;

    /**
     * 订单创建时间
     */
    private Date createTime;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 更新人
     */
    private String updateBy;

    private Integer hasProcessing;
    private String afterSaleId;

    private static final long serialVersionUID = 1L;

}