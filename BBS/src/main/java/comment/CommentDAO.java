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
	    String SQL = "SELECT bbsID, userID, content, date, commentAvailable, commentNo FROM comment WHERE bbsID = ? AND commentAvailable = 1";
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
	            comment.setCommentNo(rs.getInt("commentNo"));
	            list.add(comment);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public Comment getComment(int commentNo) {
	    String SQL = "SELECT * FROM comment WHERE commentNo = ?";
	    Comment comment = null; // 댓글 객체를 선언하고 초기화

	    try {
	        PreparedStatement pstmt = conn.prepareStatement(SQL);
	        pstmt.setInt(1, commentNo);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            // 결과셋으로부터 댓글 정보를 가져와서 Comment 객체에 설정
	            comment = new Comment();
	            comment.setBbsID(rs.getInt(1));
	            comment.setUserID(rs.getString(2));
	            comment.setContent(rs.getString(3));
	            comment.setDate(rs.getString(4));
	            comment.setCommentavailable(rs.getString(5));
	            comment.setCommentNo(rs.getInt(6));
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // 예외 정보를 콘솔에 출력
	    }

	    return comment; // 댓글 객체를 반환
	}
	
	public int deleteComment(int commentNo) {
		String SQL = "UPDATE comment SET commentAvailable = 0 WHERE commentNo = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  commentNo);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // database error
	}

}
