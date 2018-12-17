<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/17
  Time: 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>众包主界面</title>
    <style>
        body{
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
        li a.active{
            background-color: #4CAF50;
            color:white;
        }
        li a:hover:not(.active) {
            background-color: #555;
            color: white;}
    </style>
</head>
<body background="D://picture/d.jpg">
<!---界面上方的横着的区域-->
<div style="margin:0;text-align:center;width: 100%;height:60px;background-color: #000000;position:fixed;top:0px">
    <div style="background-color: #000000;color: #f1f1f1;font-size:xx-large " >众包标注系统</div>
    <div style="color: white;float:right;">注销</div>
</div>

<!--左边导航部分--->
<ul style="top:60px">
    <li><a class="active" href="#Main">标签</a></li>
    <li><a href="#news">其他内容</a></li>
</ul>


<!---导航右边的整个块-->
<div id="Main" style="margin-left:15%;height:1000px">

    <!---上方的提示字-->
    <div style="margin-left:15%;height:100px;top:60px">
        <p style="text-align: center;width: 100%;height: 100px;border: green solid 1px; font-size: large;">请在下面的界面中进行标签操作</p>
    </div>

    <!--下方的图片显示和文本框输入--->
    <div  style="margin-left:15%;width: 100%;height: 400px;border: green solid 1px;display: flex;">
        <div>
            <img id="Image" style="width:400px ; height: 400px ;" onclick="changeImage()" src="D://picture/c.jpg">
        </div>

        <!--文本输入-->
        <div style="display: block;">
            <div>
                <form name="input" action="http://www.baidu.com" method="get">
                    <div >
                        <textarea id="textarea" name="a" style="width:400px;height:200px;">这里写内容</textarea>
                    </div>
                    <div>
                        <input type="submit" value="提交内容">
                    </div>
                </form>
                <div style="display: flex;">

                    <div>
                        <button style="text-align:center;width:75px;height:23px;display: flex;" id="1" onclick="changeImage()">下一张</button>
                    </div>
                </div>
            </div>


        </div>


    </div>
</div>


<!--切换图片的算法-->
<script>
    function changeImage()
    {
        var element;
        element=document.getElementById('Image');
        if (element.src.match("a"))
        {
            element.src="D://picture/b.jpg";
        }
        else
        {
            element.src="D://picture/a.jpg";
        }
    }
</script>




</body>
</html>