<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/17
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" language="java" %>
<%@ page import="Model.Task" %>
<%@ page import="Service.TaskService" %>
<%@ page import="ServiceImpl.TaskServiceImpl" %>
<html>
<head>
    <link href="css/layer.css" rel="stylesheet" type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        *{
            padding: 0;
            margin: 0;
        }


        .draw {
            width: 560px;
            height: 600px;
            margin: 30px 450px;
            background-repeat: no-repeat;
            background-size: 100%;
        }

        .draw .item {
            width: 200px;
            height: 200px;
            background-color: white;
            background-size: 96%;
            filter:alpha(opacity:30);
            opacity:0.6;
        }


        .draw .gap {
            width: 5px;
        }



        .draw .draw-btn {
            display: block;
            line-height: 50px;
            border-radius: 20px;
            font-size: 25px;
            font-weight: 700;
            text-decoration: none;
            background-repeat: no-repeat;
            background-size: 96%;
            margin-top: 30px;
            margin-left: 80px;
        }

        #search{
            width: 78px;
            height: 40px;
            float: right;
            background: black;
            color: white;
            text-align: center;
            line-height: 32px;
            cursor: pointer;
        }


        #tabCon_2{
            display: none;
        }
        #tabCon_1{
            display: none;
        }


    </style>

    <script>
        function changeTab(tabCon_num){
            for(i=0;i<=2;i++) {
                document.getElementById("tabCon_"+i).style.display="none"; //将所有的层都隐藏
            }
            document.getElementById("tabCon_"+tabCon_num).style.display="block";//显示当前层
        }
    </script>
</head>
<body>
<%
    int totalPage=3;
    int []array={1,2,3,4,5,6,7,8,9,10,11,12,13,14};
    int totasize=14;
    int pageIndex=1;//当前页面号，用于控制页面翻转，默认为1
    TaskService taskService=new TaskServiceImpl();
    List<Task> list=taskService.queryTask_NotSubmit((String)session.getAttribute("currentuser"));


    if(request.getParameter("pageIndex")!=null) {//不是第一次加载
        System.out.println("page"+request.getParameter("pageIndex"));
        pageIndex=Integer.valueOf(request.getParameter("pageIndex"));
    }
    System.out.println("total"+totalPage);
%>

<header style="border: 2px solid yellow">
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
</header>



<div  id="tanContainer"  style="background-color: #c0e1f2;width: 18%;height:680px;background-color: white;opacity:0.7;float: left;">
    <div id="tab">
        <ul>
            <li onclick="changeTab('0')">
                <div style="font-size: 20px;text-align: center; position: relative;display: block;color: white;background: #2980b9; box-shadow: 0 1px 0 #409ad5 inset, 0 -1px 0 #20638f inset;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3);padding: 5px;">
                    <IMG src="images/not-submit.png" style="width:20px;height: 20px;margin-left: 8%;" >
                    未提交
                </div>
            </li>
            <li onclick="changeTab('1')">
                <div style="font-size: 20px;text-align: center; position: relative;display: block;color: white;background: #2980b9; box-shadow: 0 1px 0 #409ad5 inset, 0 -1px 0 #20638f inset;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3);padding: 5px;">
                    <img src="images/already-submit.png" style="width:20px;height: 20px;margin-left: 8%" >
                    已提交
                </div>
            </li>
            <li onclick="changeTab('2')">
                <div style="font-size: 20px;text-align: center; position: relative;display: block;color: white;background: #2980b9; box-shadow: 0 1px 0 #409ad5 inset, 0 -1px 0 #20638f inset;text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3);padding: 5px;">
                    <img src="images/new-task.png" style="width:20px;height: 20px;margin-left: 10%" >
                    领取任务
                </div>
            </li>
        </ul>
    </div>
</div>


<div id="tabCon" style="width: 81%;height: 700px; border: 2px solid black;float: right;background-image: url(images/new-task-bg.jpg);">
    <div id="tabCon_0" >

        <!--搜索框-->
        <form id="searchForm" name="searchForm" action="zhu.jsp"  method="get" style="border: 2px solid blue">
            <div  style="border:  2px solid red">
                <div style="width:100%;height: 50px;">
                    <input style=" margin-left: 20%; width: 260px;
                                            border: 1px solid #e2e2e2;
                                            height: 40px;
                                            float: left;
                                            opacity:0.5;
                                            background-image: url(images/e.jpg);
                                            background-repeat:no-repeat;
                                            background-size: 25px;
                                            background-position:5px center;
                                            padding:0 0 0 40px;" type="text"; name="search" placeholder="请输入关键字">
                    <div style="float: left">已标注：
                        <input type="radio" checked="checked" name="isbiaozhu" value="biaozhu" />
                        <br />
                        未标注：
                        <input type="radio" name="isbiaozhu" value="weibiaozhu" />
                    </div>
                    <div id="search" style="margin-right:30%;background-color: #006698;width:100px;height:40px;margin-left: 100px;">搜索</div>
                    <input type="hidden" name="pageIndex" id="pageIndex"  value="1">

                </div>
            </div>
        </form>

        <!--图片展示-->
        <div class="draw" id="lottery" style="margin-left: 5%">
            <table style="width:1000px;border:2px solid green;">
                <%
                    int currentsize=0;
                    if(totasize-pageIndex*6>=0)
                        currentsize=6;
                    else
                        currentsize=6-(pageIndex*6-totasize);

                    int lie1=0;
                    int lie2=0;
                    if(currentsize==1||currentsize==2||currentsize==3){
                        lie1=currentsize;
                        lie2=0;
                    }
                    else{
                        lie1=3;
                        lie2=currentsize-3;
                    }

                    System.out.println("page"+pageIndex);
                    System.out.println("lie1"+lie1);
                    System.out.println("lie2"+lie2);

                %>

                <tr style="margin-left: 2%">

                <%
                    for(int i=1;i<=lie1;i++){
                %>
                    <td class="item lottery-unit lottery-unit-0 draw-btn" style="border:2px solid red ">

                        <!---<span class="">pic1</span>-->
                        <div style="margin-left:20%;width:120px;height:120px;border:2px solid green;">
                            <img src="images/new-task-bg.jpg" style="width:100%;height:100%">
                        </div>
                        <div><p style="font-size: 10px;margin-left: 40%">继续完成+<%=array[(pageIndex-1)*6-1+i]%></p></div>
                    </td>

                    <td class="gap"></td>
                    <%
                        }
                    %>
                </tr>


                <tr style="margin-left: 2%">

                    <%
                        for(int i=0;i<lie2;i++){
                    %>
                    <td class="item lottery-unit lottery-unit-0 draw-btn" style="border:2px solid red ">

                        <!---<span class="">pic1</span>-->
                        <div style="margin-left:20%;width:120px;height:120px;border:2px solid green;">
                            <img src="images/new-task-bg.jpg" style="width:100%;height:100%">
                        </div>
                        <div><p style="font-size: 10px;margin-left: 40%">继续完成+<%=array[(pageIndex-1)*6-1+4+i]%></p></div>
                    </td>

                    <td class="gap"></td>
                    <%
                        }
                    %>
                </tr>


                <tr>
                    <td colspan="5" align="center">
                        一共14条记录 &nbsp;当前第<%=pageIndex%>页 &nbsp;
                        <a href="javascript:void(0);" class="turnPage" onclick="turnTopPage()">上一页</a>&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);"  class="turnPage" onclick="turnBottomPage()">下一页</a>&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>


    </div>

    <!--已提交-->
    <div id="tabCon_1"  >
        <div id="not_submit" style="margin-left: 2%;border: 2px solid black;width: 90%;height: 600px">
            <!--显示不同任务--->
            <div>

            </div>

        </div>
    </div>
    <!---领取任务-->
    <div id="tabCon_2" >
        <div style="width: 90%;height: 600px;border:2px solid black">


        </div>
    </div>
</div>


</body>


<script>
    var pageIndex=<%=pageIndex %>;
    var totalPage=<%=totalPage %>;
    console.log("777"+pageIndex);

    function  searchKeyword() {
        document.getElementById("pageIndex").value=1;
        document.getElementById("searchForm").submit();

    }

    //上一页
    function turnTopPage(){
        if(pageIndex==1){
            return;
        }else{
            document.getElementById("pageIndex").value=pageIndex-1;
            console.log("888"+pageIndex-1);
            document.getElementById("searchForm").submit();
        }
    }
    //下一页
    function turnBottomPage(){
        if(pageIndex>=totalPage){
            return;
        }else{
            document.getElementById("pageIndex").value=pageIndex+1;
            console.log("888"+pageIndex+1);
            document.getElementById("searchForm").submit();
        }
    }

</script>
