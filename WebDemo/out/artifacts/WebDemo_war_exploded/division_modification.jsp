<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Record" %>
<%@ page import="Model.AreaLabelItem" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.CircleLabelItem" %>
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
    recordlist=(ArrayList<Record>)session.getAttribute("division_m_list");
    ArrayList<AreaLabelItem>  arealist=new ArrayList<AreaLabelItem>();
    ArrayList<String> picturelist=new ArrayList<String>();
    for(int i=0;i<recordlist.size();i++){
            for (int j = 0; j < recordlist.get(i).getAreaLabel().size(); j++) {
                arealist.add(recordlist.get(i).getAreaLabel().get(j));
                picturelist.add(recordlist.get(i).getUrl());
        }
    }

    //将所有存在的item拿出来
    int number=0;//我的Number没有做得到啊

    if(request.getParameter("division_hidden_value")!=null)
        number=Integer.valueOf(request.getParameter("division_hidden_value"));
    if(number>=recordlist.size()-1){
        number=recordlist.size()-1;
        %>
   <script>
       alert("已经到最后一张");
   </script>
<%
    }

    System.out.println("number"+number);


%>
<body background="D://picture/d.jpg">

<!---放图片的工作区域  -->
<!-- 进行区域划分，画长方形 -->
<!-- 放提交按钮 -->
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
<div  >
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

    <div>

        <a href="javascript:void(0);"  onclick="changeImage()">下一页</a>&nbsp;&nbsp;&nbsp;

    </div>

    <form id="division_save_form" action="DivisionModifyServlet">
        <input type="text" id="division_label" name="division_label"value="<%=arealist.get(number).getLabel()%>">区域标注
        <input type="text" id="division_description" name="division_description" value="<%=arealist.get(number).getDescription()%>">区域描述
        <input type="hidden" id="userID" name="userID" value="<%=arealist.get(number).getUserID()%>">
        <input type="hidden" id="taskID" name="taskID" value="<%=arealist.get(number).getTaskID()%>">
        <input type="hidden" id="itemID" name="itemID" value="<%=arealist.get(number).getItemID()%>">
        <input type="submit" value="更新">
    </form>


    <form action="division_modification.jsp"  id="division_m_f">
        <input type="hidden" value="0" id="division_hidden_value" name="division_hidden_value" >
    </form>

</div>
<!-- 切换图片的功能 -->
<script>
    var n=<%=number%>;
    function changeImage() {
        document.getElementById("division_hidden_value").value=n+1;
        //document.getElementById("whole_information").clear();
        //document.getElementById("whole_description").clear();
        document.getElementById("division_m_f").submit();

    }
</script>


<!-- 兼顾修改功能的函数实现，先调用这个在去在画布上作画 -->
<script>
    function drawarea(){
        var n=<%=arealist.get(number).getPointList().size()%>;
        if(n!=0)
        {
            var c = document.getElementById("canvas");
            var canvasRect = c.getBoundingClientRect();
            //矩形框的左上角坐标
            var canvasLeft = canvasRect.left;
            var canvasTop = canvasRect.top;
            var ctx = c.getContext('2d');
            var number =<%=arealist.get(number).getPointList().size()%>;
            for (var i = 0; parseInt(i) < number - 1; i = i + 2) {
                //进行画矩形
                ctx.beginPath();
                cxt.lineWidth = 5;
                cxt.strokeStyle = "red";
                var begin_x = <%=arealist.get(number).getPointList().get(index).getX()%>-canvasLeft;
                var begin_y = <%=arealist.get(number).getPointList().get(index)%>-canvasTop;
                var to_x = <%=arealist.get(number).getPointList().get(index+1)%>-canvasLeft;
                var to_y = <%=arealist.get(number).getPointList().get(index+1)%>-canvasTop;
                <% index=index+2;%>;
                ctx.moveTo(begin_x, begin_y);
                ctx.lineTo(begin_x, to_y);
                ctx.lineTo(begin_y, to_x);
                ctx.moveTo(to_x, to_y);
                ctx.lineTo(begin_x, to_y);
                ctx.lineTo(begin_y, to_x);
                ctx.closePath();
            }
        }
    }
</script>
</body>
</html>