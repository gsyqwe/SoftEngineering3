<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="Model.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>众包查看界面</title>
    <style>
        *{
            margin: 0;
        }

        .left{
            margin-left: 1%;


            width: 20%;
            height:580px;
            border: 2px solid green;
            float: left;
         }

        .center{
            margin-left: 2%;
            width: 40%;
            height:580px;
            border: 2px solid black;
            float: left;
        }

        .right{
            margin-left: 1%;

            width: 35%;
            height:580px;
            border: 2px solid black;
            float: right;
        }

        .button_blue{
            border-radius: 5px;
            font-size: 25px;
            font-weight: 700;
            text-decoration: none;
        }

        .text1{
            margin-left:20px;width:380px;padding: 0 1em;
            -webkit-appearance: none;
            -moz-appearance: none;
            font-size: 1.4em;
            height: 10em;
            border:1px solid #c8cccf;
            color:#6a6f77;
            outline: 0;
            box-sizing: border-box;
            text-align: center;
            border-radius: 10px;
            text-decoration: none;
            background-color: gainsboro;
        }
    </style>
</head>
<%
      ArrayList<Record> recordlist=new ArrayList();
      recordlist=(ArrayList<Record>)session.getAttribute("recordlist");
      //这个就传个recordlist和那个对应的number不用在解析和转化了
      //直接从这个recordlist里面就可以拿到整体标注和描述了
      int number=0;

      if(request.getParameter("whole_check_index")!=null){
          number=Integer.valueOf(request.getParameter("whole_check_index"));
      }

%>
<body>
<div class="header">
    <div style="width: 100%;height: 15%;display: flex;margin: 0px;border: 2px solid yellow;background-image: url(images/sky3.jpg);background-size: cover;">
        <div style="margin-top: 10px;float:left;">
            <img src="images/logo.png" style="width: 90px;height: 90px " align="left">
        </div>
        <div style="font-size: 40px;font-style:inherit;margin-left:5% ;margin-top:18px;width: 150px;height:80px;line-height: 80px;text-align: center;" >
            PIONEER
        </div>

        <div style="float: right;width:70%;margin-right: 3%;margin-top: 18px;">
            <div style="margin-left: 90%;font-size: 15px;width: 150px;height: 90px;line-height: 90px;text-align: center;border: 0">
                <div > <p > 欢迎你，陆梅临 <a style="color:black;" href="login2.html ">注销</a></p></div>
            </div>
        </div>

    </div>

</div>

<div  id="Image" style="width: 100%;height: 580px; background-image: url(images/bluebg.jpg);  background-size: cover; border: 2px solid blue">
<div class="left" >
    <div style="margin: 0 auto;width: 70%;height: 500px;">
        <br><br> <br>
         <h4 style="font-style: italic;">当前任务编号：<%=recordlist.get(number).getTaskID() %></h4>
        <br><br><br>
        <h4>共<%=recordlist.size()%>条记录</h4>
        <br><br><br>
    </div>

</div>

<div class="center">
    <label style="font-size: 50px">图片显示区域:</label>
    <div style=";height: 400px;margin-left: 80px;margin-top: 50px">
        <img src="<%=recordlist.get(number).getUrl()%>>" width="80%" height="80%" style="margin:0 auto" border="2px green">
    </div>

    <form style="margin-left:250px" >
        <input class="button_blue "type="submit" onclick="changeImage()" value="下一张">
        <input type="hidden" id="whole_check_index" value="0">
    </form>

    <form id="whole_check_form" action="whole_description_check.jsp" >

    </form>

</div>

<div class="right">

    <div style="width: 80%;height: 250px;margin-left:10%;border: 2px solid red">
        <label>标注：</label>
        <form >
            <input type="text" class="text1" id="whole_information" readonly value="<%=recordlist.get(number).getOverallTitle()%>">
        </form>
    </div>

    <div style="width: 80%;height: 250px;margin-left:10%;border: 2px solid red">
        <label>描述：</label>
        <form >
            <input type="text" class="text1" id="whole_description" readonly value="<%=recordlist.get(number).getOverallDescription()%>">
        </form>
    </div>

</div>
</div>
<!-- 下一张图片的算法 -->
	<script>
		function changeImage() {
			document.getElementById("whole_check_index").value++;
			//var url=<%=recordlist.get(number).getUrl()%>
			//document.getElementById("Image").src=url;
			document.getElementById("whole_information").clear();
			document.getElementById("whole_description").clear();
			//takeon();
            document.getElementById("whole_check_form").submit();

		}
	</script>
	<!-- 上来显示文字内容的函数算法 -->
	<script>
	     function takeon(){
		   document.getElementById("whole_information").setText(<%=recordlist.get(number).getOverallTitle()%>);
		   document.getElementById("whole_description").setText(<%=recordlist.get(number).getOverallDescription()%>);
	}
	</script>
</body>
</html>