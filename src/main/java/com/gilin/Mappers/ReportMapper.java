package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.ReportVo;


@Mapper
public interface ReportMapper  {
	public List<ReportVo> getReportChart(HashMap<String,Object> params);
	
	public HashMap<String,Object> getTotReportInfo(HashMap<String,Object> params);
}
