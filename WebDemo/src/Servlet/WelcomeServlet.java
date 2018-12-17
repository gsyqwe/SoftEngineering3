package Servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class WelcomeServlet extends HttpServlet {
    private String greeting;
    public void init(){
        greeting=getInitParameter("greeting");

    }

    public void doGet(HttpServletRequest req, HttpServletResponse resq) throws ServletException,IOException{
        req.setCharacterEncoding("UTF-8");
        String username=req.getParameter("username");
        //乱码转换
        String str=new String(username.getBytes("iso-8859-1"),"UTF-8");
        System.out.print(str);
        String welcomeInfo=greeting + " " + str;
        //str正确不过IE不支持所以显示乱码
        resq.setContentType("text/html");

        PrintWriter out=resq.getWriter();

        out.println("<html><head><title>");
        out.println("Welcome Page");
        out.println("</title></head>");
        out.println("<body>");
        out.println(welcomeInfo);
        out.println("</body></html>");
        out.close();

        }

        public void doPost(HttpServletRequest req, HttpServletResponse resq) throws ServletException,IOException{
           doGet(req,resq);

        }
}
