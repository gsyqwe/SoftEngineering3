package Model;

import java.io.Serializable;
import java.util.ArrayList;

public class Record implements Serializable{
    private String url;                             //图片
    private String userID;
    private String taskID;
    private String overallTitle;                    //整体标注
    private String overallDescription;              //整体描述
    private ArrayList<CircleLabelItem> circleLabel;            //局部？
    private ArrayList<AreaLabelItem> areaLabel;              //

    public Record(String url, String userID, String taskID, String overallTitle, String overallDescription, ArrayList<CircleLabelItem> circleLabel, ArrayList<AreaLabelItem> areaLabel) {
        this.url = url;
        this.userID = userID;
        this.taskID = taskID;
        this.overallTitle = overallTitle;
        this.overallDescription = overallDescription;
        this.circleLabel = circleLabel;
        this.areaLabel = areaLabel;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
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

    public String getOverallTitle() {
        return overallTitle;
    }

    public void setOverallTitle(String overallTitle) {
        this.overallTitle = overallTitle;
    }

    public String getOverallDescription() {
        return overallDescription;
    }

    public void setOverallDescription(String overallDescription) {
        this.overallDescription = overallDescription;
    }

    public ArrayList<CircleLabelItem> getCircleLabel() {
        return circleLabel;
    }

    public void setCircleLabel(ArrayList<CircleLabelItem> circleLabe) {
        this.circleLabel = circleLabe;
    }

    public ArrayList<AreaLabelItem> getAreaLabel() {
        return areaLabel;
    }

    public void setAreaLabel(ArrayList<AreaLabelItem> areaLabel) {
        this.areaLabel = areaLabel;
    }
}
