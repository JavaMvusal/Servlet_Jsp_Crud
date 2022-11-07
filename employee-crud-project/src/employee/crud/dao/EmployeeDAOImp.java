package employee.crud.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import employee.crud.beans.Employee;
import employee.crud.db.DBConnection;

public class EmployeeDAOImp implements EmployeeDAO{
	private static Connection connection = DBConnection.connection;
	@Override
	public boolean addEmployee(Employee employee) {
		System.out.println("Start add employee");
		try {
			String insertStatement = "INSERT INTO employee_db.employee (name,email,phone,address) VALUES(?,?,?,?)";
			PreparedStatement preparedStatement = connection.prepareStatement(insertStatement);
			preparedStatement.setString(1, employee.getName());
			preparedStatement.setString(2,employee.getEmail());
			preparedStatement.setString(3, employee.getPhone());
			preparedStatement.setString(4, employee.getAddress());
			int result = preparedStatement.executeUpdate();
			return result == 1 ? true : false;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}

	@Override
	public boolean updateEmployee(Employee employee) {
		System.out.println("Start update employee");
		try {
			String updateStatement = "UPDATE employee_db.employee set NAME = ?,email = ?,phone = ?,address=? WHERE ID = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(updateStatement);
			preparedStatement.setString(1, employee.getName());
			preparedStatement.setString(2,employee.getEmail());
			preparedStatement.setString(3, employee.getPhone());
			preparedStatement.setString(4, employee.getAddress());
			preparedStatement.setInt(5, employee.getId());
			int result = preparedStatement.executeUpdate();
			return result == 1 ? true : false;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean deleteEmployee(int employeeId) {
		System.out.println("Start delete employee");
		try {
			
			String deleteStatement = "DELETE FROM employee_db.employee WHERE ID = ?";
			PreparedStatement preparedStatement = connection.prepareStatement(deleteStatement);
			preparedStatement.setInt(1, employeeId);
		int result = preparedStatement.executeUpdate();
			return result == 1 ? true : false;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	@Override
	public List<Employee> getAllEmployees() {
		System.out.println("Start Select All Employees");
		try {
			
			String selectStatement = "SELECT * FROM employee_db.employee;";
			PreparedStatement preparedStatement = connection.prepareStatement(selectStatement);
			
		ResultSet result = preparedStatement.executeQuery();
		List<Employee> employees = new ArrayList<Employee>();
		while(result.next()) {
			Employee employee = new Employee();
			employee.setId(result.getInt("id"));
			employee.setName(result.getString("name"));
			employee.setEmail(result.getString("email"));
			employee.setPhone(result.getString("phone"));
			employee.setAddress(result.getString("address"));
			employees.add(employee);
		}
			return employees;
		}catch(Exception e) {
			e.printStackTrace();
		return null;
		}
	}

	@Override
	public Employee getEmployee(int employeeId) {
		System.out.println("Start Select Employee");
		try {
			
			String selectStatement = "SELECT * FROM employee_db.employee WHERE ID=?";
			PreparedStatement preparedStatement = connection.prepareStatement(selectStatement);
			preparedStatement.setInt(1,employeeId);
		ResultSet result = preparedStatement.executeQuery();
		Employee employee = new Employee();
		while(result.next()) {
			
			employee.setId(result.getInt("id"));
			employee.setName(result.getString("name"));
			employee.setEmail(result.getString("email"));
			employee.setPhone(result.getString("phone"));
			employee.setAddress(result.getString("address"));
			
		}
			return employee;
		}catch(Exception e) {
			e.printStackTrace();
		return null;
		}
	}
//	public static void main(String[] args) {
//		EmployeeDAOImp employeeDAOImp = new EmployeeDAOImp();
//		Employee employee = new Employee();
//		employee.setId(2);
//		employee.setName("Yasin");
//		employee.setEmail("java.yasin.ismayilov@gmail.com");
//		employee.setAddress("Baku");
//		employee.setPhone("0558966470");
//		//System.out.println(employeeDAOImp.addEmployee(employee));//insert
//		//System.out.println(employeeDAOImp.updateEmployee(employee));//update
//		//System.out.println(employeeDAOImp.deleteEmployee(2));//delete
//		//System.out.println(employeeDAOImp.getAllEmployees());//Select All Employee
//		System.out.println(employeeDAOImp.getEmployee(1));
//	}
	

}
