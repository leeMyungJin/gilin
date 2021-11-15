package com.gilin.Cms.Mapper;

import com.gilin.Cms.Vo.CmsChannelVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface CmsChannelMapper {

    public List<CmsChannelVo> getList();
    public Map<String, Integer> getCount();
    public List<CmsChannelVo> getListBySearch(HashMap<String, Object> params);
    public void update(CmsChannelVo cmsChannelVo);
    public void delete(CmsChannelVo cmsChannelVo);
    public void insert(CmsChannelVo cmsChannelVo);
    public void create(CmsChannelVo cmsChannelVo);
    public CmsChannelVo validationByName(String chName);

}