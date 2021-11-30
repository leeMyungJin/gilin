package com.gilin.Cms.Controller;


import com.gilin.Service.PushService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
public class CmsPushController {


    @Autowired
    PushService pushService;

    @Autowired
    Environment environment;

    /**
     * DB에서 사용자 토큰을 가져와서 각 사용자별로 FCM Push 발송처리
     * @param id
     * @return 성공여부
     * @throws Exception
     */
    @RequestMapping(value="/sendPush")
    @ResponseBody
    public String sendPush(@RequestParam String id) throws Exception {

        System.out.println(id);
        HashMap<String, String> params = new HashMap<>();
        params.put("id", id);
        String userToken = pushService.getUserToken(params); // DB에서 사용자 토큰 가져오기

        System.out.println("userToken::" + userToken);

        String result ="fail";
        if(userToken != null){ // 토큰이 존재하는 경우에만 처리
            params.put("userToken",pushService.getUserToken(params)); // 사용자 토큰 추가
            params.put("firebaseKeyPath",environment.getProperty("firebase.path.key")); // key파일 path 가져오기

            params.put("title", "타이틸"); // key파일 path 가져오기
            params.put("body", "내용입니다"); // key파일 path 가져오기
            System.out.println("인바::"+environment.getProperty("firebase.path.key"));
            result = pushService.sendPush(params);
            System.out.println(result);
        }
        return result;
    }


}
