package Servlet;

import Data.ModifacationData;
import Model.CircleLabelItem;
import Model.Point;
import Service.ModificationService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LabelSaveServlet extends HttpServlet{
    private ModificationService modificationService=new ModifacationData();

    //保存
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID=req.getParameter("userID");
        String taskID=req.getParameter("taskID");
        String pictureID=req.getParameter("pictureID");
        String label_label=req.getParameter("label_label");
        String label_description=req.getParameter("label_description");
        String pointlist=req.getParameter("label_point");

        System.out.println("PO"+pointlist);
        pointlist=pointlist.trim();
        String []list=pointlist.split(" ");
        //System.out.println(list.length);
        List<Point> lastpoint=new ArrayList<Point>();
        for(int i=0;i<list.length/2;i++){
            Point point=new Point();
            System.out.println("dian"+list[i*2]);
            point.setX(Float.valueOf(list[i*2]));
            point.setY(Float.valueOf(list[i*2+1]));
            lastpoint.add(point);
        }

        if(req.getSession().getAttribute("label_work_index")!=null){
            int index=Integer.valueOf(String.valueOf(req.getSession().getAttribute("label_work_index")));
            req.getSession().setAttribute("label_work_index",index);
        }
        else{
            req.getSession().setAttribute("division_work_index",0);
        }

        CircleLabelItem circleLabelItem=new CircleLabelItem(userID,taskID,pictureID,label_label,label_description,lastpoint);
        modificationService.insertCircleItem(circleLabelItem);
        req.getRequestDispatcher("/label_work.jsp").forward(req, resp);



    }



    //提交画圈标注的任务
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID=req.getParameter("label_submit_userID");
        String taskID=req.getParameter("label_submit_taskID");
        boolean flag=modificationService.taskFinished(userID,taskID);
        System.out.println("提交的任务号"+taskID);
        System.out.println("shifoutijiao"+flag);
        if(flag==true){
            req.setAttribute("message","提交成功");
            req.getSession().removeAttribute("label_work_index");
            //提交成功后转到未提交任务界面
            req.getRequestDispatcher("/Main_notsubmit.jsp").forward(req, resp);
        }
        else{
            req.setAttribute("message","任务未完成，不能提交");
            req.getRequestDispatcher("/label_work.jsp").forward(req, resp);
        }
    }
}
