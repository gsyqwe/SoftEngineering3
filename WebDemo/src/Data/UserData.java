package Data;

import Model.User;
import Service.UserService;

import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;

public class UserData implements UserService {
    @Override
    public boolean login(String userID, String password) {   //前提条件：userID存在：先用isExist判断
        ArrayList<User> users = getAllUsers();
        for (User temp : users)
            if (temp.getUserId().equals(userID)) return temp.getPassword().equals(password);
        return false;
    }

    @Override
    public boolean isExist(String userID) {
        ArrayList<User> users = getAllUsers();
        for (User temp : users)
            if (temp.getUserId().equals(userID)) return true;
        return false;

    }

    @Override
    public boolean insertNewUser(String userID, String password) {

        ArrayList<User> users = getAllUsers();
        FileOutputStream fileOutputStream = null;
        try {
            fileOutputStream = new FileOutputStream("fileFBR//ser//users.ser");
            ObjectOutputStream objectOutputStream = new ObjectOutputStream(fileOutputStream);
            User user = new User(userID, 1, password);   //默认标注者
            users.add(user);

            for (User temp : users) objectOutputStream.writeObject(temp);
            objectOutputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;

    }

    private ArrayList<User> getAllUsers() {
//        User temp;
//        ArrayList<User> pos= new ArrayList<>();
//        File file=new File("fileFBR//ser//users.ser");
//        if(!file.exists()){
//            try {
//                file.createNewFile();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//            return pos;
//        }
//        try {
//            FileInputStream filestream=new FileInputStream("fileFBR//ser//users.ser");
//            if(filestream.available()>0){
//                ObjectInputStream os=new ObjectInputStream(filestream);
//                while(filestream.available()>0) {
//                    temp=(User)os.readObject();
//                    pos.add(temp);
//                }
//                os.close();
//            }
//
//        }catch(Exception ex) {
//            ex.printStackTrace();
//        }
//        return pos;
        return new FileReader().getAllItems("users");
    }

    public static void main(String[] args) {
        UserData userData = new UserData();
        userData.insertNewUser("HYHZ", "FBR");
    }
}
