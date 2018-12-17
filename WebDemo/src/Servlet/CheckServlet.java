package Servlet;

import Data.TaskData;
import Model.Task;
import Service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CheckServlet extends HttpServlet {

    private TaskService taskService=new TaskData();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session=req.getSession();

        String userID=(String)session.getAttribute("currentuser");
        String taskID=req.getParameter("taskID");

        Task task=taskService.getTask(taskID);
        //得到所有的record
      //  List<Record> list=
       // if(task.getType){
        //    session.setAttribute;
       // }


    }
}
