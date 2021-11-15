package com.gilin.Cms.Vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter @Setter @ToString
public class CmsProjectVo {

    private long pjSeq;
    private String chSeq;
    private String pjName;
    private String pjImg;
    private String pjMemo;
    private String pjContent;
    private String fdStDt;
    private String fdEndDt;
    private String cretDt;
    private String cretId;
    private String updtDt;
    private String updtId;

    /* 커스텀 필드 조인 등 */
    private String fdAmt;
    private String chName;
    private String fdRangeDt;
    private String active;
    private String sumFdAmt;
    private String fundingCount;
    private String nickname;
    private MultipartFile pjImageFileUpload;

}
