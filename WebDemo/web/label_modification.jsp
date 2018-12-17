<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="Model.*"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>众包查看界面</title>
    <style>
        * {
            margin: 0;
        }

        .left {
            margin-left: 1%;
            width: 10%;
            height: 580px;
            border: 2px solid green;
            float: left;
        }

        .center {
            margin-left: 2%;
            width: 48%;
            height: 580px;
            border: 2px solid black;
            float: left;
        }

        .right {
            margin-left: 1%;
            width: 35%;
            height: 580px;
            border: 2px solid black;
            float: right;
        }

        .button_blue {
            border-radius: 5px;
            font-size: 25px;
            font-weight: 700;
            text-decoration: none;
        }

        .text1 {
            margin-left: 20px;
            width: 380px;
            padding: 0 1em;
            -webkit-appearance: none;
            -moz-appearance: none;
            font-size: 1.4em;
            height: 10em;
            border: 1px solid #c8cccf;
            color: #6a6f77;
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
    ArrayList<Record> recordlist = new ArrayList();
    recordlist = (ArrayList<Record>) session.getAttribute("label_check_recordlist");
    ArrayList<CircleLabelItem> cirlist = new ArrayList<CircleLabelItem>();
    ArrayList<String> picturelist = new ArrayList<String>();
    System.out.println(recordlist.size());
    for (int i = 0; i < recordlist.size(); i++) {
        for (int j = 0; j < recordlist.get(i).getCircleLabel().size(); j++) {
            cirlist.add(recordlist.get(i).getCircleLabel().get(j));
            picturelist.add(recordlist.get(i).getUrl());
        }
    }
    int index=0;
    int number = 0;

    if(request.getParameter("label_check_hiddenvalue")!=null)
        number=Integer.valueOf(request.getParameter("label_check_hiddenvalue"));
    if(number>=cirlist.size()-1)
        number=cirlist.size()-1;
    System.out.println(number);

%>
<body>


<div
        style="width: 100%; height: 580px; background-image: url(images/bluebg.jpg); background-size: cover; border: 2px solid blue">
    <div class="left">
        <div style="margin: 0 auto; width: 70%; height: 500px;">
            <br> <br> <br>
            <h4 style="font-style: italic;">当前任务编号：<%=recordlist.get(0).getTaskID()%></h4>
            <br> <br> <br>
            <h4>共<%=cirlist.size()%>条记录</h4>
            <br> <br> <br>
            <h4>当前第<%=number+1%>条</h4>
            <br>
        </div>

    </div>


    <script>
        var xlist=new Array();
        var ylist=new Array();
        <%
            List xlist=new ArrayList();
            List ylist=new ArrayList();
            for(int i=0;i<cirlist.get(number).getPointList().size();i=i+1){
                 xlist.add(cirlist.get(number).getPointList().get(i).getX());
                 ylist.add(cirlist.get(number).getPointList().get(i).getY());
                 }
            for(int j=0;j<xlist.size();j++){%>
        xlist[<%=j%>]=<%=xlist.get(j)%>;
        ylist[<%=j%>]=<%=ylist.get(j)%>;

        <%}
            %>
    </script>
    <div class="center">
        <label style="font-size: 50px">图片显示区域:</label>
        <div
                style="background-image: url(<%=picturelist.get(number)%>); background-size:cover;width:520px;height: 400px; margin-left: 80px; margin-top: 50px">

            <canvas id="canvas"  width="520px" height="400px" style="border: green solid;">
                <script>
                    alert("drawlabel");
                    var c=document.getElementById("canvas");
                    var canvasRect = c.getBoundingClientRect();
                    //矩形框的左上角坐标
                    var canvasLeft = canvasRect.left;
                    var canvasTop = canvasRect.top;
                    var ctx = c.getContext('2d');
                    var number=<%=cirlist.get(number).getPointList().size()%>;
                    alert("number"+number);
                    for(var i=0;parseInt(i)<number;i++) {
                        //进行画点
                        ctx.beginPath();
                        //得到点并画点
                        alert("xlist"+xlist.length);
                        alert("ylist"+ylist.length);
                        var x = xlist[i];
                        var y = ylist[i];
                        //在x,y位置画点
                        x = x ;
                        y = y ;
                        alert("x"+x);
                        alert("y"+y);
                        ctx.fillStyle = 'red';//定义填充样式
                        ctx.lineWidth = '1';//定义线性的线宽，宽是从圆圈向内外两边同时加粗的
                        ctx.arc(x, y, 3, 0, 2 * Math.PI);//定义圆[这五个参数分别是（横坐标，纵坐标，半径，起始的点(弧度)，结束的点(弧度)）]
                        ctx.fill();//定义圆为面性
                        ctx.closePath();
                    }
                </script>
            </canvas>

        </div>

        <form style="margin-left: 250px">
            <a href="javascript:void(0);"  onclick="changeImage()">下一页</a>&nbsp;&nbsp;&nbsp;
        </form>

    </div>

    <div class="right">

        <div
                style="width: 80%; height: 250px; margin-left: 10%; border: 2px solid red">
            <label>标注：</label>
            <form>
                <input type="text" class="text1" readonly value="<%=cirlist.get(number).getLabel()%>">
            </form>
        </div>

        <div
                style="width: 80%; height: 250px; margin-left: 10%; border: 2px solid red">
            <label>描述：</label>
            <form>
                <input type="text" class="text1" readonly value="<%=cirlist.get(number).getDescription()%>">
            </form>
        </div>

        <form action="label_check.jsp" id="label_c_f">
            <input type="hidden" id="label_check_hiddenvalue" name="label_check_hiddenvalue" value="0">
        </form>

    </div>
</div>
<!-- 切换图片的算法 -->
<script>
    var n=<%=number%>;
    function changeImage(){
        document.getElementById("label_check_hiddenvalue").value=n+1;
        document.getElementById("label_c_f").submit();
    }
</script>
<!-- 画图生成标记的算法 -->
</body>
</html>