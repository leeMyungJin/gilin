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
import com.gilin.Service.FundingService;
import com.gilin.vo.ChannelVo;
import com.gilin.vo.FundingVo;
import com.gilin.vo.ProjectVo;

@Controller
@RequestMapping("/funding")
public class FundingController {
    
	@Autowired
	FundingService fundingService;
	
    @RequestMapping(value = "/myfunding", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveFundingn(Model model) {
    	return "funding/myfunding";
    }
    
    @RequestMapping(value = "/getMyFundingList")
    @ResponseBody
    public List<ProjectVo> getMyFundingList(@RequestParam HashMap<String,Object> params){
    	
    	List<ProjectVo> fundingList = fundingService.getMyFundingList(params);
    	
    	return fundingList;
    }
    
}
