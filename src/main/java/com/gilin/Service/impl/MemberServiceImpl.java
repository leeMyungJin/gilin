package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.MemberMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void updateNickname(HashMap<String, String> params) {
		memberMapper.updateNickname(params);
	}

}