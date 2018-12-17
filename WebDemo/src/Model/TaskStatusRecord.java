package Model;

import java.io.Serializable;

public class TaskStatusRecord implements Serializable{
    private String userID;
    private String taskID;
    private int status;  //0：未提交 1：已提交

    public TaskStatusRecord(String userID, String taskID, int status) {
        this.userID = userID;
        this.taskID = taskID;
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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


}
