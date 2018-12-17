<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/17
  Time: 21:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="Service.TaskService,Model.Task,java.util.*" language="java" %>
<%@ page import="Data.TaskData" %>
<%@ page import="Model.Task" %>
<html>
<head>
    <title>Title</title>
    <style>
        body{
            border: 2px solid green;
        }

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

    </style>
</head>
<body>
<%
    int pageIndex=1;//当前页面号，用于控制页面翻转，默认为1
    TaskService taskService=new TaskData();
    List<Task> list=taskService.queryTask_New((String)session.getAttribute("currentuser"));

    int totalPage=(list.size()-1)/6+1;
    int totalSize=list.size();


    if(request.getParameter("pageIndex")!=null) {//不是第一次加载
        System.out.println("当前page"+request.getParameter("pageIndex"));
        pageIndex=Integer.valueOf(request.getParameter("pageIndex"));

    }


%>

<div id="tabCon_0" style="margin-top: 0.5%;margin-left: 0.5%; background-image: url(images/new-task-bg.jpg);
            background-size: cover;width: 98%;height: 98%">

    <!--隐藏搜索框-->
    <form id="searchForm" name="searchForm" action="Main_newtask.jsp"  method="get" style="border: 2px solid blue">
                <input type="hidden" name="pageIndex" id="pageIndex"  value="1">
        <input type="hidden" name="whichnewtask" name="whichnewtask" value="0">
    </form>




        <!--图片展示-->
        <div class="draw" id="lottery" style="margin-left: 5%">
            <table style="width:1000px;border:2px solid green;">
                <%
                    int currentsize=0;
                    if(totalSize-pageIndex*6>=0)
                        currentsize=6;
                    else
                        currentsize=6-(pageIndex*6-totalSize);

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
                    //System.out.println("page"+pageIndex);
                    //System.out.println("lie1"+lie1);
                    //System.out.println("lie2"+lie2);

                %>

                <tr style="margin-left: 2%">

                    <%
                        for(int i=1;i<=lie1;i++){
                    %>
                    <td class="item lottery-unit lottery-unit-0 draw-btn" style="border:2px solid red ">

                        <!---<span class="">pic1</span>-->
                        <div style="margin-left:20%;width:120px;height:120px;border:2px solid green;">
                            <img src="<%=list.get((pageIndex-1)*6-1+i).getPictures().get(0)%>" style="width:100%;height:100%">
                        </div>
                        <div ><p style="font-size: 10px";>描述：<%=list.get((pageIndex-1)*6-1+i).getTaskDescription()%></p> </div>
                       <!---- <div><p style="font-size: 10px;margin-left: 40%">领取</p></div>--->

                            <!----<div><p style="font-size: 10px;margin-left: 40%" >领取</p></div>--->
                            <a href="NewTaskServlet?taskid=<%=list.get((pageIndex-1)*6-1+i).getTaskId()%>">领取</a>&nbsp;&nbsp;&nbsp;


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
                            <img src="<%=list.get((pageIndex-1)*6-1+4+i).getPictures().get(0)%>" style="width:100%;height:100%">
                        </div>
                        <div ><p style="font-size: 10px";>描述：<%=list.get((pageIndex-1)*6-1+4+i).getTaskDescription()%></p> </div>



                             <!----<div><p style="font-size: 10px;margin-left: 40%" >领取</p></div>--->
                            <a href="NewTaskServlet?taskid=<%=list.get((pageIndex-1)*6-1+4+i).getTaskId()%>">领取</a>&nbsp;&nbsp;&nbsp;

                    </td>

                    <td class="gap"></td>
                    <%
                        }
                    %>
                </tr>


                <tr>
                    <td colspan="5" align="center">
                        一共<%=totalPage%>条记录 &nbsp;当前第<%=pageIndex%>页 &nbsp;
                        <a href="javascript:void(0);" class="turnPage" onclick="turnTopPage()">上一页</a>&nbsp;&nbsp;&nbsp;
                        <a href="javascript:void(0);"  class="turnPage" onclick="turnBottomPage()">下一页</a>&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>



</div>


</body>
<script>
    var pageIndex=<%=pageIndex %>;
    var totalPage=<%=totalPage %>;

    //上一页
    function turnTopPage(){
        if(pageIndex==1){
            return;
        }else{
            document.getElementById("pageIndex").value=pageIndex-1;
            document.getElementById("searchForm").submit();
        }
    }
    //下一页
    function turnBottomPage(){
        if(pageIndex>=totalPage){
            return;
        }else{
            document.getElementById("pageIndex").value=pageIndex+1;
            document.getElementById("searchForm").submit();
        }
    }



</script>
</html>
