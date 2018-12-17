package Model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class  Task implements Serializable{
    private String taskId;
    private int type;
    private Date beginTime;
    private Date endTime;
    private String taskName;                        //任务名称
    private String taskDescription;                 //任务描述
    private ArrayList<String> pictures;             //src

    public ArrayList<String> getPictures() {
        return pictures;
    }

    public void setPictures(ArrayList<String> pictures) {
        this.pictures = pictures;
    }

    public Task(String taskId, Date beginTime, Date endTime, String taskName, String taskDescription, ArrayList<String> pictures,int type) {
        this.taskId = taskId;
        this.beginTime = beginTime;
        this.endTime = endTime;
        this.taskName = taskName;
        this.taskDescription = taskDescription;
        this.pictures = pictures;
        this.type=type;
    }

    public String getTaskId() {
        return taskId;
    }

    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
