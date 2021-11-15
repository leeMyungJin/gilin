package com.gilin.Cms.Service.Impl;


import com.gilin.Cms.Mapper.CmsTermsMapper;
import com.gilin.Cms.Service.CmsTermsService;
import com.gilin.Cms.Vo.CmsTermsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CmsTermsServiceImpl implements CmsTermsService {

    @Autowired
    private CmsTermsMapper termsMapper;

    @Override
    public List<CmsTermsVo> getTerms() {
        return termsMapper.getTerms();
    }

    @Override
    public void termsUpdate(CmsTermsVo cmsTermsVo) {
        termsMapper.termsUpdate(cmsTermsVo);
    }
}
