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
    <%-- 引入ztree的样式文件--%>
    <link rel="stylesheet" href="ztree/zTreeStyle.css">
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="conditionInp" class="form-control has-success" type="text"
                                       placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="queryRolesBtn" type="button" class="btn btn-warning"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button id="batchDelBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;">
                        <i
                                class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button id="showAddModalBtn" type="button" class="btn btn-primary" style="float:right;"><i
                            class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="checkAllBox" type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <!--追加appendTo-->
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <!--生成页码-->
                                    <ul class="pagination">

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

<%-- 新增角色的modal  模态框：默认不会显示 --%>
<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="exampleModalLabel">新增角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>

<%-- 更新角色的模态框 --%>
<div class="modal fade" id="updateRoleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="exampleModalLabel">更新角色</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id"/>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">角色名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateRoleBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%--   给角色分配权限的模态框 --%>
<div class="modal fade" id="assignPermissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="exampleModalLabe2">权限分配</h4>
            </div>
            <div class="modal-body">
                <%-- 显示权限树的容器 : ztree的依赖文件已经引入 --%>
                <ul id="permissiontree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="assignPermissionBtn" type="button" class="btn btn-primary">确认分配</button>
            </div>
        </div>
    </div>
</div>

<script src="bootstrap/js/bootstrap.min.js"></script>
<%@ include file="/WEB-INF/include/base_js.jsp" %>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>

<script type="text/javascript">
    //总页码
    var pages;
    // 当前页码
    var page;
    var rId;
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

    $("tbody .btn-success").click(function () {
        window.location.href = "assignPermission.html";
    });
    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('角色维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('角色维护')").css("color", "red");

    //当前页面已经解析完成，页面中暂时还没有角色列表的数据，默认需要查询第一页数据显示
    //通过ajax请求第一页数据显示
    initRoleTable(1);

    // 给分页导航栏的a标签绑定单击事件，或者使用事件委托实现
    /*本次案例使用delegate实现
    $("tfoot ul .navA").click(function () {
        alert("navA");
    });*/
    // delegate 事件委托 给a绑定事件
    $("tfoot ul").delegate(".navA", "click", function () {
        // 获取当前点击的页码 prop 获取的是undefined
        var pageNum = $(this).attr("pageNum");
        // 增加带条件的查询
        var conditionName = $("#conditionInp").val();
        initRoleTable(pageNum, conditionName);
    });

    // 方法抽取--initRoleTable 发起异步请求
    function initRoleTable(pageNum, condition) {
        // 先清空目标节点 避免节点重复
        // 角色显示
        $("tbody").empty();
        // 页码显示
        $("tfoot ul.pagination").empty();

        $.ajax({
            type: "get",
            url: "${PATH}/role/getRoles",
            data: {"pageNum": pageNum, "condition": condition},
            success: function (pageInfo) {
                if(pageInfo==403){
                    layer.msg("您访问的资源未授权，请联系管理员解析");
                    return;
                }
                //pageInfo中包含总页码和当前页码
                page = pageInfo.pageNum;
                pages = pageInfo.pages;

                //服务器响应成功后的回调函数
                layer.msg("请求role列表成功...");
                // 控制台打印数据
                // console.log(pageInfo);
                // 解析角色
                initRoleList(pageInfo);
                // 初始化页码
                initRoleNav(pageInfo);
            }
        });
    }

    // 方法抽取--initRoleList 显示当前页码的角色记录
    function initRoleList(pageInfo) {
        //自动遍历list集合，每遍历一个元素都会调用一次funcion函数
        $.each(pageInfo.list, function (i) {//i代表元素索引 从0开始计算
            //this代表正在调用方法的角色的json对象  this.name获取角色的name值
            // $() jQuery 核心函数 4 大作用 创建节点
            // 或者拼接字符串后， 使用html()添加
            $('<tr>\n' +
                '<td>' + (++i) + '</td>\n' +
                '<td><input id="' + this.id + '" type="checkbox"></td>\n' +
                '<td>' + this.name + '</td>\n' +
                '<td>\n' +
                '<button onclick="assignPermission(' + this.id + ')" type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>\n' +
                '<button id="' + this.id + '" type="button" class="btn btn-primary btn-xs showUpdateRoleModalBtn "><i class=" glyphicon glyphicon-pencil"></i></button>\n' +
                '<button id="' + this.id + '" type="button" class="btn btn-danger btn-xs delRoleBtn"><i class=" glyphicon glyphicon-remove"></i></button>\n' +
                '</td>\n' +
                '</tr>').appendTo("tbody");

        });
    }

    // 方法抽取--initRoleNav 生成分页页码
    function initRoleNav(pageInfo) {
        //上一页
        //判断，如果有上一页可以点击，如果没有上一页 禁用
        if (pageInfo.isFirstPage) {
            //当前页是第一页，禁用
            $('<li class="disabled"><a href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        } else {
            //当前页不是第一页，可以用
            $('<li><a pageNum="' + (pageInfo.pageNum - 1) + '" class="navA" href="javascript:void(0);">上一页</a></li>').appendTo("tfoot ul.pagination");
        }
        //中间页码：当前页高亮显示
        $.each(pageInfo.navigatepageNums, function () {
            // this  代表正在遍历的页码
            //判断正在遍历的页码是否为当前页，当前页高亮，否则正常
            if (this == pageInfo.pageNum) {
                $('<li class="active"><a href="javascript:void(0);">' + this + ' <span class="sr-only">(current)</span></a></li>').appendTo("tfoot ul.pagination");
            } else {
                $('<li><a pageNum="' + this + '" class="navA" href="javascript:void(0);">' + this + '</a></li>').appendTo("tfoot ul.pagination");
            }
        });
        //下一页
        if (pageInfo.isLastPage) {
            //当前页是最后一页，禁用
            $('<li class="disabled"><a href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        } else {
            //当前页不是最后一页，可以用
            $('<li><a pageNum="' + (pageInfo.pageNum + 1) + '" class="navA" href="javascript:void(0);">下一页</a></li>').appendTo("tfoot ul.pagination");
        }
    }

    // 增加带条件查询的
    $("#queryRolesBtn").click(function () {
        // 查询条件
        var conditionName = $("#conditionInp").val();
        // 查询页码
        var pageNum = 1;
        initRoleTable(pageNum, conditionName);
    });

    //======================角色新增的代码
    //点击新增按钮弹出模态框的单击事件
    $("#showAddModalBtn").click(function () {
        $('#addRoleModal').modal('toggle');
    });
    //给模态框提交按钮绑定单击事件：点击时收集角色数据异步提交给后台保存，响应成功关闭模态框，跳转到最后一页显示添加的结果
    $("#addRoleModal #addRoleBtn").click(function () {
        $.ajax({
            type: "post",
            data: $("#addRoleModal form").serialize(),
            url: "${PATH}/role/addRole",
            success: function (data) {
                if (data == "ok") {
                    //关闭模态框
                    $('#addRoleModal').modal('toggle');
                    //使用总页码
                    initRoleTable(pages + 1);
                }
            }
        });
    });

    // 20200620 角色删除-单个
    // 动态委托 绑定单击事件
    $("tbody").delegate("tr td .delRoleBtn", "click", function () {
        //获取删除按钮所在行的角色id
        var roleId = this.id;
        layer.msg("当前要删除的id = " + roleId);
        //发起异步请求交给后台删除
        $.get("${PATH}/role/delRole", {id: roleId}, function (data) {
            if (data == "ok") {
                //删除成功
                layer.msg("删除成功");
                //刷新当前页面
                initRoleTable(page);
            }
        });
    });

    // 20200620 角色删除-批量
    // 1、实现全选全不选功能
    $("#checkAllBox").click(function () {
        $("tbody :checkbox").prop("checked", this.checked);
    });
    $("tbody").delegate(":checkbox", "click", function () {
        var length = $("tbody :checkbox").length;
        var checkedLength = $("tbody :checkbox:checked").length;
        $("#checkAllBox").prop("checked", length == checkedLength);
    });

    // 2、获取选中按钮的 id 列表 发送请求
    $("#batchDelBtn").click(function () {
        if ($("tbody :checkbox:checked").length == 0) {
            layer.msg("请选中要删除的记录!");
            return false;
        }
        var ids = new Array();
        $("tbody :checkbox:checked").each(function () {
            ids.push(this.id);
        });
        var idsStr = ids.join();
        // 发送异步请求
        $.ajax({
            type: "get",
            data: {ids: idsStr},
            url: "${PATH}/role/batchDelRole",
            success: function (data) {
                if (data == "ok") {
                    layer.msg("批量删除成功");
                    initRoleTable(page);
                }
            }
        });
    });

    // 20200620 角色更新
    $("tbody").delegate(".showUpdateRoleModalBtn", "click", function () {
        //1、获取要更新的角色信息的id
        var roleId = this.id;
        alert(roleId);
        //2、异步请求id对应的角色信息
        $.get("${PATH}/role/getRole", {id: roleId}, function (role) {
            alert(role);
            //将服务器响应的role数据显示到模态框中
            $("#updateRoleModal input[name='id']").val(role.id);
            $("#updateRoleModal input[name='name']").val(role.name);
            //显示更新模态框
            $("#updateRoleModal").modal("toggle");
        });
    });

    $("#updateRoleModal #updateRoleBtn").click(function () {
        $.ajax({
            "type": "post",
            "data": $("#updateRoleModal form").serialize(),
            "url": "${PATH}/role/updateRole",
            success: function (data) {
                if (data == "ok") {
                    //角色更新成功
                    $("#updateRoleModal").modal("hide");
                    //刷新当前页面
                    initRoleTable(page);
                }
            }
        });
    });

    // 20200622 点击弹出模态框
    function assignPermission(roleId) {
        rId = roleId;
        $.ajax({
            "type": "get",
            "url": "${PATH}/permission/getPermissions",
            "success": function (permessions) {
                var zNodes = permessions;
                $.ajax({
                    "type": "get",
                    "url": "${PATH}/permission/getAssignedPermissionIds",
                    "data": {"roleId": roleId},
                    "success": function (assignedPermissionIds) {
                        $.each(zNodes, function () {
                            if (assignedPermissionIds.indexOf(this.id) >= 0) {
                                this.checked = true;
                            }
                        });
                        var setting = {
                            check: {
                                enable: true
                            },
                            data: {
                                key: {
                                    name: "title"
                                },
                                simpleData: {
                                    enable: true,
                                    pIdKey: "pid"
                                }
                            },
                            view: {
                                //自定义图标
                                addDiyDom: function (treeId, treeNode) {
                                    //移除默认的图标
                                    $("#" + treeNode.tId + "_ico").remove();
                                    //创建自定义图标的标签
                                    $("#" + treeNode.tId + "_span").before("<span class='" + treeNode.icon + "'></span>");
                                }
                            }
                        };
                        var $ztreeObj = $.fn.zTree.init($("#permissiontree"), setting, zNodes);
                        //自动展开
                        $ztreeObj.expandAll(true);
                        //当树加载成功后再显示模态框
                        $("#assignPermissionModal").modal("show");
                    }
                });
            }
        });
    }

    $("#assignPermissionModal #assignPermissionBtn").click(function () {
        var $treeObj = $.fn.zTree.getZTreeObj("permissiontree");
        var $checkedNodes = $treeObj.getCheckedNodes(true);
        var idsArr =  new Array();
        $.each($checkedNodes , function(){
            idsArr.push(this.id);
        });
        var idsStr = idsArr.join();
        $.ajax({
            "type":"get",
            "data":{"roleId": rId , "permissionIds": idsStr },
            "url":"${PATH}/role/reAssignPermissionToRole",
            "success":function (data) {
                if(data=="ok"){
                    layer.msg("更新权限列表成功");
                    $("#assignPermissionModal").modal("hide");
                }
            }
        });
    });

</script>
</body>
</html>
