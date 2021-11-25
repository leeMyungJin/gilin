package com.gilin.Cms.Vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter @Setter @ToString
public class CmsMemberVo {

    private String id;
    private String pass;
    private String nickname;
    private String profilePic;
    private String age;
    private String gender;
    private String email;
    private boolean adminYn;
    private String lateassDt;
    private String cretDt;
    private String cretId;
    private String updtDt;
    private String updtId;

    private String mos;
    private String minfo;
    private String appversion;
    private String fcmToken;
    private String snsToken;

    /* 조인 필드 */
    private String adminFlag;

}
