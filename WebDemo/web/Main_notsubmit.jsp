<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/17
  Time: 21:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" import="Service.TaskService,Model.Task,java.util.*" language="java" %>
<%@ page import="Data.TaskData" %>
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
    List<Task> list=( List<Task>)session.getAttribute("task_notsubmit");
    //list=taskService.queryTask_New()
    list=taskService.queryTask_NotSubmit((String)request.getSession().getAttribute("currentuser"));
    System.out.println("未提交的任务个数"+list.size()+"当前用户"+request.getSession().getAttribute("currentuser"));
    //一共多少页
    int totalPage=(list.size()-1)/6+1;
    //一共多少条记录
    int totalSize=list.size();
    if(request.getParameter("pageIndex")!=null) {//不是第一次加载
        System.out.println("当前page"+request.getParameter("pageIndex"));
        pageIndex=Integer.valueOf(request.getParameter("pageIndex"));

    }


%>

<div id="tabCon_0" style="margin-top: 0.5%;margin-left: 0.5%; background-image: url(images/new-task-bg.jpg);
            background-size: cover;width: 98%;height: 98%">

    <!--搜索框-->
    <form id="searchForm" name="searchForm" action="Main_notsubmit.jsp"  method="get" style="border: 2px solid blue">
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
                    <div style="float: left;width: 80px;height: 25px"> <p style="font-size: 10px;margin-left: 20%"><a href="NotSubmitServlet?method=update&taskid=<%=list.get((pageIndex-1)*6-1+i).getTaskId()%>">修改</a></p></div>
                    <div style="float: left;width: 80px;height: 25px"><p style="font-size: 10px;margin-left: 20%"><a href="NotSubmitServlet?method=do&taskid=<%=list.get((pageIndex-1)*6-1+i).getTaskId()%>">继续完成</a></p></div>
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
                    <div style="float: left ;width: 80px;height: 25px"> <p style="font-size: 10px;margin-left:20%"><a href="NotSubmitServlet?method=update&taskid=<%=list.get((pageIndex-1)*6-1+4+i).getTaskId()%>">修改</a></p></div>
                    <div style="float: left;width: 80px;height: 25px"><p style="font-size: 10px;margin-left: 20%"><a href="NotSubmitServlet?method=do&taskid=<%=list.get((pageIndex-1)*6-1+4+i).getTaskId()%>">继续完成</a></p></div>
                </td>

                <td class="gap"></td>
                <%
                    }
                %>
            </tr>


            <tr>
                <td colspan="5" align="center">
                    一共<%=totalSize%>条记录 &nbsp;一共<%=totalPage%>页 &nbsp;当前第<%=pageIndex%>页 &nbsp;
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
