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
import com.gilin.vo.ChannelVo;

@Controller
@RequestMapping("/channel")
public class ChannelController {
    
	@Autowired
	ChannelService channelService;
	
    @RequestMapping(value = "/channelOpen", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveChannelOpen(Model model) {
    	model.addAttribute("pageType", "channel_open");
    	return "channel/channel_open";
    }
    
    @RequestMapping(value = "/channel", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveChannel(@RequestParam HashMap<String,Object> params, Model model) {
    	ChannelVo channelVo = channelService.getChannelInfo(params);
    	model.addAttribute("channelVo", channelVo);
    	model.addAttribute("chSeq", params.get("chSeq"));
    	
    	return "channel/channel";
    }
    
    @RequestMapping(value = "/mychannelModi", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMychannelModi(Model model) {
    	model.addAttribute("pageType", "mychannel_modi");
    	return "channel/channel_open";
    }
    
    @RequestMapping(value = "/mychannel", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMychannel(Model model) {
    	return "channel/mychannel";
    }
    
    @RequestMapping(value = "/getAllChannelList")
    @ResponseBody
    public List<ChannelVo> getAllChannelList(@RequestParam HashMap<String,Object> params){
    	
    	List<ChannelVo> channelList = channelService.getAllChannelList(params);
    	
    	return channelList;
    }
    
    @RequestMapping(value = "/getMyChannelList")
    @ResponseBody
    public List<ChannelVo> getMyChannelList(@RequestParam HashMap<String,Object> params){
    	
    	List<ChannelVo> channelList = channelService.getMyChannelList(params);
    	
    	return channelList;
    }
    
    @RequestMapping(value = "/getChannelPassChk")
    @ResponseBody
    public String getChannelPassChk(@RequestParam HashMap<String,Object> params){
    	
    	String channelPassChk = channelService.getChannelPassChk(params);
    	
    	return channelPassChk;
    }
    
    @RequestMapping(value = "/getChannelInfo")
    @ResponseBody
    public ChannelVo getChannelInfo(@RequestParam HashMap<String,Object> params){
    	
    	ChannelVo channelVo = channelService.getChannelInfo(params);
    	
    	return channelVo;
    }
    
    /* 채널 등록 */
    @RequestMapping(value = "/insertChannel")
    @ResponseBody
    public void insertChannel(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	channelService.insertChannel(params);
    }   
    
    /* 채널 수정 */
    @RequestMapping(value = "/updateChannel")
    @ResponseBody
    public void updateChannel(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	channelService.updateChannel(params);
    }   
    
    /* 채널 삭제 */
    @RequestMapping(value = "/deleteChannel")
    @ResponseBody
    public void deleteChannel(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	channelService.deleteChannel(params);
    }   
   
    
}
