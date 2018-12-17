package Data;


import Model.Record;
import Model.Task;
import Model.TaskStatusRecord;
import Model.User;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;

public class FileReader {

    public ArrayList getAllItems(String type) {

        ArrayList pos= new ArrayList<>();
        File file=new File("fileFBR//ser//"+type+".ser");
        if(!file.exists()){
            try {
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return pos;
        }
        try {
            FileInputStream filestream=new FileInputStream("fileFBR//ser//"+type+".ser");
            if(filestream.available()>0){
                ObjectInputStream os=new ObjectInputStream(filestream);
                if(type.equals("users")){
                    while(filestream.available()>0) {
                        User temp=(User)os.readObject();
                        pos.add(temp);
                    }
                }else if(type.equals("tasks")){
                    while (filestream.available() > 0) {
                        Task temp = (Task) os.readObject();
                        pos.add(temp);
                    }
                } else if (type.equals("taskStatus")) {
                    while (filestream.available() > 0) {
                        TaskStatusRecord temp = (TaskStatusRecord) os.readObject();
                        pos.add(temp);
                    }
                } else if (type.equals("records")) {
                    while (filestream.available() > 0) {
                        Record temp = (Record) os.readObject();
                        pos.add(temp);
                    }
                } else if (type.equals("")) {       //这里按需要添加

                }
                filestream.close();
                os.close();
            }

        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return pos;
    }


    public void printSome(){
        try {
            FileInputStream fileInputStream = new FileInputStream("D://tomcat//apache-tomcat-7.0.85//bin//fileFBR//ser//users.ser");
            System.out.println(fileInputStream);
                ObjectInputStream objectInputStream = new ObjectInputStream(fileInputStream);
                while (fileInputStream.available() > 0) {
                    Model.User temp = (Model.User) objectInputStream.readObject();
                    System.out.println(temp.getUserId() + " " + temp.getPassword());
                }
        } catch (Exception e) {
            e.printStackTrace();
        }



    }

    public static void main(String[] args) {
        FileReader fileReader = new FileReader();
        fileReader.printSome();
    }
}
