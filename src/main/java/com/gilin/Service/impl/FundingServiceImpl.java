package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.FundingMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.FundingService;

@Service
public class FundingServiceImpl implements FundingService{

	@Autowired
	private FundingMapper fundingMapper;
	

}