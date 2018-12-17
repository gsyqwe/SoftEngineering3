package Model;

import java.io.Serializable;

public class User implements Serializable{
    private String userId;
    private int userType;  //0管理员 1标注者 2发布者
    private String password;


    public User(String userId, int userType, String password) {
        this.userId = userId;
        this.userType = userType;
        this.password = password;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
