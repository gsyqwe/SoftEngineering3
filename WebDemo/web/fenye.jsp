<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/14
  Time: 19:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<div style="width:500px;height:500px;margin-left: 30%; margin-top:20px;border: 2px solid black">

        <table style="height: 100%">


            <%
                int count=0;
                 for(int i=0;i<10;i++){
                     count++;

        %>
            <tr>
                <td style="height: 200px"><%=count%></td>
                <td style="height: 200px"><%=count%></td>
                <td style="height: 200px"><%=count%></td>

            </tr>

            <tr>
                <td style="height: 200px"><%=count%></td>
                <td style="height: 200px"><%=count%></td>
                <td style="height: 200px"><%=count%></td>
            </tr>
            <%
                }
            %>
        </table>

</div>

</body>
</html>