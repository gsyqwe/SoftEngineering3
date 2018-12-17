package Servlet;

import Data.UserData;
import Service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet{

    private UserService userService=new UserData();


    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        request.setCharacterEncoding("UTF-8");
        String name=request.getParameter("user");
        String password1=request.getParameter("passwd");
        String password2=request.getParameter("passwd2");
        String telephone=request.getParameter("qq");
        System.out.println("注册"+name+password1+password2+telephone);

        if(Isempty(name)||Isempty(password1)||Isempty(password2)||Isempty(telephone)) {
            request.setAttribute("message","请将信息输入完整");
            request.getRequestDispatcher("/login.jsp").forward(request, response);

        }
        else if(userService.isExist(name)){
            request.setAttribute("message","该用户名已经被注册");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        else if(!password1.equals(password2)){
            request.setAttribute("message","两次密码输入不一致");
             request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        else
        {
            //后台新增用户
            request.setAttribute("message","注册成功，现在登录");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }


    }

    private boolean Isempty(String str){
        if(str==null||str.length()==0)
            return true;
        else
            return false;
    }

}
