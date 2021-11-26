package com.gilin.Cms.Service.Impl;

import com.gilin.Cms.Mapper.CmsMemberMapper;
import com.gilin.Cms.Service.CmsMemberService;
import com.gilin.Cms.Vo.CmsMemberVo;
import com.gilin.Util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CmsMemberServiceImpl implements CmsMemberService {

    @Autowired
    CmsMemberMapper cmsMemberMapper;

    @Override
    public List<CmsMemberVo> getList() {
        return cmsMemberMapper.getList();
    }

    @Override
    public Map<String, Integer> getCount() {
        return cmsMemberMapper.getCount();
    }

    @Override
    public List<CmsMemberVo> getListSearch(HashMap<String, Object> params) {
        if(params.get("inq") != null)
            params.replace("inq", Util.makeForeach((String)params.get("inq"), ","));

        return cmsMemberMapper.getListSearch(params);
    }

    @Override
    public void adminFlagChange(CmsMemberVo cmsMemberVo) {
        cmsMemberMapper.adminFlagChange(cmsMemberVo);
    }


}
