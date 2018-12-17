package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class DemoServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID=req.getParameter("userID");
        String method=req.getParameter("method");
        System.out.println("userID"+userID+"method"+method);
        //配置支持跨域
        resp.setHeader("Access-Control-Allow-Origin", "*");
        PrintWriter p=resp.getWriter();
        p.println("789789");
        p.write("456");
        p.flush();
        p.close();
        req.getRequestDispatcher("/DemoII.html").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }



}
