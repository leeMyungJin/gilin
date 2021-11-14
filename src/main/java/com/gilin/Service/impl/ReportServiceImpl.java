package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ChannelMapper;
import com.gilin.Mappers.ReportMapper;
import com.gilin.Service.ChannelService;
import com.gilin.Service.ReportService;

@Service
public class ReportServiceImpl implements ReportService{

	@Autowired
	private ReportMapper reportMapper;
	

}