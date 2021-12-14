package com.gilin.Cms.Service;



import com.gilin.Cms.Vo.CmsProjectVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CmsProjectService {

    public List<CmsProjectVo> getProjectList();
    public Map<String, Integer> getProjectCount();
    public List<CmsProjectVo> getListBySearch(HashMap<String, Object> params);
    public void update(CmsProjectVo cmsProjectVo);
    public void create(CmsProjectVo cmsProjectVo);
    public void delete(HashMap<String, Object> params);
    public void projectActiveChanger(HashMap<String, Object> params);

}
