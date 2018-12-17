<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/18
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <%
        String userID=(String)session.getAttribute("currentuser");
        //从servlet得到记录

    %>

</head>
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
            <div style="margin-left: 90%;font-size: 15px;width: 150px;height: 90px;line-height: 90px;text-align: center;">
                <div > <p > 欢迎你，陆梅临 <a style="color:black;" href="login2.html ">注销</a></p></div>
            </div>
        </div>

    </div>

</div>

<div style="width: 100%;height: 580px; background-image: url(images/bluebg.jpg);  background-size: cover; border: 2px solid blue">
    <div class="left" >
        <div style="margin: 0 auto;width: 70%;height: 500px;">
            <br><br> <br>
            <h4 style="font-style: italic;">当前任务编号：4</h4>
            <br><br><br>
            <h4>共15条记录</h4>
            <br><br><br>
            <h4>当前第5条</h4><br>
        </div>

    </div>

    <div class="center">
        <label style="font-size: 50px">图片显示区域:</label>
        <canvas id="drawing" style="width: 500px;height: 400px;margin-left: 50px;margin-top: 50px;border: 2px solid red">
            <div style="width: 100%;height: 400px;border: 2px solid red">
                <img src="images/cloud.jpg" width="80%" height="80%" style="margin:0 auto" border="2px green">
            </div>
        </canvas>
        <form style="margin-left:250px" action="">
            <input class="button_blue "type="submit"onclick="f5()" value="下一张">
        </form>

    </div>

    <div class="right">

        <div style="width: 80%;height: 250px;margin-left:10%;border: 2px solid red">
            <label>标注：</label>
            <form >
                <input type="text" class="text1" readonly>
            </form>
        </div>

        <div style="width: 80%;height: 250px;margin-left:10%;border: 2px solid red">
            <label>描述：</label>
            <form >
                <input type="text" class="text1" readonly>
            </form>
        </div>

    </div>
</div>

</body>

<script>
    function draw() {
        alert("666");
        var canvas = document.getElementById("drawing"); //取得canvas的对象
        if (canvas == null) {
            alert("555");
            return false;
        }
        var context = canvas.getContext('2d');  //获取画布对象
        context.fillStyle = "#EEEEFF";  //对画布填充颜色
        //参数===>x: 矩形左上角的 x 坐标  y:    矩形左上角的 y 坐标，width：  矩形的宽度，以像素计 ,height： 矩形的高度，以像素计
        context.fillRect(0, 0, 400, 300); //fillRect() 方法绘制“已填色”的矩形。默认的填充颜色是黑色。
        context.fillStyle = "white";  //为将要画的图像设置颜色
        context.strokeStyle = "blue";  //图像的边框线颜色  ->strokeStyle 属性设置或返回用于笔触的颜色、渐变或模式。
        context.lineWidth=1;//线的大小->lineWidth 属性设置或返回当前线条的宽度，以像素计。
        context.fillRect(50,50,100,100);  //图像的坐标以及宽高
        context.strokeRect(50,50,100,100);  //strokeRect() 方法绘制矩形（不填色）。笔触的默认颜色是黑色。
    }


    function draw2() {

        alert("777")

        var drawing = document.getElementById("drawing");
//确定浏览器支持<canvas>元素
        if (drawing.getContext) {
//取得绘图上下文对象的引用，“2d”是取得2D上下文对象
            var context = drawing.getContext("2d");
//开始路径
            context.beginPath();
            /*绘制弧线，使用arc(x,y,radius,startAngle,endAngle,counterclockwise)方法
            以(x,y)为圆心绘制一条弧线，弧线半径为radius，起始和结束角度（用弧度表示）分别为startAngle
            和endAngle。最后一个参数表示是否按逆时针方向计算，值为false表示顺时针方向计算。
            */
            //context.arc(130, 130, 90, 0, 2 * Math.PI, false);
            /*arcTo(x1,y1,x2,y2,radius):从上一点开始绘制一条弧线，到(x2,y2)为止，并且以给
            定的半径radius穿过(x1,y1)
            */
            // context.arcTo(50, 200, 50, 200, 200);
            /*bezierCurveTo(c1x,c1y,c2x,c2y,x,y):从上一点开始绘制一条曲线，到（x,y）为
             止，并且以(c1x,c1y)和(c2x,c2y)为控制的。
            */
            // context.bezierCurveTo(320, 210, 400, 250, 310, 300);
            /*lineTo(x,y):从上一点开始绘制一条直线，到(x,y)为止*/
            // context.lineTo(0, 300);
            context.moveTo(100,100);

            for(var i=0;i<100;i++){
                context.lineTo(100+i*0.5,100+i*i*0.001);
            }
            /*quadraticCurveTo(cx,cy,x,y):从上一点开始绘制一条二次曲线，到(x,y)为止，并且
              以(cx,cy)作为控制点
              */
            // context.quadraticCurveTo(40, 380, 130, 400);
            // context.lineTo(450, 400);
            /*rect(x,y,width,height):从点（x,y）开始绘制一个矩形路径*/
            // context.rect(80, 80, 100, 100)
            // context.strokeStyle = "rgba(0,0,255,0.5)";
//最后必须调用stroke()方法，这样才能把图像绘制到画布上。
            context.stroke();

        }
    }



    function f5() {
        alert("879");
        var list=new Array()
        list.push("5555");
       // list[0]="987654"
        //document.write(list[0]);
        //alert("555222222");
        alert(list[0]);
    }

</script>

</html>