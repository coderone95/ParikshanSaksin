<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamsVilla : Register</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
/* $(document).ready(function(){
	$("#register").click(function() {
		var username = $("#uname").val();
		var password = 	$("#pwd").val();
		var cpassword = $("#cpwd").val();
		if(cpassword == "")
			alert("Please enter password");
	});
}); */
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.slim.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" />
<!-- <link rel="stylesheet" href="./assets/css/register.css" /> -->
<link rel="stylesheet" href="./assets/css/login_home.css" />

<style type="text/css">
.errorDiv {
	color: red;
}

.successmsg {
	color: green;
}
</style>

</head>
<body>
<!-- 	<div class="container"> -->
<%-- 		<s:form action="addUser123" method="post" cssClass="form-horizontal" onsubmit="return validateForm()" --%>
<%-- 			name="registerform"> --%>
<!-- 			<fieldset> -->

<!-- 				Form Name -->
<!-- 				<legend>Register Here </legend> -->

<!-- 				Text input -->
<!-- 				<div class="form-group"> -->
<!-- 					<label class="col-md-4 control-label" for="name"></label> -->
<!-- 					<div class="col-md-4"> -->
<%-- 						<s:textfield name="username" label="Username" id="uname" --%>
<%-- 							placeholder="Enter username" cssClass="form-control input-md"></s:textfield> --%>

<!-- 					</div> -->
<!-- 				</div> -->

<!-- 				Password input -->
<!-- 				<div class="form-group"> -->
<!-- 					<label class="col-md-4 control-label" for="password"></label> -->
<!-- 					<div class="col-md-4"> -->
<%-- 						<s:password name="password" label="Password" id="pwd" --%>
<%-- 							placeholder="Enter password" cssClass="form-control input-md"></s:password> --%>

<!-- 					</div> -->
<!-- 				</div> -->

<!-- 				Confirm Password input -->
<!-- 				<div class="form-group"> -->
<!-- 					<label class="col-md-4 control-label" for="password"></label> -->
<!-- 					<div class="col-md-4">  -->
<%-- 						<s:password name="cpassword" label="Confirm Password" id="cpwd" --%>
<%-- 							placeholder="Confirm password" cssClass="form-control input-md"></s:password> --%>

<!-- 					</div> -->
<!-- 				</div> -->

<%-- 				<s:if test="hasActionErrors()"> --%>
<!-- 					<div class="errorDiv"> -->
<%-- 						<s:actionerror /> --%>
<!-- 					</div> -->
<%-- 				</s:if> --%>
<%-- 				<s:if test="hasActionMessages()"> --%>
<!-- 					<div class="successmsg"> -->
<%-- 						<s:actionmessage /> --%>
<!-- 					</div> -->
<%-- 				</s:if> --%>
<!-- 				Button -->
<!-- 				<div class="form-group"> -->
<!-- 					<div class="col-md-4"> -->
<%-- 						<s:submit id="register" value="Register" --%>
<%-- 							cssClass="btn btn-primary"></s:submit> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</fieldset> -->
<%-- 		</s:form> --%>
<!-- 	</div> -->

<!-- 	<div class="form-class"> -->
<!-- 		<div class="col-md-4 "> -->
<!-- 			<a href="loginpage" class="btn btn-danger">Login here</a> -->
<!-- 		</div> -->
<!-- 	</div> -->



<div class="container">
		<div class="row">
			<div class="col-lg-10 col-xl-9 mx-auto">
				<div class="card card-signin flex-row my-5">
					<div class="card-img-left d-none d-md-flex">
						<!-- Background image for card set in CSS! -->
					</div>
					<div class="card-body">
						<h5 class="card-title text-center">Register</h5>
						<form class="form-signin" action="login" method="post">
							<div class="form-group">
								<input type="text" id="name" name="name" class="form-control"
									placeholder="Enter your name" required > 
							</div>

							<div class="form-group">
								<input type="password" id="password" name="password" class="form-control"
									placeholder="Password" required>
							</div>

							<button class="btn btn-lg btn-primary btn-block text-uppercase"
								type="submit">Login</button>
							
							<hr class="my-4">
							<a href="register" class="btn btn-lg btn-google btn-block text-uppercase">
								Sign up
							</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>