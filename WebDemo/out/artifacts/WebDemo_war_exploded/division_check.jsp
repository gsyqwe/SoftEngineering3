<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*" %>
<%@ page import="Model.*"  %>
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


            width: 10%;
            height:580px;
            border: 2px solid green;
            float: left;
        }

        .center{
            margin-left: 2%;
            width: 42%;
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
    //区域查看界面 下一条
    ArrayList<Record> recordlist=new ArrayList();
    recordlist=(ArrayList<Record>)session.getAttribute("division_check_recordlist");
    ArrayList<AreaLabelItem>  arealist=new ArrayList<AreaLabelItem>();  //所有存在的item
    ArrayList<String> picturelist=new ArrayList<String>();
    for(int i=0;i<recordlist.size();i++){
        for (int j = 0; j < recordlist.get(i).getAreaLabel().size(); j++) {
            arealist.add(recordlist.get(i).getAreaLabel().get(j));
            picturelist.add(recordlist.get(i).getUrl());
        }
    }

    for(int i=0;i<arealist.size();i++){
        for(int j=0;j<arealist.get(i).getPointList().size();j++){
              System.out.println(arealist.get(i).getPointList().get(j).getX()+" "+arealist.get(i).getPointList().get(j).getY());
        }
        System.out.println();
    }
    System.out.println("区域标注查看一共"+arealist.size()+"条记录");
    int number=0;
    System.out.println("hidden框内容"+request.getParameter("division_check_hiddenvalue"));
    if(request.getParameter("division_check_hiddenvalue")!=null)
        number=Integer.valueOf(request.getParameter("division_check_hiddenvalue"));
    if(number>=arealist.size()-1){
        number=arealist.size()-1;
%>
<script>
    alert("已经到最后一张")
</script>
<%
        }
    System.out.println("division_check_number"+number);
%>
<body >

<div style="width: 100%;height: 580px; background-image: url(images/bluebg.jpg);  background-size: cover; border: 2px solid blue">
    <div class="left" >
        <div style="margin: 0 auto;width: 70%;height: 500px;">
            <br><br> <br>
            <h4 style="font-style: italic;">当前任务编号：<%=recordlist.get(0).getTaskID()%></h4>
            <br><br><br>
            <h4>共<%=arealist.size()%>条记录</h4>
            <br><br><br>
            <br> <br> <br>
            <h4>当前第<%=number+1%>条</h4>
        </div>

    </div>
    <script>
        var begingxlist=new Array();
        var begingylist=new Array();
        var endexlist=new Array();
        var endeylist=new Array();


<%
    List beginxlist=new ArrayList();
    List beginylist=new ArrayList();
    List endxlist=new ArrayList();
    List endylist=new ArrayList();
    for(int i=0;i<arealist.get(number).getPointList().size()-1;i=i+2){
         beginxlist.add(arealist.get(number).getPointList().get(i).getX());
         beginylist.add(arealist.get(number).getPointList().get(i).getY());
         endxlist.add(arealist.get(number).getPointList().get(i+1).getX());
         endylist.add(arealist.get(number).getPointList().get(i+1).getY());
         }
         System.out.println(beginxlist.size());
    for(int j=0;j<beginxlist.size();j++){%>
           begingxlist[<%=j%>]=<%=beginxlist.get(j)%>;
           begingylist[<%=j%>]=<%=beginylist.get(j)%>;
           endexlist[<%=j%>]=<%=endxlist.get(j)%>;
           endeylist[<%=j%>]=<%=endylist.get(j)%>;

<%}
    %>
        </script>
    <div class="center" >
        <label style="font-size: 50px">图片显示区域:</label>
        <!---<div style=";height: 400px;margin-left: 80px;margin-top: 50px">
            <img src="picturelist.get(number)" width="520px" height="400px" style="margin:0 auto" border="2px green">
        </div>---->

        <div style="background-image: url(<%=picturelist.get(number)%>);background-size: cover; width:520px;height:400px " id="background">
            <canvas id="canvas" width="520px" height="400px"
                    style="border: green solid;">
            <script src="js/jquery-3.3.1.min.js"></script>
            <script src="js/jcanvas.min.js"></script>
            <script>
                <%
                int index=0;
                %>
                var n=<%=arealist.get(number).getPointList().size()%>;
                alert("n"+n);
                if(n!=0) {
                    var c = document.getElementById("canvas");
                    var canvasRect = c.getBoundingClientRect();
                    //矩形框的左上角坐标
                    var canvasLeft = canvasRect.left;
                    var canvasTop = canvasRect.top;
                    var ctx = c.getContext('2d');
                    var number =<%=arealist.get(number).getPointList().size()%>;

                    alert("draw121");
                    for (var i = 0; parseInt(i) < number/2; i = i + 1) {
                        alert("draw");
                        var begin_x = begingxlist[i];
                        var begin_y = begingylist[i];
                        var to_x = endexlist[i];
                        var to_y = endeylist[i];
                        ctx.beginPath();
                        ctx.lineWidth = 2;
                        ctx.strokeStyle = "red";
                        ctx.moveTo(begin_x,begin_y);
                        ctx.lineTo(to_x,begin_y);
                        ctx.lineTo(to_x,to_y);
                        ctx.lineTo(begin_x,to_y);
                        ctx.lineTo(begin_x,begin_y);
                        ctx.closePath();
                        ctx.stroke();
                    }
                }
            </script>
            </canvas>
        </div>

        <form style="margin-left:250px" >
            <a href="javascript:void(0);"  onclick="changeImage()">下一页</a>&nbsp;&nbsp;&nbsp;
            <<input type="hidden"  id="for_index" value="0">
        </form>

    </div>

    <div class="right">

        <div style="width: 80%;height: 250px;margin-left:10%;border: 2px solid red">
            <label>标注：</label>
            <form >
                <input type="text" class="text1" readonly value="<%=arealist.get(number).getLabel()%>">
            </form>
        </div>

        <div style="width: 80%;height: 250px;margin-left:10%;border: 2px solid red">
            <label>描述：</label>
            <form >
                <input type="text" class="text1" readonly value="<%=arealist.get(number).getDescription()%>">
            </form>
        </div>

        <form action="division_check.jsp" id="division_c_f">
            <input type="hidden" id="division_check_hiddenvalue" name="division_check_hiddenvalue" value="0">
        </form>



    </div>
</div>
<!-- 下一张图片的算法 -->
	<script>
        var n=<%=number%>;
		function changeImage() {
			document.getElementById("division_check_hiddenvalue").value=n+1;

		    document.getElementById("division_c_f").submit();
			//document.getElementById("Image").src=recordlist.get(document.getElementById("hiddenvalue").value);
			//document.getElementById("whole_information").clear();
			//document.getElementById("whole_description").clear();
			//画线的算法
			//var number=document.getElementById("hiddenvalue").value;
			//画图
            //换背景图片
		}
	</script>


</body>
</html>