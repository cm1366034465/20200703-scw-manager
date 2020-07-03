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

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%--登录状态栏--%>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form action="${PATH}/admin/index" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input name="condition" value="${param.condition}" class="form-control has-success"
                                       type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button id="batchDelAdmins" type="button" class="btn btn-danger"
                            style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${PATH}/admin/add.html'"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <%-- table分为 thead  tbody  tfoot --%>
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%-- 遍历 admins显示 --%>
                            <c:choose>
                                <c:when test="${empty pageInfo.list}">
                                    <%--么有管理员数据--%>
                                    <tr>
                                        <td colspan="6">没有查询到管理员数据</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <%--有管理员数据--%>
                                    <%-- varstatus: 遍历的状态对象
                                        当遍历开始标签会创建varstatus对象记录当前的遍历状态
                                        每次遍历会自动迭代

                                        包含[正在遍历元素索引、已经遍历了几个元素]
                                     --%>
                                    <c:forEach varStatus="vs" items="${pageInfo.list}" var="admin">
                                        <tr>
                                            <td>${vs.count}</td>
                                            <td><input id="${admin.id}" type="checkbox"></td>
                                            <td>${admin.loginacct}</td>
                                            <td>${admin.username}</td>
                                            <td>${admin.email}</td>
                                            <td>
                                                <button onclick="window.location='${PATH}/admin/toAssignRolePage?id=${admin.id}'" type="button" class="btn btn-success btn-xs"><i
                                                        class=" glyphicon glyphicon-check"></i></button>
                                                <button adminId="${admin.id}" type="button"
                                                        class="btn btn-primary btn-xs editBtn"><i
                                                        class=" glyphicon glyphicon-pencil"></i></button>
                                                <button adminId="${admin.id}" loginAcct="${admin.loginacct}"
                                                        type="button"
                                                        class="btn btn-danger btn-xs deleteBtn"><i
                                                        class=" glyphicon glyphicon-remove"></i></button>
                                            </td>
                                        </tr>

                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>


                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <%--上一页--%>
                                        <c:choose>
                                            <c:when test="${pageInfo.isFirstPage}">
                                                <%--是第一页，上一页不能点击--%>
                                                <li class="disabled"><a href="javascript:void(0);">上一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <%--不是第一页--%>
                                                <li>
                                                    <a href="${PATH}/admin/index?pageNum=${pageInfo.pageNum-1}&condition=${param.condition}">上一页</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>

                                        <%--中间页码--%>
                                        <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                                            <c:choose>
                                                <c:when test="${pageInfo.pageNum==index}">
                                                    <%--正在显示当前页码  高亮显示--%>
                                                    <li class="active" style="background-color: #00CCFF"><a
                                                            href="javascript:void(0);">${index} <span class="sr-only">(current)</span></a>
                                                    </li>
                                                </c:when>
                                                <c:otherwise>
                                                    <%--不是当前页--%>
                                                    <li>
                                                        <a href="${PATH}/admin/index?pageNum=${index}&condition=${param.condition}">${index}</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>

                                        <%--下一页--%>
                                        <c:choose>
                                            <c:when test="${pageInfo.isLastPage}">
                                                <%--是最后一页，下一页不能点击--%>
                                                <li class="disabled"><a href="javascript:void(0);">下一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <%--不是最后一页--%>
                                                <li>
                                                    <a href="${PATH}/admin/index?pageNum=${pageInfo.pageNum+1}&condition=${param.condition}">下一页</a>
                                                </li>
                                            </c:otherwise>
                                        </c:choose>
                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/include/base_js.jsp" %>
<script type="text/javascript">
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

    $("tbody .btn-primary").click(function () {
        window.location.href = "edit.html";
    });

    // 20200617 14:31
    $(".deleteBtn").click(function () {
        var adminId = $(this).attr('adminId');
        var loginAcct = $(this).attr('loginAcct');
        // 增加确认框
        layer.confirm("您确定删除账号" + loginAcct + "吗?", {"title": "删除提示", icon: 3}, function () {
            location.href = "${PATH}/admin/deleteAdmin?id=" + adminId;
        })
    });

    $(".editBtn").click(function () {
        var adminId = $(this).attr('adminId');
        alert("修改用户 = " + adminId);
        location.href = "${PATH}/admin/edit.html?id=" + adminId;
    });

    // 给全选/全不选节点绑定事件
    $("thead input:checkbox").click(function () {
        $("tbody input:checkbox").prop("checked", this.checked);
    });

    // 给子节点绑定事件
    $("tbody input:checkbox").click(function () {
        var boxLen = $("tbody input:checkbox").length;
        var checkLen = $("tbody input:checkbox:checked").length;
        $("thead input:checkbox").prop("checked", boxLen == checkLen);
    });

    // 批量删除
    $("#batchDelAdmins").click(function () {
        if ($("tbody input:checkbox:checked").length == 0) {
            layer.msg("当前没有选中任何记录,请核对后重试！");
            return;
        }
        // 定义数组存储id
        var idsArr = new Array();
        // 遍历选中节点 获取所有的id
        $("tbody input:checkbox:checked").each(function () {
            idsArr.push(this.id);
        });
        // 使用join方法 1,2,3,4...
        var idsStr = idsArr.join();

        // 确认提示框
        layer.confirm("您确定要批量删除记录吗?", {"title": "批量删除提示", icon: 2}, function () {
            layer.msg("已接收删除请求,请稍等！");
            setTimeout(function () {
                location.href = "${PATH}/admin/batchDeleteAdmins?ids=" + idsStr;
            }, 1000);
        })
    });

    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('用户维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('用户维护')").css("color", "red");
</script>
</body>
</html>

