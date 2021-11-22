package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.MainMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.MainService;
import com.gilin.vo.MainVo;
import com.gilin.vo.ProjectVo;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	private MainMapper mainMapper;
	
	@Override
	public List<MainVo> getNoticeList(HashMap<String,Object> params){
		                		
		List<MainVo> noticeList = mainMapper.getNoticeList(params);
		return noticeList;
	}
	

}