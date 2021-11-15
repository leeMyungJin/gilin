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
    private String profile_pic;
    private String age;
    private String gender;
    private String email;
    private boolean admin_yn;
    private LocalDateTime cret_dt;
    private String cret_id;
    private LocalDateTime updt_dt;
    private String updt_id;

    /* 조인 필드 */
    private String adminFlag;

}
