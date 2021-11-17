package com.gilin.Cms.Controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gilin.Cms.Service.*;
import com.gilin.Cms.Vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CmsController {

    @Autowired
    CmsMemberService cmsMemberService;

    @Autowired
    CmsTermsService termsService;

    @Autowired
    AppVersionService appVersionService;

    @Autowired
    CmsChannelService cmsChannelService;

    @Autowired
    CmsProjectService cmsProjectService;

    @Autowired
    CmsNoticeService cmsNoticeService;

    @Autowired
    CmsPushService cmsPushService;


    private String path = "/var/upload/img/";


    @GetMapping("/cms/user")
    public String index(Model model) throws JsonProcessingException {

        Map<String, Integer> userCount = cmsMemberService.getCount();
        String appVersion = appVersionService.getVersion();

        model.addAttribute("count", userCount);
        model.addAttribute("version", appVersion);

        return "cms/user";
    }

//    @GetMapping("/user")
//    public String user(Model model) throws JsonProcessingException {
//
//        List<CmsMemberVo> userList = cmsMemberService.getList();
//        String json = new ObjectMapper().writeValueAsString(userList);
//        model.addAttribute("lists", json);
//
//        return "cms/user";
//
//    }

    @GetMapping("/getListSearch")
    @ResponseBody
    public List<CmsMemberVo> getListSearch(@RequestParam HashMap<String,Object> params) {

        List<CmsMemberVo> userList = cmsMemberService.getListSearch(params);

        return userList;
    }

    @PostMapping("/appversion/update")
    @ResponseBody
    public void updateAppversion(HttpServletRequest req) {
        appVersionService.update(req.getParameter("version"));
    }


    @GetMapping("/cms/terms")
    public String terms(Model model) throws JsonProcessingException {
        List<CmsTermsVo> cmsTermsVo = termsService.getTerms();
        Map<String, String> contents = new HashMap<>();
        for (CmsTermsVo terms : cmsTermsVo) {

            switch (terms.getSubject())
            {
                case "이용약관":
                    contents.put("service", terms.getContent());
                    break;
                case "개인정보수집약관" :
                    contents.put("privacy", terms.getContent());
                    break;
                default: break;
            }

        }

        String json = new ObjectMapper().writeValueAsString(contents);
        model.addAttribute("terms", json);
        return "cms/terms";
    }

    @PostMapping("/terms/update")
    @ResponseBody
    public void termsUpdate(CmsTermsVo cmsTermsVo) {
        termsService.termsUpdate(cmsTermsVo);
    }





    @GetMapping("/cms/channel")
    public String channel(Model model) throws JsonProcessingException {

//        List<ChannelVo> channelVoList = channelService.getList();
        Map<String, Integer> channelCount = cmsChannelService.getCount();

//        String lists = new ObjectMapper().writeValueAsString(channelVoList);

//        model.addAttribute("lists", lists);
        model.addAttribute("count", channelCount);

        return "cms/channel";
    }

    @GetMapping("/cms/channel/more")
    @ResponseBody
    public List<CmsChannelVo> channelMore(@RequestParam HashMap<String,Object> params) {
        List<CmsChannelVo> cmsChannelVoList = cmsChannelService.getListBySearch(params);
        return cmsChannelVoList;
    }

    @PostMapping("/cms/channel/modify")
    @ResponseBody
    public void channelModify(CmsChannelVo cmsChannelVo) throws Exception {

        if (!cmsChannelVo.getChImgFileUpload().isEmpty()) {

            try {
                MultipartFile multi = cmsChannelVo.getChImgFileUpload();
                String originFileName = multi.getOriginalFilename();
                String ext = originFileName.substring(originFileName.lastIndexOf("."), originFileName.length());
                long size = multi.getSize();
                String uploadpath = path;

                String fileName = "";

                Calendar calendar = Calendar.getInstance();

                fileName += calendar.get(Calendar.YEAR);
                fileName += calendar.get(Calendar.MONTH);
                fileName += calendar.get(Calendar.DATE);
                fileName += calendar.get(Calendar.HOUR);
                fileName += calendar.get(Calendar.MINUTE);
                fileName += calendar.get(Calendar.SECOND);
                fileName += calendar.get(Calendar.MILLISECOND);
                fileName += ext;

                String saveFileName = fileName;
                File file = new File(uploadpath, saveFileName);
                if(!file.exists()) // 해당 경로가 없을 경우
                    file.mkdirs();  // 폴더 생성
                multi.transferTo(file);
                cmsChannelVo.setChImg("https://gilin.co.kr/img/"+saveFileName);
            } catch(Exception e) {
                System.out.println(e.getMessage());
            }

        }

        cmsChannelService.update(cmsChannelVo);
    }

    @PostMapping("/cms/channel/delete")
    @ResponseBody
    public void channelDelete(CmsChannelVo cmsChannelVo) {
        cmsChannelService.delete(cmsChannelVo);
    }

    @PostMapping("/cms/channel/create")
    @ResponseBody
    public void channelCreate(CmsChannelVo cmsChannelVo) {

        if (!cmsChannelVo.getChImgFileUpload().isEmpty()) {

            try {
                MultipartFile multi = cmsChannelVo.getChImgFileUpload();
                String originFileName = multi.getOriginalFilename();
                String ext = originFileName.substring(originFileName.lastIndexOf("."), originFileName.length());
                long size = multi.getSize();
                String uploadpath = path;

                String fileName = "";

                Calendar calendar = Calendar.getInstance();

                fileName += calendar.get(Calendar.YEAR);
                fileName += calendar.get(Calendar.MONTH);
                fileName += calendar.get(Calendar.DATE);
                fileName += calendar.get(Calendar.HOUR);
                fileName += calendar.get(Calendar.MINUTE);
                fileName += calendar.get(Calendar.SECOND);
                fileName += calendar.get(Calendar.MILLISECOND);
                fileName += ext;

                String saveFileName = fileName;
                File file = new File(uploadpath, saveFileName);
                if(!file.exists()) // 해당 경로가 없을 경우
                    file.mkdirs();  // 폴더 생성
                multi.transferTo(file);
                cmsChannelVo.setChImg("https://gilin.co.kr/img/"+saveFileName);
            } catch(Exception e) {
                System.out.println(e.getMessage());
            }

        }


        cmsChannelService.create(cmsChannelVo);
    }


    @GetMapping("/cms/project")
    public String project(Model model) throws JsonProcessingException {

        List<CmsProjectVo> cmsProjectVoList = cmsProjectService.getProjectList();
        Map<String, Integer> projectCount = cmsProjectService.getProjectCount();

        String lists = new ObjectMapper().writeValueAsString(cmsProjectVoList);

        model.addAttribute("lists", lists);
        model.addAttribute("count", projectCount);


        return "cms/project";

//        List<ProjectVo> projectVoList = projectService.getList();
//        Map<String, Integer> projectCount = projectService.getCount();
//        System.out.println(projectVoList);

//        String lists = new ObjectMapper().writeValueAsString(projectVoList);

//        model.addAttribute("lists", lists);
//        model.addAttribute("count", projectCount);

//        return "project";
    }

    @GetMapping("/cms/project/more")
    @ResponseBody
    public List<CmsProjectVo> projectMore(@RequestParam HashMap<String,Object> params) {
        List<CmsProjectVo> cmsProjectVoList = cmsProjectService.getListBySearch(params);
        return cmsProjectVoList;
    }


    @PostMapping("/cms/project/modify")
    @ResponseBody
    public void projectModify(CmsProjectVo cmsProjectVo) throws Exception {

        if (!cmsProjectVo.getPjImageFileUpload().isEmpty()) {

            try {
                MultipartFile multi = cmsProjectVo.getPjImageFileUpload();
                String originFileName = multi.getOriginalFilename();
                String ext = originFileName.substring(originFileName.lastIndexOf("."), originFileName.length());
                long size = multi.getSize();
                String uploadpath = path;

                String fileName = "";

                Calendar calendar = Calendar.getInstance();

                fileName += calendar.get(Calendar.YEAR);
                fileName += calendar.get(Calendar.MONTH);
                fileName += calendar.get(Calendar.DATE);
                fileName += calendar.get(Calendar.HOUR);
                fileName += calendar.get(Calendar.MINUTE);
                fileName += calendar.get(Calendar.SECOND);
                fileName += calendar.get(Calendar.MILLISECOND);
                fileName += ext;

                String saveFileName = fileName;
                File file = new File(uploadpath, saveFileName);
                if(!file.exists()) // 해당 경로가 없을 경우
                    file.mkdirs();  // 폴더 생성
                multi.transferTo(file);
                cmsProjectVo.setPjImg("https://gilin.co.kr/img/"+saveFileName);

            } catch(Exception e) {
                System.out.println(e.getMessage());
            }

        }

        cmsProjectService.update(cmsProjectVo);
    }


    @PostMapping("/cms/project/delete")
    @ResponseBody
    public void ProjectDelete(@RequestParam HashMap<String, Object> params) {
        cmsProjectService.delete(params);
    }


    @PostMapping("/cms/project/create")
    @ResponseBody
    public void projectCreate(CmsProjectVo cmsProjectVo) {

        if (!cmsProjectVo.getPjImageFileUpload().isEmpty()) {

            try {
                MultipartFile multi = cmsProjectVo.getPjImageFileUpload();
                String originFileName = multi.getOriginalFilename();
                String ext = originFileName.substring(originFileName.lastIndexOf("."), originFileName.length());
                long size = multi.getSize();
                String uploadpath = path;

                String fileName = "";

                Calendar calendar = Calendar.getInstance();

                fileName += calendar.get(Calendar.YEAR);
                fileName += calendar.get(Calendar.MONTH);
                fileName += calendar.get(Calendar.DATE);
                fileName += calendar.get(Calendar.HOUR);
                fileName += calendar.get(Calendar.MINUTE);
                fileName += calendar.get(Calendar.SECOND);
                fileName += calendar.get(Calendar.MILLISECOND);
                fileName += ext;

                String saveFileName = fileName;


                cmsProjectVo.setPjImg("https://gilin.co.kr/img/"+saveFileName);
                File file = new File(uploadpath, saveFileName);
                if(!file.exists()) // 해당 경로가 없을 경우
                    file.mkdirs();  // 폴더 생성
                multi.transferTo(file);


            } catch(Exception e) {
                System.out.println(e.getMessage());
            }

        }

        cmsProjectService.create(cmsProjectVo);
    }


    @GetMapping("/cms/notice")
    public String notice(Model model) {
        Map<String, Integer> count = cmsNoticeService.getCount();
        model.addAttribute("count", count);
        return "cms/notice";
    }


    @GetMapping("/cms/notice/more")
    @ResponseBody
    public List<CmsNoticeVo> noticeMore(@RequestParam HashMap<String,Object> params) {
        List<CmsNoticeVo> cmsNoticeVoList = cmsNoticeService.getListBySearch(params);
        return cmsNoticeVoList;
    }


    @PostMapping("/cms/channel/validation")
    @ResponseBody
    public CmsChannelVo ChannelValidationByName(@RequestParam String chName) {
        CmsChannelVo cmsChannelVo = cmsChannelService.validationByName(chName);
        return cmsChannelVo;
    }

    @PostMapping("/cms/notice/create")
    @ResponseBody
    public void NoticeCreate(@RequestParam HashMap<String, Object> params) {
        cmsNoticeService.create(params);
    }

    @PostMapping("/cms/notice/update")
    @ResponseBody
    public void NoticeUpdate(@RequestParam HashMap<String, Object> params) {
        cmsNoticeService.update(params);
    }


    @PostMapping("/cms/notice/delete")
    @ResponseBody
    public void NoticeDelete(@RequestParam HashMap<String, Object> params) {
        cmsNoticeService.delete(params);
    }

    @GetMapping("/cms/push/more")
    @ResponseBody
    public List<CmsPushVo> pushMore(@RequestParam HashMap<String,Object> params) {
        List<CmsPushVo> pushVoList = cmsPushService.getListBySearch(params);
        return pushVoList;
    }


    @PostMapping("/cms/editor/upload")
    @ResponseBody
    public Map<String, String> uploadImage(@RequestParam("file") MultipartFile multi, HttpServletRequest request, HttpServletResponse response) throws Exception {

        Map<String, String> result = new HashMap<>();

        try {

            String uploadpath = path + "/editor/";
            String originFilename = multi.getOriginalFilename();
            String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
            long size = multi.getSize();
            String saveFileName = "";

            Calendar calendar = Calendar.getInstance();
            saveFileName += calendar.get(Calendar.YEAR);
            saveFileName += calendar.get(Calendar.MONTH);
            saveFileName += calendar.get(Calendar.DATE);
            saveFileName += calendar.get(Calendar.HOUR);
            saveFileName += calendar.get(Calendar.MINUTE);
            saveFileName += calendar.get(Calendar.SECOND);
            saveFileName += calendar.get(Calendar.MILLISECOND);
            saveFileName += extName;

            if(!multi.isEmpty())
            {
                File file = new File(uploadpath, saveFileName);
                if(!file.exists()) // 해당 경로가 없을 경우
                    file.mkdirs();  // 폴더 생성
                multi.transferTo(file);
                String url = "https://gilin.co.kr/img/editor/"+saveFileName;
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


    @GetMapping("/termsUse")
    public String termsUse(Model model) {

        List<CmsTermsVo> cmsTermsVo = termsService.getTerms();
        Map<String, String> contents = new HashMap<>();
        for (CmsTermsVo terms : cmsTermsVo) {

            switch (terms.getSubject())
            {
                case "이용약관":
                    contents.put("service", terms.getContent());
                    break;
                case "개인정보수집약관" :
                    contents.put("privacy", terms.getContent());
                    break;
                default: break;
            }

        }

        model.addAttribute("title", "이용약관");
        model.addAttribute("terms", contents.get("service"));

        return "terms/terms";
    }

    @GetMapping("/termsPrivacy")
    public String termsPrivacy(Model model) {

        List<CmsTermsVo> cmsTermsVo = termsService.getTerms();
        Map<String, String> contents = new HashMap<>();
        for (CmsTermsVo terms : cmsTermsVo) {

            switch (terms.getSubject())
            {
                case "이용약관":
                    contents.put("service", terms.getContent());
                    break;
                case "개인정보수집약관" :
                    contents.put("privacy", terms.getContent());
                    break;
                default: break;
            }

        }

        model.addAttribute("title", "개인정보처리방침");
        model.addAttribute("terms", contents.get("privacy"));

        return "terms/terms";
    }

    @GetMapping("/m/notice")
    public String mobileNotice(Model model) {
        List<CmsNoticeVo> noticeList = cmsNoticeService.getList();
        List<CmsNoticeVo> mustList = cmsNoticeService.getMustList();
        System.out.println(mustList.toString());

        model.addAttribute("CmsNoticeVo", noticeList);
        model.addAttribute("mustList", mustList);
        return "mobile/notice";
    }

}
