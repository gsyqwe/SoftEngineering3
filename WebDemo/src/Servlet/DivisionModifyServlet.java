package Servlet;

import Data.ModifacationData;
import Model.AreaLabelItem;
import Service.ModificationService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.geom.Area;
import java.io.IOException;

public class DivisionModifyServlet extends HttpServlet {
    private ModificationService modificationService=new ModifacationData();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userID=req.getParameter("userID");
        String taskID=req.getParameter("taskID");
        String pictureID=req.getParameter("pictureID");
        String division_label=req.getParameter("division_label");
        String division_description=req.getParameter("division_description");
        String itemID=req.getParameter("itemID");
        //更新
        AreaLabelItem areaLabelItem=new AreaLabelItem(userID,taskID,pictureID,division_label,division_description,null);
        areaLabelItem.setItemID(Integer.valueOf(itemID));
        modificationService.modifyAreaItem(areaLabelItem);

        req.getRequestDispatcher("/division_modification.jsp").forward(req, resp);
    }
}
