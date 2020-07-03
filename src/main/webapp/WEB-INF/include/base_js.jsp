<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<base  href="${PATH}/static/"/>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>
<%-- 引入ztree js插件 必须先引入jq文件--%>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>
<%--注销超链接的单击事件--%>
<script type="text/javascript">
    $("#logoutA").click(function () {
        layer.confirm("您确定退出吗?",{"title":"登出提示",icon:3} ,function () {
            //确认按钮单击事件
            //提交注销请求
            // location = "${PATH}/admin/logout";
            $("#logoutForm").submit();
        } )
    });

</script>