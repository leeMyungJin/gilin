package com.gilin.Cms.Service;




import com.gilin.Cms.Vo.CmsNoticeVo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CmsNoticeService {

    public Map<String, Integer> getCount();
    public List<CmsNoticeVo> getListBySearch(HashMap<String, Object> params);
    public void create(HashMap<String, Object> params);
    public void update(HashMap<String, Object> params);
    public void delete(HashMap<String, Object> params);

}
