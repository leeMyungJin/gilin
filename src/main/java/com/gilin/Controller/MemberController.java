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

import com.gilin.Service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
    
	@Autowired
	MemberService memberService;
	
    @RequestMapping(value = "/mypage", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMypage(Model model) {
    	return "member/mypage";
    }
    
    /* 채널 수정 */
    @RequestMapping(value = "/updateNickname")
    @ResponseBody
    public void updateNickname(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	memberService.updateNickname(params);
    }   
   
    
}
