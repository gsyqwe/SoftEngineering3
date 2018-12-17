<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/16
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    //得到当前用户的数组对象
    ArrayList array=(ArrayList) session.getAttribute("xxx");
%>

<div style="border: 2px solid black">
    <table style="width:100%;height:80%;border: red 2px">
    <%
        for(int i=0;i<2;i++){
    %>
        <tr>
            <%
                for(int j=0;j<3;j++){
            %>
            <td  width="200px" height="200px" style=" border: 2px solid #198BD4 ">
                456
            </td>
            <%
                }
            %>
        </tr>
        <%
            }
        %>


    </table>
</div>

</body>
</html>
