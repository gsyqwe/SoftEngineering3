<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Record" %>
<%@ page import="Model.AreaLabelItem" %>
<!DOCTYPE html>

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

	//矩形打标签
	//点击下一张 刷新界面  点击保存 servlet重定位到这个界面

	ArrayList<Record> recordlist=new ArrayList();
	recordlist=(ArrayList<Record>)session.getAttribute("recordlist");
	int number=0;//我的Number没有做得到啊

	if(request.getSession().getAttribute("division_work_index")!=null){
	System.out.println(request.getSession().getAttribute("division_work_index"));
	number=Integer.valueOf(String.valueOf (request.getSession().getAttribute("division_work_index")));
}
	if(request.getParameter("division_hidden_value")!=null){
		number=Integer.valueOf(request.getParameter("division_hidden_value"));
		request.getSession().setAttribute("division_work_index",number);
	}
	if(number>=recordlist.size()-1)
	    number=recordlist.size()-1;
	System.out.println("recordlistsize"+recordlist.size());
	System.out.println("divisionnumber"+number);
	if (request.getAttribute("message")!= null) {
	    String mes=String.valueOf(request.getAttribute("message"));
%>
<script>
	alert("<%=mes%>");
</script>
<%
	}
	int index=0;

%>

<body background="D://picture/d.jpg">
<!---界面上方的横着的区域-->

<!---放图片的工作区域  -->
<!-- 进行区域划分，画长方形 -->
<!-- 放提交按钮 -->
<div style="margin-Top: 3.1%; margin-Right: 15%; width: 100%; height: 100%; border: black solid 1px; display: flex;">
	<div style="background-image: url(<%=recordlist.get(number).getUrl()%>); background-size:cover;width:520px;height:400px ;" id="background">
		<canvas id="canvas" width="520px" height="400px"
				style="border: 3px solid red;">
		</canvas>
		<script src="js/jquery-3.3.1.min.js"></script>
		<script src="js/jcanvas.min.js"></script>
		<script>
            var layer = 0;
            CanvasExt = {
                drawRect : function(canvasId, penColor, strokeWidth) {
                    var that = this;
                    that.penColor = penColor;
                    that.penWidth = strokeWidth;
                    var canvas = document.getElementById(canvasId);
                    //canvas 的矩形框
                    var canvasRect = canvas.getBoundingClientRect();
                    //矩形框的左上角坐标
                    var canvasLeft = canvasRect.left;
                    var canvasTop = canvasRect.top;

                    var layerIndex = layer;
                    var layerName = "layer";
                    var x = 0;
                    var y = 0;

                    //保存起始坐标
                    var begin_position_xlist=new Array();
                    var begin_position_ylist=new Array();
                    var begin_position_x=0;
                    var begin_position_y=0;
                    //保存结束坐标
                    var end_position_x=0;
                    var end_position_y=0;
                    var end_position_xlist=new Array();
                    var end_position_ylist=new Array();

                    //鼠标点击按下事件，画图准备
                    canvas.onmousedown = function(e) {
                        //设置画笔颜色和宽度
                        var color = that.penColor;
                        var penWidth = that.penWidth;

                        layerIndex++;
                        layer++;
                        layerName += layerIndex;
                        x = e.clientX - canvasLeft;
                        y = e.clientY - canvasTop;

                        begin_position_x=x;
                        begin_position_y=y;

                        $("#" + canvasId).addLayer({
                            type : 'rectangle',
                            strokeStyle : color,
                            strokeWidth : penWidth,
                            name : layerName,
                            fromCenter : false,
                            x : x,
                            y : y,
                            width : 1,
                            height : 1
                        });

                        $("#" + canvasId).drawLayers();
                        $("#" + canvasId).saveCanvas();
                        //鼠标移动事件，画图
                        canvas.onmousemove = function(e) {
                            width = e.clientX - canvasLeft - x;
                            height = e.clientY - canvasTop - y;

                            $("#" + canvasId).removeLayer(layerName);

                            $("#" + canvasId).addLayer({
                                type : 'rectangle',
                                strokeStyle : color,
                                strokeWidth : penWidth,
                                name : layerName,
                                fromCenter : false,
                                x : x,
                                y : y,
                                width : width,
                                height : height
                            });

                            $("#" + canvasId).drawLayers();
                        }
                    };

                    canvas.onmouseup = function(e) {

                        var color = that.penColor;
                        var penWidth = that.penWidth;

                        canvas.onmousemove = null;

                        width = e.clientX - canvasLeft - x;
                        height = e.clientY - canvasTop - y;

                        end_position_x=e.clientX;
                        end_position_y=e.clientY;

                        $("#" + canvasId).removeLayer(layerName);
                        $("#" + canvasId).addLayer({
                            type : 'rectangle',
                            strokeStyle : color,
                            strokeWidth : penWidth,
                            name : layerName,
                            fromCenter : false,
                            x : x,
                            y : y,
                            width : width,
                            height : height
                        });

                        $("#" + canvasId).drawLayers();
                        $("#" + canvasId).saveCanvas();
                        var str=begin_position_x+" "+begin_position_y+" "+end_position_x+" "+end_position_y+" ";
						var temp=document.getElementById("division_point").value;
                        document.getElementById("division_point").value=temp+str;
                        alert(temp+str);
                    }
                }
            };

            drawPen();
            function drawPen() {
                var color = "red";
                var width = 1;
                CanvasExt.drawRect("canvas", color, width);
            }
		</script>
	</div>

	<div>
		<!-- 提交 -->
		<button style="text-align: center; width: 75px; height: 23px; display: flex;"
				id="2" onclick="finish()">提交</button>
		<a href="javascript:void(0);"  onclick="changeImage()">下一页</a>&nbsp;&nbsp;&nbsp;

	</div>

	<form action="DivisionSaveServlet">
		<input type="text" id="division_label" name="division_label"style="width: 400px ;height: 200px" value="">区域标注
		<input type="text" id="division_description" name="division_description" style="width: 400px ;height: 200px" value="">区域描述
		<input type="hidden" id="userID" name ="userID" value=<%=recordlist.get(number).getUserID()%>>
		<input type="hidden" id="taskID" name="taskID" value=<%=recordlist.get(number).getTaskID()%>>
		<input type="hidden" id="pictureID"name="pictureID" value=<%=recordlist.get(number).getUrl()%>>
		<input type="hidden" id="division_point" name="division_point" value="">
		<input type="submit" value="保存">
	</form>


	<form action="division_work.jsp" id="division_d_w">
		<input type="hidden" value="0" id="division_hidden_value" name="division_hidden_value">
	</form>

	<form action="DivisionSaveServlet" method="post">
		<input type="hidden" id="division_submit_taskID" name="division_submit_taskID" value="<%=recordlist.get(number).getTaskID()%>">
		<input type="hidden" id="division_submit_userID" name="division_submit_userID" value="<%=recordlist.get(number).getUserID()%>">
		<input type="submit" value="提交当前任务">
	</form>

</div>
<!-- 切换图片的功能 -->
<script>
	var n=<%=number%>;
    function changeImage() {
        document.getElementById("division_hidden_value").value=n+1;
         alert(document.getElementById("division_hidden_value").value);
		document.getElementById("division_d_w").submit();
    }
</script>
<!-- 切换标记的算法功能 -->
<!-- 保存的功能 -->
<script>
    function save(){

    }
</script>
<!-- 提交的功能 -->
<script>
    function finish(){

    }
</script>

<!-- 兼顾修改功能的函数实现，先调用这个在去在画布上作画 -->

</body>
</html>