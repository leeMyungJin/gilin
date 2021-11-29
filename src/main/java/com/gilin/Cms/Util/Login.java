package com.gilin.Cms.Util;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

@Component
public class Login {

    public static boolean isAdmin() {
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
        String admin =  httpSession.getAttribute("adminYn") != null
                ? (String) httpSession.getAttribute("adminYn")
                : "";
        if (admin.equals("t")) {
            return true;
        }else {
            return false;
        }
    }

    public static String getId() {
        ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
        return httpSession.getAttribute("id") != null
                ? (String) httpSession.getAttribute("id")
                : "";
    }



}
