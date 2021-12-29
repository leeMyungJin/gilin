package com.gilin.Cms.Service;


import com.gilin.Cms.Vo.CmsMemberVo;
import com.gilin.Cms.Vo.CmsPushVo;
import com.google.firebase.messaging.FirebaseMessagingException;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface CmsPushService {

    public List<CmsPushVo> getListBySearch(HashMap<String, Object> params);
    public void update(CmsPushVo PushVo);
    public int create(HashMap<String, String> params);
    public String sendPush(HashMap<String, String> params) throws Exception;
    public String sendPushForEach(HashMap<String, String> params, List<CmsMemberVo> cmsUserVos) throws Exception;
    public void sendPushMulti(HashMap<String, String> params, List<CmsMemberVo> pushTokens)
            throws FirebaseMessagingException, IOException;
    public int create_detail(HashMap<String, String> params);
}
