package com.gilin.Controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gilin.Service.ProjectService;
import com.gilin.vo.ChannelVo;
import com.gilin.vo.ProjectVo;

@Controller
@RequestMapping("/project")
public class ProjectController {
    
	@Autowired
	ProjectService projectService;
	
    @RequestMapping(value = "/myprojectModi", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMyprojectModi(Model model) {
    	model.addAttribute("pageType", "myproject_modi");
    	return "project/project_open";
    }
	
    @RequestMapping(value = "/projectOpen", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMyProject(Model model) {
    	model.addAttribute("pageType", "project_open");
    	return "project/project_open";
    }
    
    @RequestMapping(value = "/myproject", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveProjectOpen(Model model) {
    	return "project/myproject";
    }
	
    @RequestMapping(value = "/project", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveProject(@RequestParam HashMap<String,Object> params, Model model) {
    	//ProjectVo projectVo = projectService.getProjectInfo(params);
    	//model.addAttribute("projectVo", projectVo);
    	//model.addAttribute("pjSeq", params.get("pjSeq"));
    	
    	return "project/project";
    }
    
    @RequestMapping(value = "/getAllProjectList")
    @ResponseBody
    public List<ProjectVo> getAllProjectList(@RequestParam HashMap<String,Object> params){
    	
    	List<ProjectVo> projectList = projectService.getAllProjectList(params);
    	
    	return projectList;
    }
    
    @RequestMapping(value = "/getMyProjectList")
    @ResponseBody
    public List<ProjectVo> getMyProjectList(@RequestParam HashMap<String,Object> params){
    	
    	List<ProjectVo> projectList = projectService.getMyProjectList(params);
    	
    	return projectList;
    }
   
    
}
