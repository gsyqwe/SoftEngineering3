<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2018/3/16
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%
        int allRecord=0;//总的记录条数,不包含查询后的
        int totalRecord=0;//总的记录条数,包含查询后的
        int totalPage=3;//总的页面数，包含查询后的
        int pageIndex=1;//当前页面号，用于控制页面翻转，默认为1
        int [] array={1,2,3,4,5,6,7,8,9};

        if(request.getParameter("pageIndex")!=null) {//不是第一次加载
                 System.out.println("page"+request.getParameter("pageIndex"));
                 pageIndex=Integer.valueOf(request.getParameter("pageIndex"));
        }
            System.out.println("total"+totalPage);
        
    %>
</head>
<body>
<div style="border: 2px solid navajowhite">
  <form id="searchForm" name="searchForm" action="session.jsp"  method="get">
      <input type="hidden" name="pageIndex" id="pageIndex"  value="1">
      <div id="search">
          <div ></div>
          <input type="text" id="keyword" name="keyword" placeholder="请输入要查询的记录">
          <img src="images/e.jpg" onclick="searchKeyword();">

          <table>
              <tr>
              <%
                  for(int i=0;i<3;i++){
              %>
                  <td>
                          <%=(pageIndex-1)*3+i%>;
                  </td>
              <%
                  }
              %>

              </tr>



          </table>
          <a href="javascript:void(0);" class="turnPage" onclick="turnTopPage()">上一页</a>&nbsp;&nbsp;&nbsp;
          <a href="javascript:void(0);"  class="turnPage" onclick="turnBottomPage()">下一页</a>&nbsp;&nbsp;&nbsp;

      </div>
  </form>
    
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

    var num=1;



</script>
</html>
