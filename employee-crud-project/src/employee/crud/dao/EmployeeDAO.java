package employee.crud.dao;

import java.util.List;

import employee.crud.beans.Employee;

public interface EmployeeDAO {
//1-Insert
	public boolean addEmployee(Employee employee);

//2-Update
	public boolean updateEmployee(Employee employee);

//3-Delete
	public boolean deleteEmployee(int employeeId);

//4-Get All
	public List<Employee> getAllEmployees();
//5-Get  Single Employee
	public Employee getEmployee(int employeeId); 
}
