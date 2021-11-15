package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.FundingMapper;
import com.gilin.Service.FundingService;
import com.gilin.vo.FundingVo;
import com.gilin.vo.ProjectVo;

@Service
public class FundingServiceImpl implements FundingService{

	@Autowired
	private FundingMapper fundingMapper;
	
	@Override
	public List<ProjectVo> getMyFundingList(HashMap<String,Object> params){
		                		
		List<ProjectVo> fundingList = fundingMapper.getMyFundingList(params);
		return fundingList;
	}
	
}