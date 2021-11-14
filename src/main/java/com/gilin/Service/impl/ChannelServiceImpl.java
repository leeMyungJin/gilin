package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Util.Util;
import com.gilin.Mappers.ChannelMapper;
import com.gilin.Service.ChannelService;
import com.gilin.vo.ChannelVo;

@Service
public class ChannelServiceImpl implements ChannelService{

	@Autowired
	private ChannelMapper channelMapper;
	
	@Override
	public List<ChannelVo> getAllChannelList(HashMap<String,Object> params){
		                		
		List<ChannelVo> channelList = channelMapper.getAllChannelList(params);
		return channelList;
	}
	

	@Override
	public List<ChannelVo> getMyChannelList(HashMap<String,Object> params){
		                		
		List<ChannelVo> channelList = channelMapper.getMyChannelList(params);
		return channelList;
	}
	
	@Override
	public String getChannelPassChk(HashMap<String,Object> params){
		                		
		String channelPassChk = channelMapper.getChannelPassChk(params);
		return channelPassChk;
	}
	
	@Override
	public ChannelVo getChannelInfo(HashMap<String,Object> params){
		                		
		ChannelVo channelVo = channelMapper.getChannelInfo(params);
		return channelVo;
	}
	
	@Override
	public void insertChannel(HashMap<String, String> params) {
		channelMapper.insertChannel(params);
	}
	
	@Override
	public void updateChannel(HashMap<String, String> params) {
		channelMapper.updateChannel(params);
	}
	
	@Override
	public void deleteChannel(HashMap<String, String> params) {
		channelMapper.deleteChannel(params);
	}
	
	
}