package com.gilin.Cms.Service;

import com.gilin.Cms.Vo.CmsTermsVo;

import java.util.List;

public interface CmsTermsService {

    public List<CmsTermsVo> getTerms();

    public void termsUpdate(CmsTermsVo cmsTermsVo);

}
