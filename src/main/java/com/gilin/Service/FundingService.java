package com.gilin.Service;

import java.util.HashMap;
import java.util.List;

import com.gilin.vo.FundingVo;
import com.gilin.vo.ProjectVo;

public interface FundingService {
	public List<ProjectVo> getMyFundingList(HashMap<String,Object> params);
	
	public void saveFunding( HashMap<String,String> params);
	
	public List<FundingVo> getFundingCommentList(HashMap<String,Object> params);
	
	public HashMap<String,Object> getFundingCommentPageInfo(HashMap<String,Object> params);
	
	public void deleteComment( HashMap<String,String> params);
    
    public void updateComment(HashMap<String,String> params);
}