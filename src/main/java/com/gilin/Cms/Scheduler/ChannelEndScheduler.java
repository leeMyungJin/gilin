package com.gilin.Cms.Scheduler;


import com.gilin.Cms.Service.CmsChannelService;
import com.gilin.Cms.Service.CmsMemberService;
import com.gilin.Cms.Service.CmsPushService;
import com.gilin.Cms.Vo.CmsChannelVo;
import com.gilin.Service.PushService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

@Component
public class ChannelEndScheduler {

    @Autowired
    CmsChannelService cmsChannelService;

    @Autowired
    CmsMemberService cmsMemberService;

    @Autowired
    CmsPushService cmsPushService;

    @Autowired
    PushService pushService;

    @Autowired
    Environment environment;


    /* 채널종료 당일 스케줄러 */
    @Scheduled(cron = "0 0 12 * * *")
//    @Scheduled(cron = "0/5 * * * * *")
    public void run() throws Exception {

        /* --------------------------- 12시 스케줄링 시작 --------------------------- */
        System.out.println("------------- " + LocalDateTime.now() + " :: 12시 스케줄링 시작 -------------");

        /* 종료하루 전 채널목록 + 채널에 속한 프로젝트 개설자 정보(구분자,) 들고옴 */
        List<CmsChannelVo> cmsChannelVos = cmsChannelService.getChannelEndSchedulerList();

        for (CmsChannelVo vo: cmsChannelVos) {

            System.out.println("크렛아이디::" + vo.getCretId());

            /* 채널개설자 알람플래그 변경 */
            HashMap<String, String> params1 = new HashMap<>();
            params1.put("id", vo.getCretId());

            cmsMemberService.alarmUpdateY(params1);

            params1.put("title", vo.getChName() + " 채널이 금일 종료됩니다.");
            params1.put("body", vo.getChName() + " 채널이 금일 종료됩니다.");
            params1.put("idx", Long.toString(vo.getChSeq()));
            /* 채널개설자 푸시보내기 */
            push(params1);
            /* 채널개설자 히스토리남기기 */
            params1.put("push_title", vo.getChName() + " 채널이 금일 종료됩니다.");
            params1.put("push_body", vo.getChName() + " 채널이 금일 종료됩니다.");
            params1.put("push_notice_idx", Long.toString(vo.getChSeq()));
            cmsPushService.create(params1);

            /* 프로젝트개설자 있으면 */
            if (vo.getProjectCretIds() != null) {
                String[] projectIds = vo.getProjectCretIds().split(",");

                /* 프로젝트개설자 알람플래그 변경 */
                if (projectIds.length > 0) {
                    for (int i=0; i<projectIds.length; i++) {
                        HashMap<String, String> params2 = new HashMap<>();
                        params2.put("id", projectIds[i]);
                        cmsMemberService.alarmUpdateY(params2);

                        params2.put("title", vo.getChName() + " 채널이 금일 종료됩니다.");
                        params2.put("body", vo.getChName() + " 채널이 금일 종료됩니다.");
                        params2.put("idx", Long.toString(vo.getChSeq()));

                        /* 프로젝트개설자 푸시보내기 */
                        push(params2);
                        /* 프로젝트개설자 히스토리남기기 */
                        params2.put("push_title", vo.getChName() + " 채널이 금일 종료됩니다.");
                        params2.put("push_body", vo.getChName() + " 채널이 금일 종료됩니다.");
                        params2.put("push_notice_idx", Long.toString(vo.getChSeq()));
                        cmsPushService.create(params2);
                    }
                }
            }

        }
    }

    public String push(HashMap<String, String> params) throws Exception {

        String userToken = pushService.getUserToken(params); // DB에서 사용자 토큰 가져오기
        String result ="fail";
        if(userToken != null) {
            params.put("userToken", pushService.getUserToken(params)); // 사용자 토큰 추가
            params.put("firebaseKeyPath", environment.getProperty("firebase.path.key")); // key파일 path 가져오기
            result = cmsPushService.sendPush(params);
        }
        return result;

    }

}
