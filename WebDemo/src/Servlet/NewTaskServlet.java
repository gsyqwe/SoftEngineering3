package Servlet;

import Data.TaskData;
import Service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class NewTaskServlet extends HttpServlet {
    private TaskService taskService=new TaskData();
    /**
     * 领取新的任务 回到原来的界面
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String taskID=req.getParameter("taskid");
        String userID=(String)req.getSession().getAttribute("currentuser");
        //后台更新用户的领取信息
        System.out.println("领取任务"+userID+" "+taskID);
        taskService.obtainTask(userID,taskID);

        System.out.println("领取任务"+taskID);


       //回到领取任务界面
        req.setAttribute("message","领取成功");
        req.getSession().setAttribute("task_notsubmit",taskService.queryTask_NotSubmit(userID));
        req.getRequestDispatcher("/Main_newtask.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
