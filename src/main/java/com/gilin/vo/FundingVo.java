package com.gilin.vo;

public class FundingVo {
	
	private Integer rownum;
	private Integer pjSeq; 
	private Integer fdAmt; 	
	private String fdComment; 	
	private String nickname;
	private String profilePic;
	private String delYn;
	private String cretDt;
	private String cretId;
	private String updtDt;
	private String updtId;
	public Integer getPjSeq() {
		return pjSeq;
	}
	public void setPjSeq(Integer pjSeq) {
		this.pjSeq = pjSeq;
	}
	public Integer getFdAmt() {
		return fdAmt;
	}
	public void setFdAmt(Integer fdAmt) {
		this.fdAmt = fdAmt;
	}
	public String getFdComment() {
		return fdComment;
	}
	public void setFdComment(String fdComment) {
		this.fdComment = fdComment;
	}
	public String getCretDt() {
		return cretDt;
	}
	public void setCretDt(String cretDt) {
		this.cretDt = cretDt;
	}
	public String getCretId() {
		return cretId;
	}
	public void setCretId(String cretId) {
		this.cretId = cretId;
	}
	public String getUpdtDt() {
		return updtDt;
	}
	public void setUpdtDt(String updtDt) {
		this.updtDt = updtDt;
	}
	public String getUpdtId() {
		return updtId;
	}
	public void setUpdtId(String updtId) {
		this.updtId = updtId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public Integer getRownum() {
		return rownum;
	}
	public void setRownum(Integer rownum) {
		this.rownum = rownum;
	}
	
	

}
