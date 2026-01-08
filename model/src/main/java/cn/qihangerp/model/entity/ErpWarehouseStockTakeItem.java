package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * 盘点明细
 * @TableName erp_warehouse_stock_take_item
 */
@TableName(value ="erp_warehouse_stock_take_item")
@Data
public class ErpWarehouseStockTakeItem {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 盘点id
     */
    private Long stockTakeId;

    /**
     * 商品id
     */
    private Long goodsId;

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
     * 
     */
    private Long skuId;

    /**
     * 
     */
    private String skuCode;

    /**
     * 颜色
     */
    private String skuName;

    /**
     * 原始数量
     */
    private Integer quantity;

    /**
     * 盘点数量
     */
    private Integer takeQuantity;

    /**
     * 盘点差异数量
     */
    private Integer resultQty;

    /**
     * 盘点结果（0未出结果10盘平20盘盈30盘亏）
     */
    private Integer result;

    /**
     * 盘点处理id（盘盈入库单id，盘亏出库单id）
     */
    private Long resultId;

    /**
     * 备注
     */
    private String remark;

    /**
     * 状态（0待盘点2已盘点）
     */
    private Integer status;

    /**
     * 创建人
     */
    private String createBy;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新人
     */
    private String updateBy;

    /**
     * 更新时间
     */
    private Date updateTime;

    /**
     * 仓库id
     */
    private Long warehouseId;
}