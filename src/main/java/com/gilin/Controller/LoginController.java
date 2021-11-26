package com.gilin.Controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gilin.Service.ChannelService;
import com.gilin.Service.LoginService;
import com.gilin.vo.LoginVo;
import com.gilin.vo.MemberVo;

@Controller
@RequestMapping("/login")
public class LoginController {
    
	@Autowired
	LoginService loginService;
	
	/* 채널 등록 */
    @RequestMapping(value = "/login")
    @ResponseBody
    public void login(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	MemberVo memberVo = loginService.getMemberInfo(params);
    	
    	HttpSession session = req.getSession();
    	if(memberVo == null) {
    		loginService.insertMember(params);
    		
    		session.setAttribute("id", params.get("id"));
    		session.setAttribute("adminYn", params.get("adminYn"));
    		session.setAttribute("email", params.get("email"));
    		session.setAttribute("nickname", params.get("nickname"));
    		session.setAttribute("profilePic", params.get("profilePic"));
    		
    	}else {
    		session.setAttribute("id", memberVo.getId());
    		session.setAttribute("adminYn", memberVo.getAdminYn());
    		session.setAttribute("email", memberVo.getEmail());
    		session.setAttribute("nickname", memberVo.getNickname());
    		session.setAttribute("profilePic", memberVo.getProfilePic());
    		
    		loginService.updateLoginTime(params);
    	}
    }   
    
    @RequestMapping(value = "/logout")
    @ResponseBody
    public void logout(HttpServletRequest  request){  
        HttpSession session = request.getSession();
		System.out.println("session invalidate!!");
		session.invalidate();
    }  
    
    /* 탈퇴 */
    @RequestMapping(value = "/deleteMember")
    @ResponseBody
    public void deleteMember(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	loginService.deleteMember(params);
    }   
    
    
}
