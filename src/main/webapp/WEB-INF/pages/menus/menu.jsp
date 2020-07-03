<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
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
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
                    <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i
                            class="glyphicon glyphicon-question-sign"></i></div>
                </div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
    </div>
</div>
<%--  新增菜单的模态框 --%>
<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">新增菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="pid" >
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name" >
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单图标:</label>
                        <input name="icon" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="addMenuBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%--  更新菜单的模态框--%>
<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">更新菜单</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id" />
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单名称:</label>
                        <input name="name" type="text" class="form-control" id="recipient-name">
                    </div>
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">菜单图标:</label>
                        <input name="icon" type="text" class="form-control" id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button id="updateMenuBtn" type="button" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/include/base_js.jsp" %>
<%-- 引入ztree js插件 --%>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">
    //== 20200620 zTree内容
    // zTree 的使用步骤
    /*
    1、引入js和css文件
    2、添加zTree容器 用于显示渲染好的数据
    3、settings 解析配置
    4、准备json数据
    5、调用zTree方法
     */
    // 添加settings 解析配置
    var settings = {
        view: {
            addHoverDom: function(treeId, treeNode){
                var aObj = $("#" + treeNode.tId + "_a");
                aObj.attr("href", "javascript:void(0);");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {//根节点
                    //只能拼接添加按钮  传参时如果是数值型可以直接传递，如果是字符串类型，需要加引号
                    s += '<a onclick="addMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {//枝节点
                    //修改按钮
                    s += '<a onclick="updateMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children==null || treeNode.children.length == 0) {
                        //没有儿子节点的枝节点可以被删除
                        //删除按钮
                        s += '<a  onclick="deleteMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    //添加按钮
                    s += '<a onclick="addMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {//叶子节点
                    //修改按钮
                    s += '<a  onclick="updateMenu('+treeNode.id+')" class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    //删除按钮
                    s += '<a  onclick="deleteMenu('+treeNode.id+')"  class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }

                s += '</span>';
                aObj.after(s);
            },
            removeHoverDom: function(treeId, treeNode){
                $("#btnGroup"+treeNode.tId).remove();
            },
            // 自定义ztree树每个标签创建的函数
            addDiyDom: function (treeId, treeNode) {
                //ztree树创建每一个节点时，都会调用一次此方法，并传入ztree树的id(treeDemo)，正在调用当前方法的节点对象
                // console.log(treeId);
                // console.log(treeNode);
                // treeNode.tId _a标题包含 _ico图标 _span标题名称
                //移除span标签： tId+"_ico"
                $("#"+treeNode.tId+"_ico").remove();
                // 添加自定义图标
                $("#"+treeNode.tId+"_span").before('<span class="'+treeNode.icon+'"></span>');
                //获取a标签，设置target属性值为空，避免跳转
                $("#"+treeNode.tId+"_a").prop("target","");
            }
        },
        data: {
            key: {
                url: "abc"//填写不存在的属性名，ztree就不会再节点a标签中设置href属性值
            },
            simpleData: {
                enable: true,
                pIdKey: "pid"//指定查询到的菜单数据  ztree自动识别父子菜单的属性名
            }
        }
    };

    // ajax 异步请求菜单列表
    function initMenuTree(){
        $.ajax({
            type: "post",
            data: {}, // 可以省略
            url: "${PATH}/menu/getMenus",
            success: function (menus) {
                // 页面加载时 异步请求 控制台输入数据
                // console.log(menus);
                // 添加一个跟节点
                menus.push({id: 0, name: "系统权限菜单", icon: "glyphicon glyphicon-random"});
                // 调用init方法渲染 返回一个jq对象
                var $zTreeObj = $.fn.zTree.init($("#treeDemo"), settings, menus);
                //自动展开zTree的所有节点
                $zTreeObj.expandAll(true);
            }
        });
    }
    initMenuTree();

    // 20200621 增删改功能
    // 新增菜单
    // 点击新增按钮显示模态框
    function addMenu(pid){
        $("#addMenuModal form [name='pid']").val(pid);
        $("#addMenuModal").modal("toggle");
    }
    // 提交
    $("#addMenuModal #addMenuBtn").click(function () {
        $.ajax({
            type:"post",
            data:$("#addMenuModal form").serialize(),
            url:"${PATH}/menu/addMenu",
            success:function (data) {
                if(data="ok"){
                    layer.msg("新增成功");
                    //关闭新增模态框
                    $("#addMenuModal").modal("toggle");
                    //刷新菜单树
                    initMenuTree();
                }
            }
        });
    });

    // 删除菜单
    function deleteMenu(id){
        layer.confirm("您真的要删除当前菜单吗？",{icon:3,title:"删除提示"},function (index) {
            $.ajax({
                type:"get",
                data:{id:id},
                url:"${PATH}/menu/deleteMenu",
                success:function (data) {
                    if(data=="ok"){
                        layer.close(index);
                        initMenuTree();
                    }
                }
            });
        })
    }

    // 更新菜单
    function updateMenu(id) {
        //layer.alert("updateMenu , id:"+id);
        //查询要更新的菜单的数据
        $.getJSON("${PATH}/menu/getMenu",{id:id} , function (menu) {
            //回显到模态框中
            $("#updateMenuModal form [name='id']").val(menu.id);
            $("#updateMenuModal form [name='name']").val(menu.name);
            $("#updateMenuModal form [name='icon']").val(menu.icon);
            //显示模态框
            $("#updateMenuModal").modal("toggle");
        })
    }
    //给更新的模态框的提交按钮绑定单击事件：提交更新请求到后台，更新成功后，关闭模态框，刷新菜单树
    $("#updateMenuModal #updateMenuBtn").click(function () {
        $.ajax({
            type:"post",
            data:$("#updateMenuModal form").serialize(),
            url:"${PATH}/menu/updateMenu",
            success:function (data) {
                if(data="ok"){
                    //关闭模态框
                    $("#updateMenuModal").modal("toggle");
                    //提示
                    layer.msg("更新成功",{time:1000});
                    //刷新菜单树
                    initMenuTree();
                }
            }
        });
    });

    //== 20200620 自带js
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
    $("a:contains('菜单维护')").parents("ul:hidden").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('菜单维护')").css("color", "red");
</script>
</body>
</html>


