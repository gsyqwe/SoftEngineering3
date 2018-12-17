<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/28
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    List list=new ArrayList();
%>
<head>
    <title>Title</title>
</head>
<body>

</body>


<script>
    function  f(i) {
           <%=list.get(i)%>
    }
</script>
</html>
