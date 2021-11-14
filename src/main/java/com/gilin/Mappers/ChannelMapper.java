package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.ChannelVo;


@Mapper
public interface ChannelMapper  {
	public List<ChannelVo> getAllChannelList(HashMap<String,Object> params);
	
	public List<ChannelVo> getMyChannelList(HashMap<String,Object> params);
	
	public String getChannelPassChk(HashMap<String,Object> params);
	
	public ChannelVo getChannelInfo(HashMap<String,Object> params);
	
	public void insertChannel( HashMap<String,String> params);
	
	public void updateChannel( HashMap<String,String> params);
	
	public void deleteChannel( HashMap<String,String> params);
}
