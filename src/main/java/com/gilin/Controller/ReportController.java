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

import com.gilin.Service.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {
    
	@Autowired
	ReportService ReportService;
	
    @RequestMapping(value = "/myreport", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveMyreport(Model model) {
    	return "report/myreport";
    }
	
   
    
}
