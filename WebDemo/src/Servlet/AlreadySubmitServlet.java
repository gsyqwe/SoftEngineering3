package Servlet;

import Data.ModifacationData;
import Data.TaskData;
import Model.Task;
import Service.ModificationService;
import Service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class AlreadySubmitServlet extends HttpServlet {
    /**
     * 查看已经提交的任务 并重定向到查看的界面
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String taskID=req.getParameter("taskid");
        String userID=(String)req.getSession().getAttribute("currentuser");
        //查看任务的类型（整体？区域？画圈？）同时设置session的值以便后面界面的使用

        TaskService taskService=new TaskData();
        ModificationService modificationService=new ModifacationData();
        Task task=taskService.getTask(taskID);
        if(task.getType()==0){
            //整体查看没做
            req.getRequestDispatcher("/whole_description_check.jsp").forward(req, resp);

        }
        else if(task.getType()==1){
            req.getSession().setAttribute("division_check_recordlist",modificationService.queryRecordByTaskID_UserID(userID,taskID));
            req.getRequestDispatcher("/division_check.jsp").forward(req, resp);
        }
        else{
            System.out.println("跳到labelcheck界面");
            req.getSession().setAttribute("label_check_recordlist",modificationService.queryRecordByTaskID_UserID(userID,taskID));
            req.getRequestDispatcher("/label_check.jsp").forward(req, resp);
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
