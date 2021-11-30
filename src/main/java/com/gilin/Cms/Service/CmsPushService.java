package com.gilin.Cms.Service;


import com.gilin.Cms.Vo.CmsPushVo;

import java.util.HashMap;
import java.util.List;

public interface CmsPushService {

    public List<CmsPushVo> getListBySearch(HashMap<String, Object> params);
    public void update(CmsPushVo PushVo);
    public void create(HashMap<String, String> params);

}
