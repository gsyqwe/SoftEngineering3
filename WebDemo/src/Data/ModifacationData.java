package Data;


import Model.AreaLabelItem;
import Model.CircleLabelItem;
import Model.Record;
import Model.Task;
import Service.ModificationService;
import Service.TaskService;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

public class ModifacationData implements ModificationService {

    @Override
    public void modifyRecord(Record record) {
        ArrayList<Record> records = getAllRecords();
        ArrayList<Record> result = new ArrayList<>();
        String userID=record.getUserID();
        String taskID=record.getTaskID();
        String picture=record.getUrl();
        for (Record temp : records) {
            if (temp.getUserID().equals(userID) && temp.getTaskID().equals(taskID) && temp.getUrl().equals(picture)) {   //同user 同task 同picture 进行"替换"
                result.add(record);
            } else result.add(temp);
        }
        writeRecords(result);

    }

    public void insertRecord(Record record) {
        ArrayList<Record> records = getAllRecords();
        records.add(record);
        writeRecords(records);
    }

    @Override
    public void deleteRecord(Record record) {
        ArrayList<Record> records = getAllRecords();
        ArrayList<Record> result = new ArrayList<>();
        String userID=record.getUserID();
        String taskID=record.getTaskID();
        String picture=record.getUrl();
        for (Record temp : records) {
            if (temp.getUserID().equals(userID) && temp.getTaskID().equals(taskID) && temp.getUrl().equals(picture)) {   //同user 同task 同picture 进行"替换"
                ; //不作操作
            } else result.add(temp);
        }
        writeRecords(result);
    }

    private void writeRecords(ArrayList<Record> contentList) {
        try {
            FileOutputStream fileOutputStream = new FileOutputStream("fileFBR//ser//records.ser");
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
            for (Record temp : contentList) {
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

    @Override
    public List<Record> queryRecordByTaskID_UserID(String userID, String taskID) {
        ArrayList<Record> records = getAllRecords();
        ArrayList<Record> result = new ArrayList<>();
        for (Record temp : records) {
            if (temp.getUserID().equals(userID) && temp.getTaskID().equals(taskID)) {
                result.add(temp);
            }
        }

//        ArrayList<String> arrayList=new ArrayList<>();
//        for(Record record:result){
//            arrayList.add(record.getUrl()) ;
//        }
//        Task task=new TaskData().getTask(taskID);
//        for(int i=0;i<task.getPictures().size();i++){
//            if(!arrayList.contains(task.getPictures().get(i))){
//                result.add(new Record(task.getPictures().get(i),userID,taskID,"","",new ArrayList<CircleLabelItem>(),new ArrayList<AreaLabelItem>()));
//            }
//        }
        return result;
    }

    @Override
    public void modifyAreaItem(AreaLabelItem areaLabelItem) {
        Record record = getRecordPrecisely(areaLabelItem.getUserID(), areaLabelItem.getTaskID(), areaLabelItem.getPictureID());
        ArrayList<AreaLabelItem> areaLabelItems = record.getAreaLabel();
        ArrayList<AreaLabelItem> result = new ArrayList<>();
        for (AreaLabelItem temp : areaLabelItems) {
            if (temp.getItemID() == areaLabelItem.getItemID()) {
                result.add(areaLabelItem);
            } else {
                result.add(temp);
            }
        }
        record.setAreaLabel(result);
        modifyRecord(record);
    }

    @Override
    public void modifyCicleItem(CircleLabelItem circleLabelItem) {
        Record record = getRecordPrecisely(circleLabelItem.getUserID(), circleLabelItem.getTaskID(), circleLabelItem.getPictureID());
        ArrayList<CircleLabelItem> circleLabelItems = record.getCircleLabel();
        ArrayList<CircleLabelItem> result = new ArrayList<>();
        for (CircleLabelItem temp : circleLabelItems) {
            if (temp.getItemID() == circleLabelItem.getItemID()) {
                result.add(circleLabelItem);
            } else {
                result.add(temp);
            }
        }
        record.setCircleLabel(result);
        modifyRecord(record);
    }

    @Override
    public void insertAreaItem(AreaLabelItem areaLabelItem) {
        Record record = getRecordPrecisely(areaLabelItem.getUserID(), areaLabelItem.getTaskID(), areaLabelItem.getPictureID());
        ArrayList<AreaLabelItem> areaLabelItems = record.getAreaLabel();
        areaLabelItems.add(areaLabelItem);
        record.setAreaLabel(areaLabelItems);
        modifyRecord(record);
    }

    @Override
    public void insertCircleItem(CircleLabelItem circleLabelItem) {
        Record record = getRecordPrecisely(circleLabelItem.getUserID(), circleLabelItem.getTaskID(), circleLabelItem.getPictureID());
        ArrayList<CircleLabelItem> circleLabelItems = record.getCircleLabel();
        circleLabelItems.add(circleLabelItem);
        record.setCircleLabel(circleLabelItems);
        modifyRecord(record);
    }

    @Override
    public void deleteAreaItem(AreaLabelItem areaLabelItem) {
        Record record = getRecordPrecisely(areaLabelItem.getUserID(), areaLabelItem.getTaskID(), areaLabelItem.getPictureID());
        ArrayList<AreaLabelItem> areaLabelItems = record.getAreaLabel();
        ArrayList<AreaLabelItem> result = new ArrayList<>();
        for (AreaLabelItem temp : areaLabelItems) {
            if (temp.getItemID() == areaLabelItem.getItemID()) {
            } else {
                result.add(temp);
            }
        }
        record.setAreaLabel(result);
        modifyRecord(record);
    }

    @Override
    public void deleteCircleItem(CircleLabelItem circleLabelItem) {
        Record record = getRecordPrecisely(circleLabelItem.getUserID(), circleLabelItem.getTaskID(), circleLabelItem.getPictureID());
        ArrayList<CircleLabelItem> circleLabelItems = record.getCircleLabel();
        ArrayList<CircleLabelItem> result = new ArrayList<>();
        for (CircleLabelItem temp : circleLabelItems) {
            if (temp.getItemID() == circleLabelItem.getItemID()) {
            } else {
                result.add(temp);
            }
        }
        record.setCircleLabel(result);
        modifyRecord(record);
    }


    @Override
    public boolean taskFinished(String userID, String taskID) {

        Task task = new TaskData().getTask(taskID);
        int type = task.getType();
        List<Record> records = queryRecordByTaskID_UserID_TaskType(userID, taskID, type);
        if (records.size() == task.getPictures().size()) {
            new TaskData().finishTask(userID, taskID);
            return true;
        }
        return false;
    }

    @Override
    public List<Record> queryRecordByTaskID_UserID_TaskType(String userID, String taskID, int type) {
        ArrayList<Record> records = getAllRecords();
        ArrayList<Record> result = new ArrayList<>();
        for (Record temp : records) {
            if (temp.getUserID().equals(userID) && temp.getTaskID().equals(taskID)) {
                if(type==0){
                    if((!temp.getOverallTitle().equals(""))||(!temp.getOverallDescription().equals(""))){
                        result.add(temp);
                    }
                }else if(type==1){
                    if(!temp.getAreaLabel().isEmpty()){
                        result.add(temp);
                    }
                }else if(type==2) {
                    if (!temp.getCircleLabel().isEmpty()) {
                        result.add(temp);
                    }
                }
            }
        }
        return result;
    }


    @Override
    public void modifyOverall(String taskID, String userID, String pictureID, String label, String description) {
        Record record = getRecordPrecisely(userID, taskID, pictureID);
        record.setOverallTitle(label);
        record.setOverallDescription(description);
        modifyRecord(record);
    }

    @Override
    public void modifyProperty(String taskID, String userID, String pictureID, int itemID, String label, String description) {
        Record record = getRecordPrecisely(userID, taskID, pictureID);
        Task task = new TaskData().getTask(taskID);
        if (task.getType() == 1) {  //区域标注
            ArrayList<AreaLabelItem> areaLabelItems = record.getAreaLabel();
            ArrayList<AreaLabelItem> result = new ArrayList<>();
            for (AreaLabelItem areaLabelItem : areaLabelItems) {
                if (areaLabelItem.getItemID() == itemID) {
                    areaLabelItem.setLabel(label);
                    areaLabelItem.setDescription(description);
                }
                result.add(areaLabelItem);
            }
            record.setAreaLabel(result);
            modifyRecord(record);
        } else { //局部标注
            ArrayList<CircleLabelItem> circleLabelItems = record.getCircleLabel();
            ArrayList<CircleLabelItem> result = new ArrayList<>();
            for (CircleLabelItem circleLabelItem : circleLabelItems) {
                if (circleLabelItem.getItemID() == itemID) {
                    circleLabelItem.setLabel(label);
                    circleLabelItem.setDescription(description);
                }
                result.add(circleLabelItem);
            }
            record.setCircleLabel(result);
            modifyRecord(record);
        }
    }


    private ArrayList<Record> getAllRecords() {
        return new FileReader().getAllItems("records");
    }

    public Record getRecordPrecisely(String userID, String taskID, String pictureID) {
        List<Record> records = queryRecordByTaskID_UserID(userID, taskID);

        for (Record temp : records) if (temp.getUrl().equals(pictureID)) return temp;
        System.out.println("空指针异常可能是因为在TaskData的getTask方法中返回了null！");
        return null;
    }


}
