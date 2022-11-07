package employee.crud.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static final String dbUrl = "jdbc:mysql://localhost:3306/employee_db";
	public static final String dbUserName = "root";
	public static final String dbPassword= "M123456789!v";
	
public static Connection getConnection() {
	System.out.println("Start connection.. " );//Logger : Log4j 
	try {
		//Load MySql JDBC Driver 
		Class.forName("com.mysql.jdbc.Driver");
		//Open Connection
		connection = DriverManager.getConnection(dbUrl,dbUserName,dbPassword);
		if(connection != null) {
			System.out.println("Connected !");
			return connection;
		}
		else {
			System.out.println("Connection issue !");
			return null;
		}
	}catch(Exception e) {
		System.out.println("Exception DB Connection==>> " + e.getMessage());
		e.printStackTrace();
		return null;
	}
}
public static Connection connection = getConnection();
public static void main(String[] args) {
	System.out.println(DBConnection.connection);
}
}
