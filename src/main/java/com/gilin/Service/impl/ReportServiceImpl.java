package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.ReportMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.ReportService;
import com.gilin.vo.ChannelVo;
import com.gilin.vo.ReportVo;

@Service
public class ReportServiceImpl implements ReportService{

	@Autowired
	private ReportMapper reportMapper;
	
	@Override
	public List<ReportVo> getReportChart(HashMap<String,Object> params){
		                		
		List<ReportVo> ReportList = reportMapper.getReportChart(params);
		return ReportList;
	}
	
	public HashMap<String,Object> getTotReportInfo(HashMap<String,Object> params){
		return reportMapper.getTotReportInfo(params);
	}

}