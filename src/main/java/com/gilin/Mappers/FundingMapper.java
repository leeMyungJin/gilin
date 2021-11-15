package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.FundingVo;
import com.gilin.vo.ProjectVo;


@Mapper
public interface FundingMapper  {
	public List<ProjectVo> getMyFundingList(HashMap<String,Object> params);
	
}
