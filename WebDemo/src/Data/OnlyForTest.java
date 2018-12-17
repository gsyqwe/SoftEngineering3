package Data;

import Model.Record;
import Model.Task;
import Model.TaskStatusRecord;
import Model.User;
import Service.ModificationService;
import Service.TaskService;
import Service.UserService;

import java.util.ArrayList;

public class OnlyForTest {

    static ModificationService modificationService = new ModifacationData();
    static TaskService taskService = new TaskData();
    static UserService userService = new UserData();
    static FileReader fileReader = new FileReader();

    static void testTasks(){
        ArrayList<Task> tasks = fileReader.getAllItems("tasks");
        for (Task temp : tasks) {
            System.out.println("TaskID:" + temp.getTaskId());
            System.out.println("TaskName:"+temp.getTaskName());
        }
    }

    static void testUsers() {
        ArrayList<User> users = fileReader.getAllItems("users");
        for (User temp : users) {
            System.out.println("UserID:" + temp.getUserId());
            System.out.println("Password:" + temp.getPassword());

        }
    }

    static void testRecords(){
        ArrayList<Record> records = fileReader.getAllItems("records");
        for (Record temp : records) {
            System.out.println("TaskID:"+temp.getTaskID());
            System.out.println("UserID:"+temp.getUserID());
        }
    }

    static void testTaskStatusRecord(){
        ArrayList<TaskStatusRecord> statusRecords = fileReader.getAllItems("taskStatus");
        for (TaskStatusRecord temp : statusRecords) {
            System.out.println("TaskID:" + temp.getTaskID());
            System.out.println("UserID:" + temp.getUserID());
            System.out.println("Status:" + temp.getStatus());
        }
    }

    public static void main(String[] args) {
//        testTasks();
        testUsers();
//        taskService.obtainTask("HYHZ", "110");
//        taskService.finishTask("HYHZ", "110");
        testTaskStatusRecord();
//        testRecords();

    }
}
