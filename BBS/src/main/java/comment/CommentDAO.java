package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {

	private Connection conn;
	private ResultSet rs;

	public CommentDAO() {
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

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // database error
	}

	public int addComment(int bbsID, String comment, String userID) {
		String SQL = "INSERT INTO comment (bbsID, userID, content) VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID); // 현재 bbsID 입력되게 수정해야함
			pstmt.setString(2, userID);
			pstmt.setString(3, comment);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<Comment> getList(int bbsID) {
	    String SQL = "SELECT bbsID, userID, content, date, commentAvailable FROM comment WHERE bbsID = ?";
	    ArrayList<Comment> list = new ArrayList<Comment>();
	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, bbsID);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Comment comment = new Comment();
	            comment.setBbsID(rs.getInt("bbsID"));
	            comment.setUserID(rs.getString("userID"));
	            comment.setContent(rs.getString("content"));
	            comment.setDate(rs.getString("date"));
	            comment.setCommentavailable(rs.getString("commentAvailable"));
	            list.add(comment);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

}
