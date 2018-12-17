package Servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MyServlet extends HttpServlet {

    private String target="/hello.jsp";

    public void init(ServletConfig config) throws ServletException{
        super.init(config);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        System.out.print("get");
        doPost(request,response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        String username=request.getParameter("username");
        String password=request.getParameter("password");

        request.setAttribute("USER",username);
        request.setAttribute("PASSWORD",password);

        ServletContext context=getServletContext();

        System.out.print("Redirecting to " + target);
        RequestDispatcher myServlet=context.getRequestDispatcher(target);
        myServlet.forward(request,response);

    }
}
