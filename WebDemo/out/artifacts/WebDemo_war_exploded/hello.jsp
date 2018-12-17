<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/10
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MyFirstApp</title>
</head>
<body>
   <br>
   <div align="center">
       <table align="center">
           <tr>
           <td>
               <div align="center">欢迎 <%=request.getAttribute("USER")%>光临</div>
           </td>
           </tr>
       </table>
   </div>
</body>
</html>
