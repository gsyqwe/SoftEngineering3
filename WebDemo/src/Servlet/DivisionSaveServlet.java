package Servlet;

import Data.ModifacationData;
import Data.TaskData;
import Model.AreaLabelItem;
import Model.Point;
import Service.ModificationService;
import Service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DivisionSaveServlet extends HttpServlet {
    private ModificationService modificationService=new ModifacationData();
    private TaskService taskService=new TaskData();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID=req.getParameter("userID");
        String taskID=req.getParameter("taskID");
        String pictureID=req.getParameter("pictureID");
        String division_label=req.getParameter("division_label");
        String division_description=req.getParameter("division_description");
        String pointlist=req.getParameter("division_point");
        //保存
        List<Point> lastpointlist=new ArrayList<Point>();
        String[] list=pointlist.split(" ");
        for(int i=0;i<list.length/2;i++){
            Point point=new Point();
            point.setX(Float.valueOf(list[i*2]));
            point.setY(Float.valueOf(list[i*2+1]));
            lastpointlist.add(point);
        }

        System.out.println("区域标注保存");
        AreaLabelItem areaLabelItem=new AreaLabelItem(userID,taskID,pictureID,division_label,division_description,lastpointlist);
        modificationService.insertAreaItem(areaLabelItem);
        //刷新界面
        if(req.getSession().getAttribute("division_work_index")!=null){
            int index=Integer.valueOf(String.valueOf(req.getSession().getAttribute("division_work_index")));
            req.getSession().setAttribute("division_work_index",index);
        }
        else{
            req.getSession().setAttribute("division_work_index",0);
        }
        req.getRequestDispatcher("/division_work.jsp").forward(req, resp);
    }


    //提交区域标注的任务
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String userID=req.getParameter("division_submit_userID");
      String taskID=req.getParameter("division_submit_taskID");
      boolean flag=modificationService.taskFinished(userID,taskID);
      System.out.println("提交的任务号"+taskID);
      System.out.println("shifoutijiao"+flag);
      if(flag==true){
           req.setAttribute("message","提交成功");
           req.getSession().removeAttribute("division_work_index");
          req.getSession().setAttribute("task_alreadysubmit",taskService.queryTask_AlreadySubmit(userID));
          //提交成功后转到未提交任务界面
          req.getRequestDispatcher("/Main_notsubmit.jsp").forward(req, resp);
      }
      else{
          req.setAttribute("message","任务未完成，不能提交");
          req.getRequestDispatcher("/division_work.jsp").forward(req, resp);
      }
    }
}
