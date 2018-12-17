<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/18
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<frameset rows="120,*" cols="*" frameborder="no" border="0" framespacing="0">
    <frame src="MainTop.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame"/>
    <frameset cols="250,*" frameborder="no" border="0" framespacing="0">
        <frame src="MainLeft.jsp" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame"/>
        <frame src="Main_notsubmit.jsp" name="mainFrame" id="mainFrame"/>
    </frameset>
</frameset>
</html>
