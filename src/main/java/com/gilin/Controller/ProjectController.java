package com.gilin.Controller;

import java.io.File;
import java.io.FileFilter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gilin.Service.ProjectService;
import com.gilin.vo.ProjectVo;

@Controller
@RequestMapping("/project")
public class ProjectController {
    
	@Autowired
	ProjectService projectService;
	
    @RequestMapping(value = "/myprojectModi", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMyprojectModi(@RequestParam HashMap<String,Object> params, Model model) {
    	model.addAttribute("pageType", "myproject_modi");
        model.addAttribute("pjSeq", params.get("pjSeq"));
    	return "project/project_open";
    }
	
    @RequestMapping(value = "/projectOpen", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMyProject(@RequestParam HashMap<String,Object> params, Model model) {
    	model.addAttribute("pageType", "project_open");
    	model.addAttribute("chSeq", params.get("chSeq"));
    	return "project/project_open";
    }
    
    @RequestMapping(value = "/myproject", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveProjectOpen(Model model) {
    	return "project/myproject";
    }
	
    @RequestMapping(value = "/project", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveProject(@RequestParam HashMap<String,Object> params, Model model, HttpServletRequest req) {
    	String id = "";
    	
    	if(req.getSession().getAttribute("id") != null) {
    		id = req.getSession().getAttribute("id").toString();
    	}
    	
    	ProjectVo projectVo = projectService.getProjectInfo(params, id);
    	model.addAttribute("projectVo", projectVo);
    	model.addAttribute("pjSeq", params.get("pjSeq"));
    	
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
    
    @RequestMapping(value = "/getProjectInfo")
    @ResponseBody
    public ProjectVo getProjectInfo(@RequestParam HashMap<String,Object> params, HttpServletRequest req){
    	ProjectVo projectVo = projectService.getProjectInfo(params, req.getSession().getAttribute("id").toString());
    	
    	return projectVo;
    }
    
    /* 채널 등록 */
    @RequestMapping(value = "/insertProject")
    @ResponseBody
    public void insertProject(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	projectService.insertProject(params);
    }   
    
    /* 채널 수정 */
    @RequestMapping(value = "/updateProject")
    @ResponseBody
    public void updateProject(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	projectService.updateProject(params);
    }   
    
    /* 채널 삭제 */
    @RequestMapping(value = "/deleteProject")
    @ResponseBody
    public void deleteProject(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	projectService.deleteProject(params);
    }   
    
    @PostMapping("/contentImgUpload")
    @ResponseBody
    public Map<String, String> uploadImage(@RequestParam("file") MultipartFile multi, @RequestParam("key") String key, HttpServletRequest request, HttpServletResponse response) throws Exception {

        Map<String, String> result = new HashMap<>();

        try {

            String uploadpath = "/var/upload/img/editor_temp/";
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());

            Date dDate = new Date();
            SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
            String nowStr = dSdf.format(dDate);
            String saveFileName = "";
            saveFileName += key;
            saveFileName += "_"+nowStr;
            saveFileName += extName;

            if(!multi.isEmpty())
            {
                File file = new File(uploadpath, saveFileName);
                if(!file.exists()) // 해당 경로가 없을 경우
                    file.mkdirs();  // 폴더 생성
                multi.transferTo(file);
                String url = "https://gilin.co.kr/img/editor_temp/"+saveFileName;
                result.put("url", url);
                result.put("code", "1");
            }


        }catch(Exception e)
        {
            result.put("code", "2");
            System.out.println(e);
        }

        return result;
    }
    
    
    /* 프로젝트 컨텐츠 이미지 경로 이동 */
    @RequestMapping(value = "/moveContentImg")
    @ResponseBody
    public String moveContentImg(@RequestParam HashMap<String,String> params, HttpServletRequest req){
    	String tempUrl = "/var/upload/img/editor_temp";
    	String moveUrl = "/var/upload/img/editor";
    	
    	File tempDir = new File(tempUrl); 
    	File moveDir = new File(moveUrl);
    	
    	FileFilter filter = new FileFilter() {
    	    public boolean accept(File f) {
    	        return f.getName().startsWith(params.get("key"));
    	    }
    	};
    	
    	if(tempDir.exists()) { 
    		//파일 리스트 추출
    		File[] fileNames = tempDir.listFiles(filter);
    		
    		for(int i=0; i< fileNames.length; i++) { 
    			if(fileNames[i].isFile() && fileNames[i].exists() && moveDir.exists()) { 
    				File MoveFile = new File(moveDir, fileNames[i].getName()); 
    				// 이동될 파일 경로 및 파일 이름 
    				fileNames[i].renameTo(MoveFile); 
    				
    			}else{
    				return "프로젝트 내용 저장에 실패하였습니다. (이미지 or 이미지폴더 없음)";
    			}
    		}

    	}else{
    		return "프로젝트 내용 저장에 실패하였습니다. (이미지 Temp폴더 없음)";
    	}

    	return "ok";
    }   
   
    
}
