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

	
	@Override
	public ProjectVo getProjectInfo(HashMap<String,Object> params, String id){
		                		
		params.put("memberId", id);
		ProjectVo projectVo = projectMapper.getProjectInfo(params);
    	
		return projectVo;
	}
	
	@Override
	public void insertProject(HashMap<String, String> params) {
		projectMapper.insertProject(params);
	}
	
	@Override
	public void updateProject(HashMap<String, String> params) {
		projectMapper.updateProject(params);
	}
	
	@Override
	public void deleteProject(HashMap<String, String> params) {
		projectMapper.deleteProject(params);
	}
   
}