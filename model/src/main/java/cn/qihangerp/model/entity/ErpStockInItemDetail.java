package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 出库仓位详情
 * @TableName erp_stock_in_item_detail
 */
@Data
@TableName(value ="erp_stock_in_item_detail")
public class ErpStockInItemDetail {
    /**
     * 主键ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 出库单ID
     */
    private Long stockInId;
    private String stockInNum;
    private String stockInSourceNo;

    /**
     * 出库单ItemID
     */
    private Long stockInItemId;

    /**
     * 库存ID
     */
    private Long goodsInventoryId;

    /**
     * 库存详情ID
     */
    private Long goodsInventoryBatchId;
    /**
     * 商品id
     */
    private String goodsId;

    /**
     * 商品编码
     */
    private String goodsNum;

    /**
     * 商品名称
     */
    private String goodsName;

    /**
     * 商品图片
     */
    private String goodsImage;

    /**
     * 商品规格id
     */
    private String skuId;

    /**
     * 商品规格编码
     */
    private String skuCode;

    /**
     * 颜色
     */
    private String skuName;
    /**
     * 出库数量
     */
    private Integer quantity;

    /**
     * 仓库ID
     */
    private Long warehouseId;

    /**
     * 仓位id
     */
    private Long positionId;

    /**
     * 仓位编码
     */
    private String positionNum;

    /**
     * 入库操作人userid
     */
    private Long operatorId;

    /**
     * 入库操作人
     */
    private String operatorName;

    /**
     * 创建时间
     */
    private Date createTime;

}