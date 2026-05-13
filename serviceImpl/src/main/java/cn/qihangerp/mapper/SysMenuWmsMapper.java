package cn.qihangerp.mapper;

import cn.qihangerp.model.entity.SysMenuWms;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
* @author 1
* @description 针对表【sys_menu_wms(菜单权限表)】的数据库操作Mapper
* @createDate 2025-12-02 12:18:57
* @Entity cn.qihangerp.module.domain.SysMenuWms
*/
public interface SysMenuWmsMapper extends BaseMapper<SysMenuWms> {
    List<SysMenuWms> selectMenuTreeAll();
}




