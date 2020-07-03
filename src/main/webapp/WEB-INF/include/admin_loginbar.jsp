<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<ul class="nav navbar-nav navbar-right">
    <li style="padding-top:8px;">
        <div class="btn-group">
            <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i> <%--${sessionScope.admin.loginacct}--%><sec:authentication property="name"></sec:authentication> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                <li class="divider"></li>
                <li><a href="javascript:void(0);" id="logoutA"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>

            </ul>
            <form id="logoutForm" method="post" action="${PATH}/admin/logout"></form>
        </div>
    </li>
    <li style="margin-left:10px;padding-top:8px;">
        <sec:authorize access="hasAnyRole('PG - 程序员')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 程序员帮助
            </button>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('TL - 组长' , 'GL - 组长')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 组长帮助
            </button>
        </sec:authorize>
        <sec:authorize access="hasAnyRole('PM - 项目经理')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 项目经理帮助
            </button>
        </sec:authorize>
    </li>
</ul>
