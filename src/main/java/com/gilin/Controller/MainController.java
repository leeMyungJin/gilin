package com.gilin.Controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gilin.Cms.Vo.CmsNoticeVo;
import com.gilin.Service.MainService;
import com.gilin.vo.MainVo;

@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	@RequestMapping(value = "/", method = {RequestMethod.POST , RequestMethod.GET})
    public String intro() {
        return "main/main";
    }
	
	@RequestMapping(value = "/search", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveSearchMain(@RequestParam HashMap<String,Object> params, Model model) {
		model.addAttribute("topSearch", params.get("topSearch"));
        return "main/main";
    }
	
	@RequestMapping(value = "/index", method = {RequestMethod.POST , RequestMethod.GET})
    public String index() {
        return "index";
    }
	
	@RequestMapping(value = "/notice", method = {RequestMethod.POST , RequestMethod.GET})
    public String notice(@RequestParam HashMap<String,Object> params, Model model) {
        return "main/notice";
    }
	
	@RequestMapping(value = "/getNoticeList")
    @ResponseBody
    public List<MainVo> getNoticeList(@RequestParam HashMap<String,Object> params){
    	
    	List<MainVo> noticeList = mainService.getNoticeList(params);
    	
    	return noticeList;
    }
}
