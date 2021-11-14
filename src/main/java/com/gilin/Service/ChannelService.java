package com.gilin.Service;

import java.util.HashMap;
import java.util.List;

import com.gilin.vo.ChannelVo;

public interface ChannelService {
	public List<ChannelVo> getAllChannelList(HashMap<String,Object> params);
	
	public List<ChannelVo> getMyChannelList(HashMap<String,Object> params);
	
	public String getChannelPassChk(HashMap<String,Object> params);
	
	public ChannelVo getChannelInfo(HashMap<String,Object> params);
	
	public void insertChannel( HashMap<String,String> params);
	
	public void updateChannel( HashMap<String,String> params);
	
	public void deleteChannel( HashMap<String,String> params);
	
}