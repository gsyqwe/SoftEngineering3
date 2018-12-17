package Servlet;

import Data.ModifacationData;
import Data.TaskData;
import Model.Record;
import Service.ModificationService;
import Service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class WholeSaveServlet extends HttpServlet {
    private ModificationService modificationService=new ModifacationData();
    private TaskService taskService=new TaskData();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID=(String)req.getSession().getAttribute("currentuser");
        String taskID=(String)req.getSession().getAttribute("taskID");
        String pictureurl=req.getParameter("pictureID");
        String whole_information=req.getParameter("whole_information");
        String whole_descrition=req.getParameter("whole_description");
        //保存

        //Record record=new Record(pictureurl,userID,taskID,whole_information,whole_descrition,null,null);
        modificationService.modifyOverall(taskID,userID,pictureurl,whole_information,whole_descrition);

        req.getRequestDispatcher("/whole_description_work.jsp").forward(req, resp);
    }

    //提交任务


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
           String userID=req.getParameter("userID");
           String taskID=req.getParameter("taskID");
           //提交任务

           boolean flag=modificationService.taskFinished(userID,taskID);



    }
}
