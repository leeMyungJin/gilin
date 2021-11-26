package com.gilin.Cms.Service;
import com.gilin.Cms.Vo.CmsMemberVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CmsMemberService {

    public List<CmsMemberVo> getList();

    public Map<String, Integer> getCount();

    public List<CmsMemberVo> getListSearch(HashMap<String,Object> params);

    public void adminFlagChange(CmsMemberVo cmsMemberVo);

}
