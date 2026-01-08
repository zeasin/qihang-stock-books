package cn.qihangerp.model.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 仓库盘点表
 * @TableName erp_warehouse_stock_take
 */
@TableName(value ="erp_warehouse_stock_take")
@Data
public class ErpWarehouseStockTake {
    /**
     * 
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 盘点日期
     */
    private String stockTakeDate;

    /**
     * 盘点人
     */
    private String stockTakeMan;

    /**
     * 商品sku数
     */
    private Integer skuUnit;

    /**
     * 盘盈数量
     */
    private Integer panyingUnit;

    /**
     * 盘亏数量
     */
    private Integer pankuiUnit;

    /**
     * 总件数
     */
    private Integer totalQuantity;

    /**
     * 总结果件数
     */
    private Integer resultQuantity;

    /**
     * 备注
     */
    private String remark;

    /**
     * 状态（0已创建1盘点中2盘点完成）
     */
    private Integer status;

    /**
     * 处理结果
     */
    private String result;

    /**
     * 云仓ID
     */
    private Long warehouseId;

    /**
     * 云仓名
     */
    private String warehouseName;

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
     * 首次盘点时间
     */
    private Date firstTakeTime;

    /**
     * 完成时间
     */
    private Date completeTime;

    @TableField(exist = false)
    private List<ErpWarehouseStockTakeItem> itemList;
}