package com.atguigu.scw.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//启用security的web功能
@EnableWebSecurity
//启用spring security通过controller映射进行权限认证的功能
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
public class AppSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    PasswordEncoder encoder;
    //授权方法
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //super.configure(http);  默认规则，拦截所有请求
        //1、放行首页和静态资源+登录页面
        http.authorizeRequests()   //对请求进行授权
                //permitAll()   授权所有人都可以访问
                .antMatchers("/index", "/", "/static/**", "/login.html").permitAll()   //匹配的地址都是浏览器访问资源的地址
                //authenticated()  表示需要认证
                .anyRequest().authenticated();//其他任意请求都需要认证

        //2、使用SpringSecurity接管登录：springSecurity需要在登录时为登录用户创建主体(账号信息+权限角色信息)
        http.formLogin()
                //以下配置需要和登录页面的配置一致，取代AdminController的login方法
                .loginPage("/login.html")   //指定登录页面
                .loginProcessingUrl("/dologin") //指定处理登录请求的url   如果表单提交方式为post
                .usernameParameter("loginacct")  //指定浏览器提交登录请求的账号参数
                .passwordParameter("userpswd")  //指定浏览器提交登录请求的密码参数
                .defaultSuccessUrl("/admin/main.html");  //指定登录成功后要跳转的地址
        // 禁用跨站点攻击
        http.csrf().disable();

        //3、配置浏览器提交的注销请求 springsecurity如何接受管理
        http.logout()
                .logoutUrl("/admin/logout") //配置注销请求提交的url地址
                .logoutSuccessUrl("/index");   //注销之后的重定向地址

        http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
            @Override
            public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException, IOException {
                //判断请求是同步还是异步
                if("XMLHttpRequest".equals(httpServletRequest.getHeader("X-Requested-With")))			{
                    //异步访问未授权的url地址时，只需要响应少量的错误提示即可
                    //X-Requested-With: XMLHttpRequest
                    httpServletResponse.getWriter().write("403");
                }else{
                    //同步访问未授权页面跳转的处理方法
                    String message = e.getMessage();
                    httpServletRequest.setAttribute("errorMsg" , message);
                    //转发到错误页面
                    httpServletRequest.getRequestDispatcher("/WEB-INF/pages/error/403.jsp").forward(httpServletRequest,httpServletResponse);
                }
            }
        });
    }


    @Autowired
    UserDetailsService userDetailsService;

    //主体创建
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        //浏览器如何提交登录请求给此方法处理
        //passwordEncoder(new MessageDigestPasswordEncoder("MD5"))
        //指定springsecurity验证数据库查询到的密码和浏览器提交的明文密码 加密方式
        //userDetailsService()设置自定义登录业务类对象的方法
        // auth.userDetailsService(userDetailsService).passwordEncoder(new MessageDigestPasswordEncoder("MD5"));
        auth.userDetailsService(userDetailsService).passwordEncoder(encoder);
    }
}