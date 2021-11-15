package com.gilin.Cms.Mapper;


import com.gilin.Cms.Vo.CmsTermsVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CmsTermsMapper {

    public List<CmsTermsVo> getTerms();

    public void termsUpdate(CmsTermsVo cmsTermsVo);

}
