<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--导入jstl核心库 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link href="${APP_PATH }/static/img/favicon.ico" rel='icon' type='image/x-icon'/>
</head>
<body>
<!-- 我的主页-头部 -->
<jsp:include page="/head/head.jsp"></jsp:include>
<!-- 我的主页-主体内容 -->
<jsp:include page="/content/mycontent.jsp"></jsp:include>
<!-- 我的主页-登录、注册 -->
<jsp:include page="/login/login.jsp"></jsp:include>
<!-- 我的主页-发帖 -->
<jsp:include page="/head/posted.jsp"></jsp:include>
<!-- 我的主页-基本信息设置 -->
<jsp:include page="/head/setup.jsp"></jsp:include>
<!-- 我的主页-编辑个人资料 -->
<jsp:include page="/content/edit.jsp"></jsp:include>
<!-- 我的主页-上传（修改）头像 -->
<jsp:include page="/content/userPhoto.jsp"></jsp:include>
<!-- 我的主页-修改帖子 -->
<jsp:include page="/content/articleEdits.jsp"></jsp:include>
<!-- 我的主页-收藏帖子展示 -->
<jsp:include page="/content/collectArticle.jsp"></jsp:include>
<%! String sense = ""; %>
<%
    //发帖后转到该界面，进行敏感词提醒
    //首先应该判断是否为空，否则会出错
    if (request.getSession().getAttribute("SenseWord") != null)
        sense = (String) request.getSession().getAttribute("SenseWord");
    if (!sense.equals("")) {
        sense = "你的文章中含有敏感字符，已交给管理员审核:\n " + sense;
%>
<input type="hidden" id="sensetive" value="<%=sense%>"></>
<script >alert(document.getElementById("sensetive").value)</script>

<script >alert("${"SenseWord"}")</script>

<%
        request.setAttribute("SenseWord", "");
    } else {
        //out.print("<script>alert(\"你的文章很好:\n"+sense+"\")</script>");
    }
%>
</body>
</html>