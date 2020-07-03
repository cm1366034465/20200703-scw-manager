package com.atguigu.scw.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DispatcherController {
    @Bean
    public PasswordEncoder getEncoder(){
        return new BCryptPasswordEncoder();
    }

    // 转发到index界面
    @RequestMapping(value = {"/index", "/", "/index.html"})
    public String toIndexPage() {
        return "index";
    }

    @GetMapping("/login.html")
    public String toLoginPage(){
        return "login";
    }

    @ResponseBody
    @PostMapping("/testAb")
    public String testAb(Integer id){
        System.out.println("id = " + id);
        return "xxx";
    }
}
