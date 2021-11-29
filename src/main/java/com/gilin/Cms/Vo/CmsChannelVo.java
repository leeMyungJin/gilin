package com.gilin.Cms.Vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter @Setter @ToString
public class CmsChannelVo {

    private long chSeq;
    private String chName;
    private String chImg;
    private boolean chActiveYn;
    private String chMemo;
    private String chStDt;
    private String chEndDt;
    private String chFdStDt;
    private String chFdEndDt;
    private String chPass;
    private String chOpenYn;
    private String cretDt;
    private String cretId;
    private String updtDt;
    private String updtId;


    /* 조인필드 */
    private String nickname;
    private String chDateRange;
    private String fundingDateRange;
    private String projectCount;
    private String fundingTotalPrice;
    private String active;
    private String fundingCount;
    private String sumFunding;
    private String projectCretIds;

    /* 사진업데이트필드 */
    private MultipartFile chImgFileUpload;


}
