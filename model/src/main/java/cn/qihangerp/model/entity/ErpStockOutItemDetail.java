package cn.qihangerp.model.entity;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 出库仓位详情
 * @TableName wms_stock_out_item_position
 */
@Data
public class ErpStockOutItemDetail implements Serializable {
    /**
     * 主键ID
     */
    private Long id;

    /**
     * 出库单ID
     */
    private Long entryId;

    /**
     * 出库单ItemID
     */
    private Long entryItemId;

    /**
     * 库存ID
     */
    private Long inventoryId;

    /**
     * 库存详情ID
     */
    private Long inventoryBatchId;
    /**
     * 商品id
     */
    private String goodsId;
    private String goodsTitle;
    private String goodsImg;
    private String goodsNum;

    /**
     * 商品规格id
     */
    private String goodsSkuId;

    /**
     * 规格编码
     */
    private String skuCode;
    private String skuName;

    /**
     * 出库数量
     */
    private Integer quantity;

    /**
     * 出库仓位ID
     */
    private Long warehouseId;
    private String warehouseName;
    private Long positionId;
    private String positionNum;

    /**
     * 出库操作人userid
     */
    private Long operatorId;

    /**
     * 出库操作人
     */
    private String operatorName;

    /**
     * 出库时间
     */
    private Date outTime;
    private String remark;

    private static final long serialVersionUID = 1L;
}