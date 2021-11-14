package com.gilin.Mappers;


import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.MemberVo;

@Mapper
public interface LoginMapper  {
    
    public MemberVo getMemberInfo(HashMap<String,String> params);
	
	public void insertMember( HashMap<String,String> params);
	
	public void updateLoginTime( HashMap<String,String> params);
}
