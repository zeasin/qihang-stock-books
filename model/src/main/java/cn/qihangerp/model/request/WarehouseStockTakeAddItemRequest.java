package cn.qihangerp.model.request;

import lombok.Data;

import java.util.List;

@Data
public class WarehouseStockTakeAddItemRequest {
    private Long id;//ID
    private List<Item> itemList;

    @Data
    public static class Item{
        private Long id;//主键id,如果有值代表是已经存在的item记录
        private Long goodsId;//商品主键id
        private Long skuId;//商品Sku主键id
        private Integer quantity;//盘点结果
    }
}
