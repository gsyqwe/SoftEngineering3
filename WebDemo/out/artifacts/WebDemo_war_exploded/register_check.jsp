<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/14
  Time: 19:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String name=request.getParameter("user");
    String password1=request.getParameter("passwd");
    String password2=request.getParameter("passwd2");
    String telephone=request.getParameter("qq");
    System.out.print(name+password1+password2+telephone);

    if((name==null||name.length()==0)||(password1==null||password1.length()==0)||(password2==null||password2.length()==0)||(telephone==null||telephone.length()==0))
        out.println("<script>alert('请将信息填写完整！')</script>");
    else if(!password1.equals(password2))
        out.println("<script>alert('两次密码不一致！')</script>");
    else
        out.println("<script>alert('注册成功！');window.location.href='login.jsp'</script>");


%>
