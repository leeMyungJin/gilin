package com.gilin.Cms.Service.Impl;

import com.gilin.Cms.Mapper.CmsChannelMapper;
import com.gilin.Cms.Service.CmsChannelService;
import com.gilin.Cms.Vo.CmsChannelVo;
import com.gilin.Util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CmsChannelServiceImpl implements CmsChannelService {

    @Autowired
    CmsChannelMapper cmsChannelMapper;

    @Override
    public List<CmsChannelVo> getList() {
        return cmsChannelMapper.getList();
    }

    @Override
    public Map<String, Integer> getCount() {
        return cmsChannelMapper.getCount();
    }

    @Override
    public List<CmsChannelVo> getListBySearch(HashMap<String, Object> params) {

        if(params.get("inq") != "")
            params.replace("inq", Util.makeForeach((String)params.get("inq"), ","));

        return cmsChannelMapper.getListBySearch(params);
    }

    @Override
    public void update(CmsChannelVo cmsChannelVo) {
        cmsChannelMapper.update(cmsChannelVo);
    }

    @Override
    public void delete(CmsChannelVo cmsChannelVo) {
        cmsChannelMapper.delete(cmsChannelVo);
    }

    @Override
    public void insert(CmsChannelVo cmsChannelVo) {
        cmsChannelMapper.insert(cmsChannelVo);
    }

    @Override
    public void create(CmsChannelVo cmsChannelVo) {
        cmsChannelMapper.create(cmsChannelVo);
    }

    @Override
    public CmsChannelVo validationByName(String chName) {
        return cmsChannelMapper.validationByName(chName);
    }

    @Override
    public List<CmsChannelVo> getSchedulerList() {
        return cmsChannelMapper.getSchedulerList();
    }

    @Override
    public List<CmsChannelVo> getChannelEndSchedulerList() {
        return cmsChannelMapper.getChannelEndSchedulerList();
    }


}
