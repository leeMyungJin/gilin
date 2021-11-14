package com.gilin.Controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gilin.Service.MainService;

@Controller
public class MainController {
	
	@Autowired
	MainService MainService;
	
	@RequestMapping(value = "/", method = {RequestMethod.POST , RequestMethod.GET})
    public String intro() {
        return "main/main";
    }
	
	@RequestMapping(value = "/search", method = {RequestMethod.POST , RequestMethod.GET})
    public String moveSearchMain(@RequestParam HashMap<String,Object> params, Model model) {
		model.addAttribute("topSearch", params.get("topSearch"));
        return "main/main";
    }
	
	@RequestMapping(value = "/index", method = {RequestMethod.POST , RequestMethod.GET})
    public String index() {
        return "index";
    }
}
