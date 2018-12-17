package Model;



import Data.ModifacationData;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class AreaLabelItem implements Serializable{

    private String userID;

    private String taskID;

    private int itemID;

    private String pictureID;

    private String label;

    private String description;

    private List<Point> pointList;

    public AreaLabelItem(String userID, String taskID, String pictureID, String label, String description, List<Point> pointList) {
            this.userID = userID;
        this.taskID = taskID;
        this.pictureID = pictureID;
        this.label = label;
        this.description = description;
        this.pointList = pointList;
        ArrayList<AreaLabelItem> areaLabelItems = new ModifacationData().getRecordPrecisely(userID, taskID, pictureID).getAreaLabel();
        int max=0;
        for (AreaLabelItem temp : areaLabelItems) {
            if (temp.getItemID() > max) {
                max=temp.getItemID();
            }
        }
        this.itemID=max+1;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getTaskID() {
        return taskID;
    }

    public void setTaskID(String taskID) {
        this.taskID = taskID;
    }

    public int getItemID() {
        return itemID;
    }

    public void setItemID(int itemID) {
        this.itemID = itemID;
    }

    public String getPictureID() {
        return pictureID;
    }

    public void setPictureID(String pictureID) {
        this.pictureID = pictureID;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Point> getPointList() {
        return pointList;
    }

    public void setPointList(List<Point> pointList) {
        this.pointList = pointList;
    }
}
