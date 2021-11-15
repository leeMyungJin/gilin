package com.gilin.Service;

import java.util.HashMap;
import java.util.List;

import com.gilin.vo.FundingVo;
import com.gilin.vo.ProjectVo;

public interface FundingService {
	public List<ProjectVo> getMyFundingList(HashMap<String,Object> params);
}