<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tree">
    <ul style="padding-left:0px;" class="list-group">
        <%--  获取存在域中的菜单集合遍历显示 --%>
        <c:choose>
            <c:when test="${empty pMenus}">
                <%--获取菜单失败--%>
                <h3>获取菜单失败</h3>
            </c:when>
            <c:otherwise>
                <c:forEach items="${pMenus}" var="pMenu">
                    <c:choose>
                        <c:when test="${empty pMenu.children}">
                            <%--父菜单没有子菜单--%>
                            <li class="list-group-item tree-closed" >
                                <a href="${PATH}/${pMenu.url}"><i class="${pMenu.icon}"></i> ${pMenu.name}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <%--有子菜单--%>
                            <li class="list-group-item tree-closed">
                                <span><i class="${pMenu.icon}"></i> ${pMenu.name} <span class="badge" style="float:right">${pMenu.children.size()}</span></span>
                                <ul style="margin-top:10px;display:none;">
                                        <%-- 遍历有子菜单的父菜单的子菜单集合 --%>
                                    <c:forEach items="${pMenu.children}" var="menu">
                                        <li style="height:30px;">
                                            <a href="${PATH}/${menu.url}"><i class="${menu.icon}"></i> ${menu.name}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
</div>

