package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;

public class FileDAO {
	
	private Connection conn;
	private ResultSet rs;

	public FileDAO() {
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

}
