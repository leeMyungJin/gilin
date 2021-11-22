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
    
    /* 펀딩 등록 */
    @RequestMapping(value = "/saveFunding")
    @ResponseBody
    public void saveFunding(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	fundingService.saveFunding(params);
    }   
    
    @RequestMapping(value = "/getFundingCommentList")
    @ResponseBody
    public List<FundingVo> getFundingCommentList(@RequestParam HashMap<String,Object> params){
    	
    	List<FundingVo> fundingList = fundingService.getFundingCommentList(params);
    	
    	return fundingList;
    }
    
    @RequestMapping(value = "/getFundingCommentPageInfo")
    @ResponseBody
    public HashMap<String,Object> getFundingCommentPageInfo(@RequestParam HashMap<String,Object> params){
    	
    	return fundingService.getFundingCommentPageInfo(params);
    }
    
    /* 댓글 삭제 */
    @RequestMapping(value = "/deleteComment")  
    @ResponseBody
    public void deleteComment(@RequestParam HashMap<String,String> params){
    	fundingService.deleteComment(params);
    }
    
    /* 수정 */
    @RequestMapping(value = "/updateComment")
    @ResponseBody
    public void updateComment(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	fundingService.updateComment(params);
    }    
    
}
