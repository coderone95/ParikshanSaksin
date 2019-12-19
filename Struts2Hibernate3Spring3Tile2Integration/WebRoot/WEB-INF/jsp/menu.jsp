<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib prefix="s" uri = "/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Library Menu</title>
<link rel="stylesheet" href="style.css">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 	<div>
		<a href="logout" class="btn btn-warning">Logout </a>
	</div> -->
	<h2 align="center">Menu Page</h2>

	<table align="center">
		<tbody>
			<tr>
				<td><s:form action="FetchRecords" method="POST" target="_blank">
						<button type="submit" class="btn btn-primary" >Show Books</button>
					</s:form></td>
				<br>
				<td><a href="addpage" class="btn btn-primary">Add</a></td>
				<td><a href="updatepage" class="btn btn-primary">Update</a></td>
				<td><a href="deletepage" class="btn btn-primary">Delete</a></td>
			</tr>
		</tbody>
	</table>

</body>
</html>