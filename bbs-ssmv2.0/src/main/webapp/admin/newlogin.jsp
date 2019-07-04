<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>管理员(登录、注册)</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
</head>
<body>
<div class="adminform">
   <form action="${APP_PATH}/adminController/getLogin" method="post">
        <div class="form-group">
             <input type="text" class="form-control" name="aname"
                    required="required" placeholder="用户名">
        </div>
        <div class="form-group">
             <input type="password" class="form-control" name="apassword"
                    required="required" placeholder="密码">
        </div>
        <div class="form-group">
            <div class="row" style="position: relative; top: 10px;">
                <div class="col-md-8">
                    <button type="reset" class="btn btn-default">清除</button>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-primary">登录</button>
                </div>
            </div>
            <div class="text-danger text-center"
                  style="position: relative; top: 20px; font-size: 10px;">
            </div>
        </div>
   </form>
</div>
</body>
</html>