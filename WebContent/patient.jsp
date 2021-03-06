<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.predictive.DatabaseInfo"%>

<%
	String id = request.getParameter("userId");
	String driverName = "com.mysql.jdbc.Driver";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Patient Management</title>
<!-- Bootstrap core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/simple-sidebar.css" rel="stylesheet">
</head>
<body>
	<%
		String name = (String) session.getAttribute("username");
		
		if (name == null) {
			response.sendRedirect("login.jsp");
		}
	%>
	<div class="d-flex" id="wrapper">

		<!-- Sidebar -->
		<%@ include file = "template.jsp" %>
		<!-- /#sidebar-wrapper -->

		<!-- Page Content -->
			<div class="container-fluid">
				<h1 class="mt-4">List of Patient</h1>
				<form method="POST" action="searchresult.jsp">
					<input type="text"
							class="form-control" name="searchpatient" id="searchpatient"
							placeholder="Search by First Name">
							<br>
							<button class="btn btn-info" name ="submitsearch">Search</button>
							<button class="btn btn-info" formaction="chart.jsp" style="float: right;">See population</button>
				</form>
				<br>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">First Name</th>
							<th scope="col">Last Name</th>
							<th scope="col">Address</th>
							<th scope="col">Department</th>
							<th scope="col">Prescription</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<%
								try {
									Class.forName(driverName);
								} catch (ClassNotFoundException e) {
									e.printStackTrace();
								}

								Connection connection = null;
								Statement statement = null;
								ResultSet resultSet = null;
								int i = 1;

								try {
									connection = DriverManager.getConnection("jdbc:mysql://" + DatabaseInfo.DB_URL  + "/" + DatabaseInfo.DB_NAME + "", DatabaseInfo.DB_USERNAME, DatabaseInfo.DB_PASS);
									statement = connection.createStatement();
									String sql = "SELECT * FROM patient";

									resultSet = statement.executeQuery(sql);
									while (resultSet.next()) {
							%>
							<th scope="row">
								<%=resultSet.getString("patient_id")%>
							</th>
							<td><a href ='patient_profile.jsp?id=<%=resultSet.getString("patient_id")%>'><%=resultSet.getString("patient_firstname")%></a></td>
							<td><%=resultSet.getString("patient_lastname")%></td>
							<td><%=resultSet.getString("address")%></td>
							<td><%=resultSet.getString("department")%></td>
							<td><%=resultSet.getString("prescription")%></td>
							<td><a href='editpatient.jsp?id=<%=resultSet.getString("patient_id")%>'>Edit</a> | <a href='DeletePatient?id=<%=resultSet.getString("patient_id")%>'>Delete</a></td>
						</tr>
					</tbody>

					<%
						}

						} catch (Exception e) {
							e.printStackTrace();
						}
					%>
				</table>
				<div class="container-login100-form-btn">
					<button class="btn btn-primary" onclick="window.location='addpatient.jsp'">Add Patient</button>
				</div>
			</div>
		</div>
		<!-- /#page-content-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Menu Toggle Script -->
	<script>
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
	</script>

</body>
</html>