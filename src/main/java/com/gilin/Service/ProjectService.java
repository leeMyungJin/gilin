package com.gilin.Service;

import java.util.HashMap;
import java.util.List;

import com.gilin.vo.ProjectVo;


public interface ProjectService {
public List<ProjectVo> getAllProjectList(HashMap<String,Object> params);
	
	public List<ProjectVo> getMyProjectList(HashMap<String,Object> params);
}