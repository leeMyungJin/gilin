package com.gilin.Service;

import java.util.HashMap;
import java.util.List;

import com.gilin.vo.ReportVo;

public interface ReportService {
	
	public List<ReportVo> getReportChart(HashMap<String,Object> params);
	
	public HashMap<String,Object> getTotReportInfo(HashMap<String,Object> params);
	
}