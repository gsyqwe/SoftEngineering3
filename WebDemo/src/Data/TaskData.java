package Data;

import Model.*;
import Service.TaskService;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;

public class TaskData implements TaskService {


    @Override
    public ArrayList<Task> queryTask_NotSubmit_(String userID, int state, String keyword) {
        ArrayList<TaskStatusRecord> taskStatusRecords =getTaskStatusByUserID(userID);
        ArrayList<Task> result = new ArrayList<>();
        for (TaskStatusRecord temp : taskStatusRecords) {
            if (temp.getStatus()==state){
                Task task=getTask(temp.getTaskID());
                if (task.getTaskDescription().contains(keyword)||task.getTaskName().contains(keyword))
                    result.add(task);
            }
        }
        return result;
    }

    @Override
    public ArrayList<Task> queryTask_NotSubmit(String userID) {
//        ArrayList<TaskStatusRecord> taskStatusRecords =getTaskStatusByUserID(userID);
//        ArrayList<Task> result = new ArrayList<>();
//        for (TaskStatusRecord temp : taskStatusRecords) {
//            if (temp.getStatus()==0) result.add(getTask(temp.getTaskID()));
//        }
//        return result;
        return queryTask_NotSubmit_(userID,0,"");

    }

    @Override
    public ArrayList<Task> queryTask_AlreadySubmit(String userID) {
//        ArrayList<TaskStatusRecord> taskStatusRecords =getTaskStatusByUserID(userID);
//        ArrayList<Task> result = new ArrayList<>();
//        for (TaskStatusRecord temp : taskStatusRecords) {
//            if (temp.getStatus()==1) result.add(getTask(temp.getTaskID()));
//        }
//        return result;
        return queryTask_NotSubmit_(userID,1,"");
    }

    @Override
    public ArrayList<Task> queryTask_New(String userID) {
        ArrayList<TaskStatusRecord> taskStatusRecords=getTaskStatusByUserID(userID);
        ArrayList<String> taskID=new ArrayList<>();                                   //一个user的所有taskID
        for(TaskStatusRecord taskStatusRecord:taskStatusRecords){
            taskID.add(taskStatusRecord.getTaskID());
        }

        ArrayList<Task> tasks=getAllTasks();
        ArrayList<Task> result=new ArrayList<>();
        for(Task temp:tasks){
            if(!taskID.contains(temp.getTaskId())) result.add(temp);
        }
        return result;
    }

    @Override
    public boolean obtainTask(String userID, String taskID) {
        //1.TaskStatusRecord需要增加 状态默认为0
        insertTSR(new TaskStatusRecord(userID,taskID,0));
        Task task=getTask(taskID);
        for(int i=0;i<task.getPictures().size();i++){
            new ModifacationData().insertRecord(new Record(task.getPictures().get(i),userID,taskID,"","",new ArrayList<CircleLabelItem>(),new ArrayList<AreaLabelItem>()));
        }
        return true;
    }

    @Override
    public boolean finishTask(String userID, String taskID) {
        //1.TaskStatusRecord 状态由0变为1
//        try {
//            FileOutputStream fileOutputStream = new FileOutputStream("fileFBR//ser//taskStatus.ser");
//            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
//            //修改：丢失其它用户的record
//            ArrayList<TaskStatusRecord> taskStatusRecords=getAllTaskStatus();
//            System.out.println(taskStatusRecords.size());
//            for (TaskStatusRecord temp : taskStatusRecords) {
//                if (temp.getTaskID().equals(taskID)&&temp.getUserID().equals(userID)) {
//                    temp.setStatus(1);
//                }
//                objectOutputStream.writeObject(temp);
//            }
//            System.out.println(getAllTaskStatus().size());
//            fileOutputStream.close();
//            objectOutputStream.close();
//            return true;
//        } catch (FileNotFoundException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return false;
        ArrayList<TaskStatusRecord> taskStatusRecords = getAllTaskStatus();
        try {
            FileOutputStream fileOutputStream = new FileOutputStream("fileFBR//ser//taskStatus.ser");
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);

            for (TaskStatusRecord temp : taskStatusRecords) {
                if (temp.getTaskID().equals(taskID) && temp.getUserID().equals(userID)) {
                    TaskStatusRecord taskStatusRecord = temp;
                    taskStatusRecord.setStatus(1);
                    objectOutputStream.writeObject(taskStatusRecord);

                } else {
                    objectOutputStream.writeObject(temp);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public boolean insertTask(String taskId, Date beginTime, Date endTime, String taskName, String taskDescription, ArrayList<String> pictures, int type) {
        ArrayList<Task> tasks = getAllTasks();
        ArrayList<Task> result = new ArrayList<>();
        for (Task temp : tasks) {
            if (temp.getTaskId().equals(taskId)) {
                return false;
            } else result.add(temp);
        }
        result.add(new Task(taskId, beginTime, endTime, taskName, taskDescription, pictures, type));

        try {
            FileOutputStream fileOutputStream = new FileOutputStream("fileFBR//ser//tasks.ser");
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
            for (Task temp : result) {
                objectOutputStream.writeObject(temp);
            }
            fileOutputStream.close();
            objectOutputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public void deleteTask(String taskID) {
        ArrayList<Task> tasks = getAllTasks();
        ArrayList<Task> result = new ArrayList<>();
        for (Task temp : tasks) {
            if (taskID.equals(temp.getTaskId())) {

            } else {
                result.add(temp);
            }
        }


    }

    public void insertTSR(TaskStatusRecord taskStatusRecord){
        ArrayList<TaskStatusRecord> taskStatusRecords = getAllTaskStatus();
//                new TaskData().getTaskStatusByUserID(taskStatusRecord.getUserID());
        taskStatusRecords.add(taskStatusRecord);
        try {
            FileOutputStream filestream=new FileOutputStream("fileFBR//ser//taskStatus.ser");
            ObjectOutputStream os=new ObjectOutputStream(filestream);
            for(TaskStatusRecord temp:taskStatusRecords){
                os.writeObject(temp);
            }
            filestream.close();
            os.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void writeTask(ArrayList<Task> tasks) {
        try {
            FileOutputStream fileOutputStream = new FileOutputStream("fileFBR//ser//tasks.ser");
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
            for (Task temp : tasks) {
                objectOutputStream.writeObject(temp);
            }
            fileOutputStream.close();
            objectOutputStream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private ArrayList<TaskStatusRecord> getAllTaskStatus(){
        return new FileReader().getAllItems("taskStatus");
    }

    private ArrayList<Task> getAllTasks(){
        return new FileReader().getAllItems("tasks");
    }

    private ArrayList<TaskStatusRecord> getTaskStatusByUserID(String userID){
        ArrayList<TaskStatusRecord> taskStatusRecords = getAllTaskStatus();
        ArrayList<TaskStatusRecord> result = new ArrayList<>();
        for (TaskStatusRecord temp : taskStatusRecords) {
            if (temp.getUserID().equals(userID)) result.add(temp);
        }
        return result;

    }

    @Override
    public Task getTask(String taskID) {
        ArrayList<Task> tasks = getAllTasks();
        for (Task temp : tasks) {
            if (temp.getTaskId().equals(taskID)) return temp;
        }
        System.out.println("空指针异常可能是因为在TaskData的getTask方法中返回了null！");
        return null;
    }

    private void temp(String num) {

        Date date=new Date();
        ArrayList<String> pictures = new ArrayList<>();
        pictures.add("fileFBR//task//12"+num+"//1.jpg"); //改文件夹
        pictures.add("fileFBR//task//12"+num+"//2.jpg"); //改文件夹
        pictures.add("fileFBR//task//12"+num+"//p1.jpg"); //改文件夹

        insertTask("12"+num, date, date, "Task"+num, "局部标注", pictures,2);//改taskID、type、taskDescription

        insertTask("12"+num, date, date, "Task"+num, "Demo Task for Test", pictures,2);
////改taskID 改taskName
//        insertTSR(new TaskStatusRecord("HYHZ", "10"+num, 0)); //改taskID


//        Record record1 = new Record("fileFBR//task//12" + num + "//1.jpg", "HYHZ", "12" + num, "", "", new ArrayList<CircleLabelItem>(), new ArrayList<AreaLabelItem>());
//        Record record2 = new Record("fileFBR//task//12" + num + "//2.jpg", "HYHZ", "12" + num, "", "", new ArrayList<CircleLabelItem>(), new ArrayList<AreaLabelItem>());
//        Record record3 = new Record("fileFBR//task//12" + num + "//p1.jpg", "HYHZ", "12" + num, "", "", new ArrayList<CircleLabelItem>(), new ArrayList<AreaLabelItem>());
//        ModifacationData modifacationData = new ModifacationData();
//        modifacationData.insertRecord(record1);
//        modifacationData.insertRecord(record2);
//        modifacationData.insertRecord(record3);

    }

    public static void main(String[] args) {
        TaskData taskData = new TaskData();
        taskData.temp("0");
        taskData.temp("1");
        taskData.temp("2");
//        TaskData taskData = new TaskData();
//        taskData.temp("0");
//        taskData.temp("1");
//        taskData.temp("2");
//        taskData.temp("3");
//        taskData.temp("4");
//        taskData.temp("5");
//        taskData.temp("6");
//        taskData.temp("7");
    }
}
