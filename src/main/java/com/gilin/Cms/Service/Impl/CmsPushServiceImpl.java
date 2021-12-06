package com.gilin.Cms.Service.Impl;


import com.gilin.Cms.Mapper.CmsPushMapper;
import com.gilin.Cms.Service.CmsPushService;
import com.gilin.Cms.Vo.CmsPushVo;
import com.google.auth.oauth2.GoogleCredentials;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

@Service
@EnableAsync
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
    public int create(HashMap<String, String> params) {
        return cmsPushMapper.create(params);
    }

    @Override
    @Async
    public String sendPush(HashMap<String, String> params) throws Exception {
        String result="";
        try {
            //FCM처리를 위한 기본 셋팅
            String MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
            String[] SCOPES = { MESSAGING_SCOPE };
            Resource resource = new ClassPathResource(params.get("firebaseKeyPath"));
            GoogleCredentials credentials = GoogleCredentials.fromStream(resource.getInputStream())
                    .createScoped(Arrays.asList(SCOPES));
            credentials.refreshIfExpired();

            // Push 헤더 만들기
            HttpHeaders headers = new HttpHeaders();
            headers.add("content-type" , MediaType.APPLICATION_JSON_VALUE);
            headers.add("Authorization", "Bearer " +  credentials.refreshAccessToken().getTokenValue());

            // PUSH 기본 메시징 데이터
            HashMap<String,String> notificationData = new HashMap<String,String>();
            notificationData.put("body", params.get("body"));
            notificationData.put("title", params.get("title"));
            JSONObject notification = new JSONObject(notificationData);

            // 내부 처리를 위한 커스터마이징 데이터 추가
            HashMap<String,Object> data = new HashMap<String,Object>();
            data.put("keyId",params.get("keyId"));
            data.put("idx",params.get("idx"));
            data.put("click_action","FLUTTER_NOTIFICATION_CLICK");
            JSONObject jsonData = new JSONObject(data);

            // Push 정상동작을 위한 기본 sound 추가
            HashMap<String,String> sound = new HashMap<String,String>();
            sound.put("sound","default");
            // android용 사운드 추가
            HashMap<String,Object> android = new HashMap<String,Object>();
            android.put("notification",sound);
            //IOS용 사운드 추가
            HashMap<String,Object> payload = new HashMap<String,Object>();
            HashMap<String,String> aps = new HashMap<String,String>();
            aps.put("sound","default");
            payload.put("aps",aps);
            HashMap<String,Object> apns = new HashMap<String,Object>();
            apns.put("payload",payload);

            //Pusn 발송을 위한 FCM 메시지 구조화
            HashMap<String,Object> messageData = new HashMap<String,Object>();
            messageData.put("token", params.get("userToken"));
            messageData.put("notification", notification);
            messageData.put("data",jsonData);
            messageData.put("android",android);
            messageData.put("apns",apns);
            JSONObject message = new JSONObject(messageData);
            HashMap<String,Object> jsonParamsData = new HashMap<String,Object>();
            jsonParamsData.put("message", message);
            JSONObject jsonParams = new JSONObject(jsonParamsData);

            HttpEntity<JSONObject> httpEntity = new HttpEntity<JSONObject>(jsonParams, headers);
            RestTemplate rt = new RestTemplate();

            // FCM Push메세지 발송
            ResponseEntity<String> res = rt.exchange("https://fcm.googleapis.com/v1/projects/gilin001-a2308/messages:send"
                    , HttpMethod.POST
                    , httpEntity
                    , String.class);

            if (res.getStatusCode() != HttpStatus.OK) {
                result= "fail"; // 발송 실패
            } else {
                result= "success"; // 성공
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public int create_detail(HashMap<String, String> params) {
        return cmsPushMapper.create_detail(params);
    }


}
