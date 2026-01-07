package cn.qihangerp.service.service.impl;

import cn.qihangerp.common.PageQuery;
import cn.qihangerp.common.PageResult;
import cn.qihangerp.model.entity.ErpStockOut;
import cn.qihangerp.service.mapper.ErpStockOutItemMapper;
import cn.qihangerp.model.entity.ErpStockOutItem;
import cn.qihangerp.service.service.ErpStockOutItemService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* @author qilip
* @description 针对表【wms_stock_out_item(出库单明细)】的数据库操作Service实现
* @createDate 2024-09-22 11:13:23
*/
@Service
public class ErpStockOutItemServiceImpl extends ServiceImpl<ErpStockOutItemMapper, ErpStockOutItem>
    implements ErpStockOutItemService {

    @Override
    public PageResult<ErpStockOutItem> queryPageList(ErpStockOutItem bo, PageQuery pageQuery) {
        LambdaQueryWrapper<ErpStockOutItem> queryWrapper = new LambdaQueryWrapper<ErpStockOutItem>()
                .eq( bo.getStatus()!=null, ErpStockOutItem::getStatus, bo.getStatus())
                .eq( bo.getStockOutType()!=null, ErpStockOutItem::getStockOutType, bo.getStockOutType())
                .eq( bo.getEntryId()!=null, ErpStockOutItem::getEntryId, bo.getEntryId())
                .like(StringUtils.hasText(bo.getEntryNum()), ErpStockOutItem::getEntryNum, bo.getEntryNum())
                ;

        Page<ErpStockOutItem> pages = this.baseMapper.selectPage(pageQuery.build(), queryWrapper);
        return PageResult.build(pages);
    }
}




