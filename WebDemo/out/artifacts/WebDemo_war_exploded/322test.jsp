<%@ page import="java.util.List" %>
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
    <script>
        var xlist=new Array();
        var ylist=new Array();
    </script>
</head>
<body background="D://picture/d.jpg">
<!---界面上方的横着的区域-->
<div
        style="margin: 0; text-align: center; width: 100%; height: 60px; background-color: #000000; position: fixed; top: 0px">
    <div
            style="background-color: #000000; color: #f1f1f1; font-size: xx-large">众包标注系统</div>
    <div style="color: white; float: right;">注销</div>
</div>



<!---放图片的工作区域  -->
<!-- 进行区域划分，画长方形 -->
<!-- 放提交按钮 -->
<div style="margin-Top: 3.1%; margin-Right: 15%; width: 100%; height: 100%; border: black solid 1px; display: flex;">
    <div style="background-image: url(images/1.jpg); width:1080px;height:800px " >
        <canvas class="myCanvas" id="canvas" width="1080px" height="800px"
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
                xlist.push(x);
                ylist.push(y);

                if(document.getElementById("point")!=null) {
                    var temp = document.getElementById("point").value;
                    alert(temp);
                    document.getElementById("point").value = temp + " " + x + " " + y + " ";
                }

            }

        </script>
    </div>
    <div>
        <!-- 下一张 -->
        <button style="margin-Left:15%; width: 75px; height: 23px; display: flex;"
                id="1" onclick="changeImage()">下一张</button>
    </div>
    <div>
        <!-- 提交 -->
        <button style="text-align: center; width: 75px; height: 23px; display: flex;"
                id="2" onclick="finish()">提交</button>
    </div>
    <div>
        <!-- 加一个保存按钮 -->
        <!-- 区域的描述 -->
        <div style="width:100%; margin-Left:30%;">
            <!-- 区域划分的文本框 -->
            <textarea name="a" style="width:400px;height:300px;">局部标注
			</textarea>
        </div>
        <div style="width:100%; margin-Left:30%;">
            <!-- 区域划分描述的文本框 -->
            <textarea name="b" style="width:400px;height:300px;">局部描述
			</textarea>
        </div>
        <!-- 保存的按钮 -->



        <a href="WorkServlet?xlist="> </a>

        <form id="saveform" action="WorkServlet" method="get">
            <input type="hidden"  id="point" name="point" value="">
            <input type="submit" value="123" >

        </form>

    </div>
</div>
</div>
<!-- 切换图片的功能 -->
<script>
    function changeImage() {


    }
</script>
<!-- 保存的功能 -->
<script>
    function save(){
       with (document.getElementById("saveform")) {
            var xstr="";
            for(var i=0;i<xlist.length;i++){
                xstr=xstr+" "+xlist[i];
            }
            alert(xstr);

            //sessionStorage.setItem("method","CircleSave");
          // sessionStorage.setItem("xlist",xstr);
            //session.setAttribute("xlist",xstr);
           //action = "WorkServlet?method=CircleSave&xlist="+xstr;
            //alert("123");
            //submit();

            var url="http://localhost:8080/WebDemo/WorkServlet?method=CircleSave & xlist="+xstr;
            window.location.href=url;

           //window.location.href="http://www.baidu,com";
            //document.formName.action="saveform.action?method=CircleSave&xlist="+xstr;
           // document.formName.submit();
       }
    }
</script>
<!-- 提交的功能 -->
<script>
    function finish(){

    }
</script>
<script>
    //把canvans上的内容转换为图片
    function convertCanvasToImage(canvas) {
        var image = new Image();
        image.src = canvas.toDataURL("image/png");
        return image;
    }
</script>
</body>
</html>