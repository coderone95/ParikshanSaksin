<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Book</title>
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
.errorMessage,
.errorDiv {
	color: red;
}

.successmsg {
	color: green;
}
</style>
</head>
<body>
	<div class="container">
		<s:form action="deleteBook" cssClass="form-horizontal" method="post">
			<fieldset>

				<!-- Form Name -->
				<legend>Delete Book</legend>

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
						<s:textfield name="id" label="Book ID"
							placeholder="Enter the Book ID" cssClass="form-control input-md"></s:textfield>

					</div>
				</div>

				<!-- Button -->
				<div class="form-group">
					<div class="col-md-4">
						<s:submit value="Delete" cssClass="btn btn-primary"></s:submit>
					</div>
				</div>

			</fieldset>
		</s:form>
		<!-- Button -->
		<div class="form-group">
			<label class="col-md-4 control-label" for="checkid">Don't
				know?</label>
			<div class="col-md-4">
				<s:form action="FetchRecords" method="POST" target="_blank">
					<button type="submit" class="btn btn-danger" 
						>Check Here</button>
				</s:form>
			</div>
		</div>

		<!-- << Go Back -->
		<div class="form-group">
			<div class="col-md-4">
				<a href="menu" id="goback" class="btn btn-warning">&lt;&lt; Go
					Back</a>
			</div>
		</div>


	</div>
</body>
</html>