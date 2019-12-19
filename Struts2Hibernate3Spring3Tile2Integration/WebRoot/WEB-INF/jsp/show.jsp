<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show Books</title>
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
<style type="text/css">

.successmsg {
	color: green;
}
</style>
</head>
<body>
	<s:if test="hasActionMessages()">
					<div class="successmsg">
						<s:actionmessage />
					</div>
				</s:if>
	<s:if test = "books!=null">
	<!--Table-->
	<table id="tablePreview" class="table table-striped table-sm">
		<!--Table head-->
		<thead class="thead-dark">
			<tr>
				<th>Book ID</th>
				<th>Book Name</th>
				<th>Author</th>
				<th>Price</th>
				<th>Quantity</th>
			</tr>
		</thead>
		<!--Table head-->
		<!--Table body-->
		<tbody>
			<s:iterator value="books">
				<tr>
					<td><s:property value="id" /></td>
					<td><s:property value="name" /></td>
					<td><s:property value="author" /></td>
					<td><s:property value="price" /></td>
					<td><s:property value="quantity" /></td>
				</tr>
			</s:iterator>

		</tbody>
		<!--Table body-->
	</table>
	<!--Table-->
	</s:if>
</body>
</html>