package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.LoginMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.LoginService;
import com.gilin.vo.ChannelVo;
import com.gilin.vo.MemberVo;

@Service
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper loginMapper;
	
	@Override
	public MemberVo getMemberInfo(HashMap<String,String> params){
		                		
		MemberVo memberVo = loginMapper.getMemberInfo(params);
		return memberVo;
	}
	
	@Override
	public void insertMember(HashMap<String, String> params) {
		loginMapper.insertMember(params);
	}
	
	@Override
	public void updateLoginTime(HashMap<String, String> params) {
		loginMapper.updateLoginTime(params);
	}

}