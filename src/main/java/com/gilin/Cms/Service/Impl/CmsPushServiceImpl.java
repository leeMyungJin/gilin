package com.gilin.Cms.Service.Impl;


import com.gilin.Cms.Mapper.CmsPushMapper;
import com.gilin.Cms.Service.CmsMemberService;
import com.gilin.Cms.Service.CmsPushService;
import com.gilin.Cms.Vo.CmsMemberVo;
import com.gilin.Cms.Vo.CmsPushVo;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.*;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.core.env.Environment;

import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalTime;
import java.util.*;

@Service
@EnableAsync
public class CmsPushServiceImpl implements CmsPushService {


    @Autowired
    CmsPushMapper cmsPushMapper;

    @Autowired
    Environment environment;

    @Autowired
    CmsMemberService cmsMemberService;


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
    @Async
    public String sendPushForEach(HashMap<String, String> params, List<CmsMemberVo> cmsUserVos) throws Exception {

        String result="";

        for (CmsMemberVo vo: cmsUserVos) {
            String userToken = vo.getFcmToken(); // DB에서 사용자 토큰 가져오기
            if(userToken != null) {
//                System.out.println("유저토큰::"+userToken);
                params.put("userToken", userToken); // 사용자 토큰 추가
                params.put("firebaseKeyPath", environment.getProperty("firebase.path.key")); // key파일 path 가져오기


                /* 채널개설자 알람플래그 변경 */
                params.put("id", vo.getId());
                cmsMemberService.alarmUpdateY(params);

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

                    HashMap<String, String> params2 = new HashMap<>();
                    params2.put("user_id", vo.getId());
                    params2.put("push_idx", params.get("history_idx"));
                    int detail_index = create_detail(params2);

                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        }


        return result;
    }

    @Override
    public void sendPushMulti(HashMap<String, String> params, List<CmsMemberVo> pushTokens)
            throws FirebaseMessagingException, IOException {
        /* 로컬용 */
//        FileInputStream refreshToken = new FileInputStream("/Users/seungheejeon/Desktop/workspace/2021_11/gilin_new/src/main/resources/firebase/gilin001-a2308-firebase-adminsdk-m8xnc-e514bc06fa.json");

        /* 서버용 */
        FileInputStream refreshToken = new FileInputStream("/var/upload/firebase/gilin001-a2308-firebase-adminsdk-m8xnc-e514bc06fa.json");

        FirebaseOptions options = new FirebaseOptions.Builder()
                .setCredentials(GoogleCredentials.fromStream(refreshToken))
                .build();

        if(FirebaseApp.getApps().isEmpty()) {
            FirebaseApp.initializeApp(options);
        }

        int tokenCount = 0;
        int failCount = 0;

        List<String> tokenList = new ArrayList<>();

        LocalTime localTime1 = LocalTime.now();

        for (int i=0; i < pushTokens.size(); i++) {

            /* 유저의 푸시토큰을 배열에 담는다 */
            tokenList.add(pushTokens.get(i).getFcmToken());
            tokenCount++;

            /* 배열에 푸시토큰 500개 담기면 푸시보내고 배열 초기화 */
            if ((i % 499) == 0 && (i != 0)) {

                MulticastMessage message = MulticastMessage.builder()
                        .setNotification(Notification.builder()
                                .setTitle(params.get("title"))
                                .setBody(params.get("body"))
                                .build())
                        .setApnsConfig(ApnsConfig.builder() /* 아이폰 개별 설정 */
                                .setAps(Aps.builder()
                                        .setBadge(42)
                                        .setSound("default")
                                        .build())
                                .build())
                        .putData("idx", params.get("idx"))
                        .putData("click_action", "FLUTTER_NOTIFICATION_CLICK")
                        .addAllTokens(tokenList)
                        .build();

                tokenList.clear();
                BatchResponse response = FirebaseMessaging.getInstance().sendMulticast(message);

                /* 실패갯수 담기. 필요없는 경우가 대부분이므로 주석처리 */
//                if(response.getFailureCount() > 0) {
//                    failCount += response.getFailureCount();
//                }

            }
        }

        /* 렝스500안되는 남은 토큰도 보내기 */
        if (tokenList.size() > 0) {

            MulticastMessage message = MulticastMessage.builder()
                    .setNotification(Notification.builder()
                            .setTitle(params.get("title"))
                            .setBody(params.get("body"))
                            .build())
                    .setApnsConfig(ApnsConfig.builder()
                            .setAps(Aps.builder()
                                    .setBadge(42)
                                    .setSound("default")
                                    .build())
                            .build())
                    .putData("idx", params.get("idx"))
                    .putData("click_action", "FLUTTER_NOTIFICATION_CLICK")
                    .addAllTokens(tokenList)
                    .build();

            BatchResponse response = FirebaseMessaging.getInstance().sendMulticast(message);

            /* 실패갯수 담기. 필요없는 경우가 대부분이므로 주석처리 */
//                if(response.getFailureCount() > 0) {
//                    failCount += response.getFailureCount();
//                }
        }


        LocalTime localTime2 = LocalTime.now();
        System.out.println("보내기시작시간 :: " + localTime1 +", 보내기종료시간 :: " + localTime2);
    }

    @Override
    public int create_detail(HashMap<String, String> params) {
        return cmsPushMapper.create_detail(params);
    }


}
