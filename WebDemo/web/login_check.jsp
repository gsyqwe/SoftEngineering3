<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/14
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%

    request.setCharacterEncoding("UTF-8");
    String name=request.getParameter("username");
    String password=request.getParameter("p");
    System.out.print(name+password);
    if(true){
        out.println("<script>alert('登陆成功！');window.location.href='test.html'</script>");
        session.setAttribute("user", name);
        session.setMaxInactiveInterval(60);
    }
    else
    {
        out.println("<script>alert('登陆失败！');window.location.href='login.jsp'</script>");
    }

%>