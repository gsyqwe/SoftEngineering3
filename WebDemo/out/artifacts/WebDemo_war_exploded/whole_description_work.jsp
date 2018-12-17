<html lang="en">
<%@ page  import= "Model.*" %>
<%@ page import= "java.util.*" %>
<%@ page import="javax.swing.plaf.synth.SynthColorChooserUI" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<meta charset="UTF-8">
<title>众包主界面</title>
<style>
body {
	margin: 0;
}

ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	width: 25%;
	background-color: #f1f1f1;
	position: fixed;
	height: 100%;
	overflow: auto;
}

li a {
	display: block;
	color: #000;
	padding: 8px 16px;
	text-decoration: none;
}

li a.active {
	background-color: #4CAF50;
	color: white;
}

li a:hover:not (.active ) {
	background-color: #555;
	color: white;
}


</style>
</head>
<%
      ArrayList<Record> recordlist=new ArrayList();
      recordlist=(ArrayList<Record>)session.getAttribute("recordlist");
      //这个就传个recordlist和那个对应的number不用在解析和转化了
      //直接从这个recordlist里面就可以拿到整体标注和描述了
	   int number=0;
	   //number表示当前第几张图
	   //如果不是第一次加载，number改变
	if(request.getParameter("hiddenvalue")!=null){
	    number=Integer.valueOf(request.getParameter("hiddenvalue"));
	}
	if(number>=recordlist.size()-1)
	    number=recordlist.size()-1;
	System.out.println(number+"number");

    String mes=request.getParameter("message");
    if(mes!=null){
        %>
           <script>
	         alert(<%=mes%>);
           </script>
	<%
	}
	%>



<body background="images/new-task-bg.jpg">
	<!---界面上方的横着的区域-->


	<!---放图片的工作区域  -->
	<!-- 放提交按钮 -->
	
	<div
		style="margin-Top: 3.1%; width: 100%; height: 100%; border:black solid 1px; display: flex; float: left">
		<div style="float: left">
			<img id="Image" style="width: 520px; height: 320px;"
			src="<%=recordlist.get(number).getUrl()%>">
		</div>
		<div style="display: block;">
			<div>
				<a href="javascript:void(0);"  onclick="changeImage()">下一页</a>&nbsp;&nbsp;&nbsp;

				<!---<div style="display: flex;">
					<div>
						<button
							style="text-align: center; width: 75px; height: 23px; display: flex;"
							id="1" onclick="changeImage()">下一张</button>
					</div>--->
				</div>
			</div>


		     <form action="WholeSaveServlet" style="float: left">
				<input type="text" id="whole_information" name="whole_information" style="width:100%;height:30%;" value="<%=recordlist.get(number).getOverallTitle()%>">整体标注
				<input type="text" id="whole_description" name="whole_description" style="width:100%;height:30%;" value="<%=recordlist.get(number).getOverallDescription()%>">整体描述
				<input type="hidden" id="pictureID" name="pictureID" value="<%=recordlist.get(number).getUrl()%>">
				<input type="submit" value="保存">
			</form>

			  <form action="WholeSaveServlet" method="post">
				 <input type="hidden"  id="taskID" name="taskID" value="<%=recordlist.get(number).getTaskID()%>">
				<input type="hidden"  id="userID" name="userID" value="<%=recordlist.get(number).getUserID()%>">
				 <input type="submit" value="提交">
			 </form>

		</div>
	<!--- 整体标注+整体描述 --->
	<!-- 加一个保存按钮 -->




		<form action="whole_description_work.jsp" id="whole_d_w">
			<input type="hidden"   id="hiddenvalue" name="hiddenvalue" value="0">

		</form>








	<!--切换图片的算法-->
	<script>
		var n=<%=number%>;
		function changeImage() {
		   document.getElementById("hiddenvalue").value=n+1;

            document.getElementById("whole_information").innerText="";
			document.getElementById("whole_description").innerText="";

			document.getElementById("whole_d_w").submit();
		}
	</script>
	<!-- 整体中的保存按钮 -->
	<script>
	function save(){
		var whole_information=document.getElementById("whole_information").value;
		var whole_description=document.getElementById("whole_description").value;
		//写一段调用后端的保存全局的方法
	}
	</script>
	
	<!-- 提交按钮 -->
	<script>
	function finish(){
		var full=true;
		for(var i=0;i<recordlist.size();i++){
			if(recordlist.get(i).getoverallTitle()==""&&recordlist.get(i).getoverallDescription()==""){
				full=false;
				break;
			}
		}
		if(full==false){
			alert("任务未完成不能提交");
		}else{

		}
	}
	</script>
	<!-- 显示的函数方法，每次更改会显示，但是第一次的我没做，不知道加哪里 -->
	<script>
	  function takeon(){
          //document.getElementById("whole_information").innerText=<%=recordlist.get(number).getOverallTitle()%>;
         // document.getElementById("whole_description").innerText=<%=recordlist.get(number).getOverallDescription()%>;
		   //document.getElementById("whole_information").setText(<%=recordlist.get(number).getOverallTitle()%>);
		  // document.getElementById("whole_description").setText(<%=recordlist.get(number).getOverallDescription()%>);
	}
	</script>
</body>
</html>