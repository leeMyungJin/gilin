package com.gilin.Cms.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LandingController {

    @GetMapping("/intro")
    public String index() {
        return "landing";
    }

    @GetMapping("/navere18219d83dccb3af9f1d431c2177bd6e.html")
    public String naverSearch() {
        return "navere18219d83dccb3af9f1d431c2177bd6e";
    }

}
