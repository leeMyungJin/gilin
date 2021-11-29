package com.gilin.Cms.Scheduler;


import com.gilin.Cms.Service.CmsChannelService;
import com.gilin.Cms.Vo.CmsChannelVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class ChannelScheduler {

    @Autowired
    CmsChannelService cmsChannelService;

    @Scheduled(cron = "0/5 * * * * *")
    public void run() {
        List<CmsChannelVo> cmsChannelVos = cmsChannelService.getSchedulerList();
        System.out.println(cmsChannelVos);
    }

}
