package com.gilin.Cms.Vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class CmsNoticeVo {

    private long ntSeq;
    private String ntTitle;
    private boolean mustYn;
    private boolean activeYn;
    private String content;
    private String cretDt;
    private String cretId;
    private String updtDt;
    private String updtId;


    /* 커스텀 */
    private String mustBool;
    private String activeBool;

}