package com.gilin.Cms.Vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class CmsPushVo {

    private String pushTitle;
    private String pushBody;
    private String pushNoticeIdx;
    private String pushImg;
    private String noticeFlag;
    private String appSender;
    private String webSender;
    private String sendDt;

}
