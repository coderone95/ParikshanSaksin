<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book</title>
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
<style type="text/css">
.errorDiv {
	color: red;
}
.successmsg {
	color:green;
}
</style>
</head>
<body>
	<div class="container">
		<s:form action="addBook" method="post" cssClass="form-horizontal">
			<fieldset>

				<!-- Form Name -->
				<legend>Add Book</legend>
				<s:if test="hasActionMessages()">
					<div class="successmsg">
						<s:actionmessage />	
					</div>
				</s:if>
				<%-- hasActionErrors() method is defined in ActionSupport --%>
				<s:if test="hasActionErrors()">
					<div class="errorDiv">
						<s:actionerror />
					</div>
				</s:if>

				<!-- Text input-->
				<div class="form-group">

					<div class="col-md-4">
						<s:textfield name="name" label="Book Name"
							placeholder="Enter Book Name" cssClass="form-control input-md"></s:textfield>

					</div>
				</div>

				<!-- Text input-->
				<div class="form-group">

					<div class="col-md-4">
						<s:textfield name="author" label="Author"
							placeholder="Enter Author Name" cssClass="form-control input-md"></s:textfield>

					</div>
				</div>

				<!-- Text input-->
				<div class="form-group">

					<div class="col-md-4">
						<s:textfield name="price" label="Price" placeholder="Enter Price"
							cssClass="form-control input-md"></s:textfield>

					</div>
				</div>

				<!-- Text input-->
				<div class="form-group">

					<div class="col-md-4">
						<s:textfield id="quantity" name="quantity" label="Quantity"
							placeholder="Enter Quantity" cssClass="form-control input-md"></s:textfield>

					</div>
				</div>
				<!-- Button -->
				<div class="form-group">

					<div class="col-md-4">
						<s:submit type="submit" value="Add"
							cssClass="btn btn-primary"></s:submit>
					</div>
				</div>


				<!-- << Go Back -->
				<div class="form-group">
					<div class="col-md-4">
						<a href="menu" id="goback" class="btn btn-warning">&lt;&lt; Go
							Back</a>
					</div>
				</div>

			</fieldset>
		</s:form>

	</div>
</body>
</html>