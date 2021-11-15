package com.gilin.Cms.Vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter @Setter @ToString
public class CmsTermsVo {

    private int no;
    private String subject;
    private String content;
    private String updt_id;
    private LocalDateTime updt_dt;

}
