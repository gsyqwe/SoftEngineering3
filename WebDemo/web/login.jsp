<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/10
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8" language="java" %>
<html ><head>
    <title>众包登陆页面</title>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="images/login.js"></script>
    <link href="css/login2.css" rel="stylesheet" type="text/css" />
</head>
<body >
<div style="width: 100%;text-align: center;">
    <h1>众包平台</h1>
</div>

<div class="login" style="margin-top:50px;">
    <%
        String mess=(String)request.getAttribute("message");
        if(mess!=null){
      %>

        <script>
        alert("<%=mess%>");
        </script>

    <% } %>

    <div class="header">
        <div class="switch" id="switch">
            <a class="switch_btn_focus" id="switch_qlogin"  tabindex="7">快速登录</a>
            <a class="switch_btn" id="switch_login"  tabindex="8">快速注册</a><div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>


    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">

        <!--登录-->
        <div class="web_login" id="web_login">


            <div class="login-box">


                <div class="login_form">
                    <form action="LoginServlet" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post"><input type="hidden" name="did" value="0"/>
                        <input type="hidden" name="to" value="log"/>
                        <div class="uinArea" id="uinArea">
                            <label class="input-tips" for="u">帐号：</label>
                            <div class="inputOuter" id="uArea">

                                <input type="text" id="u" name="username" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips" for="p">密码：</label>
                            <div class="inputOuter" id="pArea">

                                <input type="password" id="p" name="p" class="inputstyle"/>
                            </div>
                        </div>

                        <div style="padding-left:50px;margin-top:20px;">
                            <!----<a   href="login_check.jsp" style="width:150px;color: white;text-align: center;">登录</a>---->
                            <!---<input type="submit"class="button_blue"  style="width:150px;color: white;text-align: center;" value="提交"/>-->
                            <input type="submit" class="button_blue" style="width:150px;color: white;text-align: center;" value="登录">

                        </div>
                    </form>
                </div>

            </div>

        </div>
    </div>

    <!--注册-->
    <div  id="qlogin" style="display: none; ">

        <div class="web_login"><form name="form2" id="regUser" accept-charset="utf-8"  action="RegisterServlet" method="post">
            <input type="hidden" name="to" value="reg"/>
            <input type="hidden" name="did" value="0"/>
            <ul class="reg_form" id="reg-ul">

                <li>

                    <label for="user"  class="input-tips2">用户名：</label>
                    <div class="inputOuter2">
                        <input type="text" id="user" name="user" maxlength="16" class="inputstyle2"/>
                    </div>

                </li>

                <li>
                    <label for="passwd" class="input-tips2">密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="passwd"  name="passwd" maxlength="16" class="inputstyle2"/>
                    </div>

                </li>
                <li>
                    <label for="passwd2" class="input-tips2">确认密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="passwd2" name="passwd2" maxlength="16" class="inputstyle2" />
                    </div>

                </li>

                <li>
                    <label for="qq" class="input-tips2">联系方式：</label>
                    <div class="inputOuter2">

                        <input type="text" id="qq" name="qq" maxlength="10" class="inputstyle2"/>
                    </div>

                </li>

                <li>
                    <div class="inputArea">
                        <!----<input type="button" id="reg"  style="margin-top:10px;margin-left:85px;" class="button_blue"  value="同意协议并注册"/> <a  class="zcxy" target="_blank">注册协议</a>-->
                       <!-- <input type="submit"class="button_blue"  style="margin-top:10px;margin-left:85px;text-align: center;" value="同意协议并注册"/>-->

                        <input type="submit" class="button_blue" style="margin-top:10px;margin-left:85px;text-align: center;" value="同意协议并注册"><a  class="zcxy" target="_blank">注册协议</a>


                    </div>

                </li><div class="cl"></div>
            </ul></form>


        </div>


    </div>
</div>
</body></html>

