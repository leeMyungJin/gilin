package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.MainMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.MainService;

@Service
public class MainServiceImpl implements MainService{

	@Autowired
	private MainMapper mainMapper;
	

}