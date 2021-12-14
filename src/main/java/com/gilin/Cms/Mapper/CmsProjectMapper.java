package com.gilin.Cms.Mapper;

import com.gilin.Cms.Vo.CmsProjectVo;

import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface CmsProjectMapper {

    public List<CmsProjectVo> getProjectList();
    public Map<String, Integer> getProjectCount();
    public List<CmsProjectVo> getListBySearch(HashMap<String, Object> params);
    public void update(CmsProjectVo cmsProjectVo);
    public void create(CmsProjectVo cmsProjectVo);
    public void delete(HashMap<String, Object> params);
    public void projectActiveChanger(HashMap<String, Object> params);

}