package Servlet;

import Data.ModifacationData;
import Data.TaskData;
import Model.Record;
import Model.Task;
import Service.ModificationService;
import Service.TaskService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class NotSubmitServlet extends HttpServlet {
    private TaskService taskService=new TaskData();
    private ModificationService modificationService=new ModifacationData();

    /**
     *   继续完成未提交的任务
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String taskID=req.getParameter("taskid");
        //设置当前的任务
        String userID=(String)req.getSession().getAttribute("currentuser");
        //根据任务号的类型判断该任务的类型 并跳转到不同的打标签界面
        String method=req.getParameter("method");
        System.out.println(taskID);
        System.out.println(userID);
        Task task=taskService.getTask(taskID);
        HttpSession session=req.getSession();
        //session.setAttribute("");
        System.out.println("任务继续做"+userID+" "+taskID);
        List<Record> list=modificationService.queryRecordByTaskID_UserID(userID,taskID);
        session.setAttribute("recordlist",list);
        System.out.println("新任务的大小"+list.size());
        //整体标注
        System.out.println(task.getType());
        if(method.equals("do")) {
            if (task.getType() == 0) {


            /*if (session.getAttribute("whole_work_index") == null) {
                session.setAttribute("whole_work_index", 2);
            } else if (session.getAttribute("whole_work_index") != null) {
                int n = (int) session.getAttribute("whole_work_index");
                if(n!=task.getPictures().size()-1)
                   session.setAttribute("whole_work_index", n + 1);
            }*/
                req.getRequestDispatcher("/whole_description_work.jsp").forward(req, resp);
            } else if (task.getType() == 1) {
                System.out.println("挑掉区域标注");
                System.out.println("大小"+list.size());
                req.getRequestDispatcher("/division_work.jsp").forward(req, resp);
            } else {
                System.out.println("跳到局部标注");
                req.getRequestDispatcher("/label_work.jsp").forward(req, resp);
            }
        }

        //修改
        else{
            if(task.getType()==0){
                req.getRequestDispatcher("/whole_description_work.jsp").forward(req, resp);
            }
            else if(task.getType()==1){
                req.getSession().setAttribute("division_hidden_value",modificationService.queryRecordByTaskID_UserID(userID,taskID));
                req.getRequestDispatcher("/division_modification.jsp").forward(req, resp);
            }
            else{
                req.getRequestDispatcher("/label_modification.jsp").forward(req, resp);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

