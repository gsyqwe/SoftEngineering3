package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class WorkServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException {
        System.out.print("789789");
        //String method=request.getParameter("method");
        //System.out.println("me"+method);
       // String object= request.getParameter("xlist");
        //System.out.println("obj"+object);


       // String m=(String)request.getSession().getAttribute("method");
        //String x=(String)request.getSession().getAttribute("xlist");

        String point=request.getParameter("point");
        System.out.println(point);


    }






}
