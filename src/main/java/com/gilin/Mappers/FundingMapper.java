package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.FundingVo;
import com.gilin.vo.ProjectVo;


@Mapper
public interface FundingMapper  {
	public List<ProjectVo> getMyFundingList(HashMap<String,Object> params);
	
	public void saveFunding( HashMap<String,String> params);
	
	public List<FundingVo> getFundingCommentList(HashMap<String,Object> params);
	
	public HashMap<String,Object> getFundingCommentPageInfo(HashMap<String,Object> params);
	
	public void deleteComment( HashMap<String,String> params);
    
    public void updateComment(HashMap<String,String> params);
}
