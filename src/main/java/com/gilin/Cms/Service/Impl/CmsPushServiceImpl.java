package com.gilin.Cms.Service.Impl;


import com.gilin.Cms.Mapper.CmsPushMapper;
import com.gilin.Cms.Service.CmsPushService;
import com.gilin.Cms.Vo.CmsPushVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CmsPushServiceImpl implements CmsPushService {


    @Autowired
    CmsPushMapper cmsPushMapper;

    @Override
    public List<CmsPushVo> getListBySearch(HashMap<String, Object> params) {
        return cmsPushMapper.getListBySearch(params);
    }

    @Override
    public void update(CmsPushVo cmsPushVo) {
        cmsPushMapper.update(cmsPushVo);
    }

    @Override
    public void create(HashMap<String, Object> params) {
        cmsPushMapper.create(params);
    }

}
