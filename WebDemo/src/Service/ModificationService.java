package Service;


import Model.AreaLabelItem;
import Model.CircleLabelItem;
import Model.Record;

import java.util.List;

public interface ModificationService {


    void modifyRecord(Record record); //替换式更新record

    void deleteRecord(Record record);

    List<Record> queryRecordByTaskID_UserID(String userID, String taskID);

    void modifyAreaItem(AreaLabelItem areaLabelItem); //替换式更改某个区域标注及描述

    void modifyCicleItem(CircleLabelItem circleLabelItem); //替换式更改某个局部标注及描述

    void insertAreaItem(AreaLabelItem areaLabelItem);  //增量式添加一个区域标注及描述

    void insertCircleItem(CircleLabelItem circleLabelItem); //增量式添加一个局部标注及描述

    void deleteAreaItem(AreaLabelItem areaLabelItem); //删除一个区域标注

    void deleteCircleItem(CircleLabelItem circleLabelItem); //删除一个局部标注

    boolean taskFinished(String userID, String taskID); //查询某个任务是否已经被全部完成，完成则返回true且提交审核，否则返回false

    List<Record> queryRecordByTaskID_UserID_TaskType(String userID, String taskID, int type);

    void modifyOverall(String taskID, String userID, String pictureID, String label, String description); //替换式更改全局标注及描述的具体内容

    void modifyProperty(String taskID, String userID, String pictureID, int itemID, String label, String description); //替换式更改某个区别标注及描述或者局部标注及描述的具体内容



}