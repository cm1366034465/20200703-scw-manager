<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 引入核心标签库--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--  静态资源[jquery/bs ] 不能放在WEB-INF，存放在webapp目录下--%>
<%-- Controller映射方法 和static文件夹 相当于在同一级目录下--%>
<base  href="${PATH}/static/"/>
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/carousel.css">
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/main.css">

<%--
    <%@ include file="/WEB-INF/include/base_css.jsp"%>
    <%@ include file="/WEB-INF/include/base_js.jsp"%>
--%>