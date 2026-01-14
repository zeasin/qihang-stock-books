package cn.qihangerp.model.request;

import cn.qihangerp.model.vo.OrderItemImportVo;
import lombok.Data;

import java.util.List;

@Data
public class OrderImportRequest {
    private Long shopId;
    private List<OrderItemImportVo> itemList;
    private String[] orderNums;
}
