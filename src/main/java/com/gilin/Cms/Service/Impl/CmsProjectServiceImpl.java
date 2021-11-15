package com.gilin.Cms.Service.Impl;

import com.gilin.Cms.Mapper.CmsProjectMapper;
import com.gilin.Cms.Service.CmsProjectService;

import com.gilin.Cms.Vo.CmsProjectVo;
import com.gilin.Util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CmsProjectServiceImpl implements CmsProjectService {

    @Autowired
    CmsProjectMapper cmsProjectMapper;

    @Override
    public List<CmsProjectVo> getProjectList() {
        return cmsProjectMapper.getProjectList();
    }

    @Override
    public Map<String, Integer> getProjectCount() {
        return cmsProjectMapper.getProjectCount();
    }

    @Override
    public List<CmsProjectVo> getListBySearch(HashMap<String, Object> params) {
        if(params.get("inq") != "")
            params.replace("inq", Util.makeForeach((String)params.get("inq"), ","));

        return cmsProjectMapper.getListBySearch(params);
    }

    @Override
    public void update(CmsProjectVo cmsProjectVo) {
        cmsProjectMapper.update(cmsProjectVo);
    }

    @Override
    public void create(HashMap<String, Object> params) {
        cmsProjectMapper.create(params);
    }

    @Override
    public void delete(HashMap<String, Object> params) {
        cmsProjectMapper.delete(params);
    }
}
