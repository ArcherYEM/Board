package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int join(User user) {
        String SQL = "INSERT INTO user (userID, userPassword, userName, userGender, userEmail)"
        		+ " VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // ID or Email 중복
    }

    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM user WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
            	if((rs.getString(1).equals(userPassword))) {
            		return 1;
            	} else {
            		return 0;
            	}
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; // 로그인 실패
    }
    
    public String name(String userID) {
    	String SQL = "SELECT userName FROM USER WHERE userID = ?";
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, userID);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getString("userName");
    		}
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return "비회원";
    }
    
    public User getUser(String userID) {
		String SQL = "SELECT * FROM user WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
    
    public String findID(String userName, String userEmail) {
    	String SQL = "SELECT userID FROM user WHERE userName = ? AND userEmail = ?";
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, userName);
    		pstmt.setString(2, userEmail);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getString("userID");
    		} else {
    			System.out.println("DAO 클래스의 rs : " + rs);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return null; // findID Error
    }
    
    public String findPW(String userID, String userName, String userEmail) {
    	String SQL = "SELECT userPassword FROM user WHERE userID = ? AND userName = ? AND userEmail = ?";
    	try {
    		pstmt = conn.prepareStatement(SQL);
    		pstmt.setString(1, userID);
    		pstmt.setString(2, userName);
    		pstmt.setString(3, userEmail);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			return rs.getString("userPassword");
    		} else {
    			System.out.println("DAO 클래스의 rs : " + rs);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	return null; // findPW Error
    }

}
