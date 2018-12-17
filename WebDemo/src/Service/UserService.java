package Service;

public interface UserService {
    /**
     * 登录是否成功
     * @param userID
     * @param passworld
     * @return
     */
    boolean login(String userID,String passworld);

    /**
     * 检查用户名是否存在
     * @param UserID
     * @return
     */
    boolean isExist(String UserID);

    /**
     * 新增一个用户
     * @param UserID
     * @param password
     * @return
     */
    boolean insertNewUser(String UserID,String password);
}
