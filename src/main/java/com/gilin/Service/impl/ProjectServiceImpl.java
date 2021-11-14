package com.gilin.Service.impl;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gilin.Mappers.ProjectMapper;
import com.gilin.Service.ProjectService;
import com.gilin.vo.ProjectVo;

@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectMapper projectMapper;
	
	@Override
	public List<ProjectVo> getAllProjectList(HashMap<String,Object> params){
		                		
		List<ProjectVo> projectList = projectMapper.getAllProjectList(params);
		return projectList;
	}
	

	@Override
	public List<ProjectVo> getMyProjectList(HashMap<String,Object> params){
		                		
		List<ProjectVo> projectList = projectMapper.getMyProjectList(params);
		return projectList;
	}

}