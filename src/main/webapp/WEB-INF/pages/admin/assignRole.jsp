<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/include/base_css.jsp" %>

    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%@ include file="/WEB-INF/include/admin_loginbar.jsp" %>

            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/include/admin_menubar.jsp" %>

        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label for="exampleInputPassword1">未分配角色列表</label><br>
                            <select id="unAssignedRoleSel" class="form-control" multiple size="10"
                                    style="width:300px;overflow-y:auto;">
                                <c:forEach items="${unAssignedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <%--  分配角色按钮 --%>
                                <li id="assignRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <%-- 删除角色按钮--%>
                                <li id="unAssignRoleBtn" class="btn btn-default glyphicon glyphicon-chevron-left"
                                    style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label for="exampleInputPassword1">已分配角色列表</label><br>
                            <select id="assignedRoleSel" class="form-control" multiple size="10"
                                    style="width:300px;overflow-y:auto;">
                                <c:forEach items="${assignedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/include/base_js.jsp" %>
<script type="text/javascript">
    // 20200621 编写代码
    /*
    * assignRoleBtn 分配按钮
    * unAssignRoleBtn 取消分配按钮
    * unAssignedRoleSel 未分配权限
    * assignedRoleSel 已分配权限
    * */
    $("#assignRoleBtn").click(function () {
        var selectLen = $("#unAssignedRoleSel :selected").length;
        if(selectLen==0){
            layer.msg("请选中权限后重试!");
            return;
        }
        // 获取角色id
        var rolesId = new Array();
        $("#unAssignedRoleSel :selected").each(function () {
            rolesId.push(this.value);
        });
        var rolesIdStr = rolesId.join();
        $.ajax({
            type:"post",
            data:{"adminId":"${param.id}","rolesId":rolesIdStr},
            url:"${PATH}/admin/assignRoleToAdmin",
            success:function (res) {
                if(res=="ok"){
                    $("#unAssignedRoleSel :selected").appendTo("#assignedRoleSel");
                    layer.msg("分配角色成功");
                }
            }
        });
    });

    $("#unAssignRoleBtn").click(function () {
        var selectLen = $("#assignedRoleSel :selected").length;
        if(selectLen==0){
            layer.msg("请选中权限后重试!");
            return;
        }
        // 获取角色id
        var rolesId = new Array();
        $("#assignedRoleSel :selected").each(function () {
            rolesId.push(this.value);
        });
        var rolesIdStr = rolesId.join();
        $.ajax({
            type:"post",
            data:{"adminId":"${param.id}","rolesId":rolesIdStr},
            url:"${PATH}/admin/unAssignedRoleToAdmin",
            success:function (res) {
                if(res=="ok"){
                    $("#assignedRoleSel :selected").appendTo("#unAssignedRoleSel");
                    layer.msg("取消角色成功!");
                }
            }
        });
    });

    // 拷贝内容
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('用户维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('用户维护')").css("color", "red");
</script>
</body>
</html>

