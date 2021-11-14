package com.gilin.Service;

import java.util.HashMap;

import com.gilin.vo.MemberVo;

public interface LoginService {
	public MemberVo getMemberInfo(HashMap<String,String> params);
	
	public void insertMember( HashMap<String,String> params);
	
	public void updateLoginTime( HashMap<String,String> params);
}