package com.gilin.Controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gilin.Service.ChannelService;
import com.gilin.Service.ReportService;
import com.gilin.vo.ChannelVo;
import com.gilin.vo.ReportVo;

@Controller
@RequestMapping("/report")
public class ReportController {
    
	@Autowired
	ReportService reportService;
	
	@Autowired
	ChannelService channelService;
	
    @RequestMapping(value = "/myreport", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMyreport(@RequestParam HashMap<String,Object> params, Model model) {
    	ChannelVo channelVo = channelService.getChannelInfo(params);
    	model.addAttribute("channelVo", channelVo);
    	model.addAttribute("chSeq", params.get("chSeq"));
    	
    	return "report/myreport";
    }
    
    @RequestMapping(value = "/getReportChart")
    @ResponseBody
    public List<ReportVo> getReportChart(@RequestParam HashMap<String,Object> params){
    	
    	List<ReportVo> ReportList = reportService.getReportChart(params);
    	
    	return ReportList;
    }
    
    @RequestMapping(value = "/getTotReportInfo")
    @ResponseBody
    public HashMap<String,Object> getTotReportInfo(@RequestParam HashMap<String,Object> params){
    	
    	return reportService.getTotReportInfo(params);
    }
	
   
    
}
