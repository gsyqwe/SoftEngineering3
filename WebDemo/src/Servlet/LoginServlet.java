package Servlet;

import Data.TaskData;
import Data.UserData;
import Service.TaskService;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private UserService userService = new UserData();
    private TaskService taskService=new TaskData();


    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
            doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        request.setCharacterEncoding("UTF-8");
        String name=request.getParameter("username");
        String password=request.getParameter("p");
        System.out.println("登录:当前用户名"+name+"当前密码"+password);
        HttpSession session=request.getSession();
        if(Isempty(name)||Isempty(password)){
            request.setAttribute("message","请将信息输入完整");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        else if(!userService.isExist(name)){
            //用户名不存在
            request.setAttribute("message","该用户不存在");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        else if(!userService.login(name,password)){
            //密码不一致
            request.setAttribute("message","密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }

        else{

            //此处是界面重新定位，需要保存当前用户的一些信息
            request.setAttribute("message","success");
            session.setAttribute("currentuser",name);
            session.setAttribute("task_notsubmit",taskService.queryTask_NotSubmit(name));
            System.out.println(taskService.queryTask_NotSubmit(name).size()+"789789789");
           // System.out.println("520520"+taskService.queryTask_NotSubmit(name).size());
            session.setAttribute("task_alreadysubmit",taskService.queryTask_AlreadySubmit(name));
            session.setAttribute("task_new",taskService.queryTask_New(name));
            //System.out.println("520520"+taskService.queryTask_New(name).size());
            response.sendRedirect("Main6.jsp");
        }


    }

    private boolean Isempty(String str){
        if(str==null||str.length()==0)
            return true;
        else
            return false;
    }

}
