<!DOCTYPE html>
<%@ page import="Model.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="en">
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
	ArrayList<Record> recordlist = new ArrayList();
	recordlist = (ArrayList<Record>) session.getAttribute("recordlist");
	//ArrayList<CircleLabelItem> cirlist = new ArrayList<CircleLabelItem>();
	//ArrayList<String> picturelist = new ArrayList<String>();
	//for (int i = 0; i < recordlist.size(); i++) {
	//	for (int j = 0; j < recordlist.get(i).getAreaLabel().size(); j++) {
	//		cirlist.add(recordlist.get(i).getCircleLabe().get(j));
		//	picturelist.add(recordlist.get(i).getUrl());
	//	}
	//}
	int number=0;//我的Number没有做得到啊
	if(request.getSession().getAttribute("label_work_index")!=null){
		System.out.println(request.getSession().getAttribute("label_work_index"));
		number=Integer.valueOf(String.valueOf (request.getSession().getAttribute("label_work_index")));
	}
	if(request.getParameter("label_hidden_value")!=null){
		number=Integer.valueOf(request.getParameter("label_hidden_value"));
		request.getSession().setAttribute("label_work_index",number);
	}
	if(number>=recordlist.size()-1)
		number=recordlist.size()-1;
	System.out.println("labelnumber"+number);
	int index=0;

%>
<body >

	<!---放图片的工作区域  -->
	<!-- 进行区域划分，画长方形 -->
	<!-- 放提交按钮 -->
	<div style="margin-Top: 3.1%; margin-Right: 15%; width: 100%; height: 100%; border: black solid 1px; display: flex;">
	
	<div id="background"; style="background-image: url(<%=recordlist.get(number).getUrl()%>); background-size:cover;width:520px;height:400px " >
		<canvas class="myCanvas" id="canvas" width="520px" height="400px"
			style="border: green solid;">
			</canvas>
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/jcanvas.min.js"></script>
		<script>

			var c = document.getElementById("canvas");//获取节点
	        var ctx = c.getContext('2d');//定义节点的canvas，之后就通过getContext进行canvas的绘制
	        var canvasRect = canvas.getBoundingClientRect();
			//矩形框的左上角坐标
			var canvasLeft = canvasRect.left;
			var canvasTop = canvasRect.top;
	        c.onmousedown = function(e) {
	        	var x=e.clientX-canvasLeft;
	        	var y=e.clientY-canvasTop;
			    ctx.beginPath();//这里可以理解为另外起笔，如果忽略这个步骤那么下面的样式就会继承上面的，所以最好不要忽略
		        ctx.fillStyle = 'red';//定义填充样式
		        ctx.lineWidth = '1';//定义线性的线宽，宽是从圆圈向内外两边同时加粗的
		        ctx.arc(x,y,3,0,2*Math.PI);//定义圆[这五个参数分别是（横坐标，纵坐标，半径，起始的点(弧度)，结束的点(弧度)）]
		        ctx.fill();//定义圆为面性即蓝色圆面
		        ctx.closePath();
		        var temp=document.getElementById("label_point").value;
                document.getElementById("label_point").value=temp+" "+x+" "+y;
                alert(  document.getElementById("label_point").value);
	        }
		</script>
		</div>

		<div>
		<!-- 下一张 -->
			<a href="javascript:void(0);"  onclick="changeImage2()">下一张</a>&nbsp;&nbsp;&nbsp;
		</div>



		<div>
	<!-- 加一个保存按钮 -->
	<!-- 区域的描述 -->
			<form action="LabelSaveServlet" >
				<input type="text" id="label_label" name="label_label" style="width: 400px ;height: 200px" value="">标注
				<input type="text" id="label_description" name="label_description" style="width: 400px ;height: 200px" value="">描述
				<input type="hidden" id="userID" name="userID" value="<%=recordlist.get(number).getUserID()%>">
				<input type="hidden" id="taskID" name="taskID" value="<%=recordlist.get(number).getTaskID()%>">
				<input type="hidden" id="pictureID" name="pictureID" value="<%=recordlist.get(number).getUrl()%>">
				<input type="hidden" id="label_point" name="label_point" value="">
				<input type="submit" value="保存">
			</form>


			<form action="label_work.jsp" id="label_d_w">
				<input type="hidden" value="0" id="label_hidden_value" name="label_hidden_value">
			</form>

			<form action="LabelSaveServlet" method="post">
				<input type="hidden" id="label_submit_taskID" name="label_submit_taskID" value="<%=recordlist.get(number).getTaskID()%>">
				<input type="hidden" id="label_submit_userID" name="label_submit_userID" value="<%=recordlist.get(number).getUserID()%>">Z
				<input type="submit" value="提交当前任务">
			</form>

	</div>
    <!-- 切换图片的功能 -->
	<script>
		var n=<%=number%>;
		function changeImage2() {
			document.getElementById("label_hidden_value").value=n+1;
			document.getElementById("label_d_w").submit();
		}
	</script>



</div>

</body>
</html>