package Service;



import Model.Task;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 */
public interface TaskService {
    /**
     * @param userID 用户名
     * @return 未提交的任务集
     */
    ArrayList<Task> queryTask_NotSubmit(String userID);

    /**
     * @param userID  用户名
     * @param state   代表已提交还是未提交
     * @param keyword 关键词
     * @return
     */
    ArrayList<Task> queryTask_NotSubmit_(String userID, int state, String keyword);

    /**
     * @param userID 用户名
     * @return 已提交的任务集
     */
    ArrayList<Task> queryTask_AlreadySubmit(String userID);


    /**
     * @param userID 用户名
     * @return 可领取的新的任务集
     */
    ArrayList<Task> queryTask_New(String userID);

    /**
     * @param userID
     * @param taskID
     * @return 领取任务
     */
    boolean obtainTask(String userID, String taskID);

    /**
     * @param userID
     * @param taskID
     * @return 完成任务
     */
    boolean finishTask(String userID, String taskID);

    boolean insertTask(String taskId, Date beginTime, Date endTime, String taskName, String taskDescription, ArrayList<String> pictures, int type);

    void deleteTask(String taskID);

    Task getTask(String taskID);


}