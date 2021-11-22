package com.gilin.Mappers;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gilin.vo.ProjectVo;


@Mapper
public interface ProjectMapper  {
public List<ProjectVo> getAllProjectList(HashMap<String,Object> params);
	
	public List<ProjectVo> getMyProjectList(HashMap<String,Object> params);
	
	public ProjectVo getProjectInfo(HashMap<String,Object> params);
	
	public void insertProject( HashMap<String,String> params);
	
	public void updateProject( HashMap<String,String> params);
	
	public void deleteProject( HashMap<String,String> params);
}
