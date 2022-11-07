<%@page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="lang" value="${pageContext.request.locale.language}" />

<html lang="en">
	<head>	
		<title>Servlet, JSP, JDBC and MVC Example</title>
		
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">		
		<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/employee.css">
		
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
		<script src="<%=request.getContextPath()%>/js/employee.js"></script>
		
		<script>
			var app = angular.module('employeeApp', []);
			
			app.controller('employeeCtrl', function($scope) 
			{
				$scope.updateEmployee = function(employeeId)
				{
					var employeeDetails = '';					
					$.ajax
					(
		  				{
		  					url : '/employee-crud-app/get',
		  					async : false,
		  					dataType : "html",
		  					type : "POST",
		  					data : {"employeeId" : employeeId},
		  					success : function(data, textStatus, jqXHR) 
		  					{
		  						if(data != ""){employeeDetails = data;} 				 
		  						else {employeeDetails = '';}		  						
		  					},
		  					error : function(jqXHR, textStatus, errorThrown) 
		  					{
		  						console.log("something went wrong==>", errorThrown);
		  						employeeDetails = '';
		  						alert('exception, errorThrown==>' + errorThrown);
		  					}
		  				}
					);
					
					var employeeParsed = JSON.parse(employeeDetails);
					console.log('employeeDetails' + employeeParsed.name);

					$scope.employee = employeeParsed;
					console.log('$scope.employee' + $scope.employee.name);
					
					return employeeParsed;
				}
			});
		
			$(document).ready(function()
			{
				// Activate tooltip
				$('[data-toggle="tooltip"]').tooltip();
				
				// Select/Deselect checkboxes
				var checkbox = $('table tbody input[type="checkbox"]');
				$("#selectAll").click(function()
				{
					if(this.checked)
					{
						checkbox.each(function()
						{
							this.checked = true;
						});
					} 
					else
					{
						checkbox.each(function()
						{
							this.checked = false;                        
						});
					} 
				});
				
				checkbox.click(function()
				{
					if(!this.checked)
					{
						$("#selectAll").prop("checked", false);
					}
				});
	
				$('#deleteBtn').click
				(
					function()
					{
				  		var deletedEmployees = [];
				  		$("input:checkbox[class='employeeCheck']:checked").each(function(){    
				  			deletedEmployees.push($(this).val());    		
				  		});
				  		
				  		deletedEmployees = deletedEmployees.join(",")
				  		var employeeIds = deletedEmployees.toString();			  		
		
				  		$.ajax(
		  				{
		  					url : '/employee-crud-app/delete',
		  					async : false,
		  					dataType : "html",
		  					type : "POST",
		  					data : {"employeeIds" : employeeIds},
		  					success : function(data, textStatus, jqXHR) 
		  					{
		  						if(data != ""){response = data;} 				 
		  						else {response = '';}	  						
		  						window.location.href = '/employee-crud-app/';
		  					},
		  					error : function(jqXHR, textStatus, errorThrown) 
		  					{
		  						console.log("something went wrong==>", errorThrown);
		  						response = '';
		  						alert('exception, errorThrown==>' + errorThrown);
		  					}
		  				});
					}
				);
			});
	
			function toggleCheckBox(employeeId)
			{			
			    $("#employee"+employeeId).prop('checked', true);
			}
		</script>
	</head>
	<body ng-app="employeeApp" ng-controller="employeeCtrl">
		<div class="container">
			<div class="table-wrapper">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-6">
							<h2>
								Manage <b>Employees</b>
							</h2>
						</div>
						<div class="col-sm-6">
							<a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal">
								<i class="material-icons">&#xE147;</i> 
								<span>Add New Employee</span>
								</a> 
							<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal">
								<i class="material-icons">&#xE15C;</i> <span>Delete</span>
							</a>
						</div>
					</div>
				</div>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>
								<span class="custom-checkbox"> 
									<input type="checkbox" id="selectAll"> 
									<label for="selectAll"></label>
								</span>
							</th>
							<th>Name</th>
							<th>Email</th>
							<th>Address</th>
							<th>Phone</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="employee" items="${employees}" begin="0">
							<tr>
								<td>
									<span class="custom-checkbox"> 
										<input 
										type="checkbox" 
										name="employee${employee.id}" 
										id="employee${employee.id}" 
										class="employeeCheck" 
										value="${employee.id}">
										<label for="${employee.id}"></label>
									</span>
								</td>
								<td>${employee.name}</td>
								<td>${employee.email}</td>
								<td>${employee.address}</td>
								<td>${employee.phone}</td>
								<td>
									<a href="#editEmployeeModal" ng-click="updateEmployee(${employee.id})" class="edit" data-toggle="modal">
										<i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
									</a> 
									<a href="#deleteEmployeeModal" onclick="toggleCheckBox(${employee.id})" class="delete" data-toggle="modal">
										<i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<!-- Edit Modal HTML -->
		<jsp:include page="addEmployee.jsp"></jsp:include>
		
		<!-- Update Modal HTML -->
		<jsp:include page="updateEmployee.jsp"></jsp:include>
		
		<!-- Delete Modal HTML -->
		<jsp:include page="deleteEmployee.jsp"></jsp:include>
	</body>
</html>