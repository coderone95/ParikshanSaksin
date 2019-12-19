<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Candidate : Test Authentication</title>
<!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Inconsolata&display=swap" rel="stylesheet">
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<script src="./assets/js/core/popper.min.js"></script>
<script src="./assets/js/core/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
<script>

		function clearSessionValues(){
			sessionStorage.clear();
			// similar behavior as clicking on a link
			window.location.href = "logout";
		}
</script>
<style>
		/* .box {
	    width: 500px;
	    margin: 200px 0;
	}
	
	.shape1{
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    float: left;
	    margin-right: -50px;
	}
	.shape2 {
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    margin-top: -30px;
	    float: left;
	}
	.shape3 {
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    margin-top: -30px;
	    float: left;
	    margin-left: -31px;
	}
	.shape4 {
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    margin-top: -25px;
	    float: left;
	    margin-left: -32px;
	}
	.shape5 {
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    float: left;
	    margin-right: -48px;
	    margin-left: -32px;
	    margin-top: -30px;
	}
	.shape6 {
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    float: left;
	    margin-right: -20px;
	    margin-top: -35px;
	}
	.shape7 {
	    position: relative;
	    height: 150px;
	    width: 150px;
	    background-color: #0074d9;
	    border-radius: 80px;
	    float: left;
	    margin-right: -20px;
	    margin-top: -57px;
	}
	.float {
	    position: absolute;
	    z-index: 2;
	}
	
	.form {
	    margin-left: 145px;
	}
	
	.test-auth-form{
		font-family: 'Inconsolata', monospace;
	}
	.profile-card-header{
		background-color:#142d40;
		color:#ffffff;
	}
	 */
	/* New Style for Forms */
		.sign-out{
		float:right;
		margin-top: 1rem;
	}
		body,
		html {
			margin: 0;
			padding: 0;
			height: 100%;
			/* background: #60a3bc !important; */
		}
		.user_card {
			height: 400px;
			width: 350px;
			margin-top: auto;
			margin-bottom: auto;
			/* background: #f39c12; */
			/* background: #091279; */
			background: -webkit-linear-gradient(left, #3931af, #00c6ff);
			position: relative;
			display: flex;
			justify-content: center;
			flex-direction: column;
			padding: 10px;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-moz-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			border-radius: 5px;

		}
		.brand_logo_container {
			position: absolute;
			height: 170px;
			width: 170px;
			top: -75px;
			border-radius: 50%;
			/* background: #60a3bc; */
			
			padding: 10px;
			text-align: center;
		}
		.brand_logo {
			height: 150px;
			width: 150px;
			border-radius: 50%;
			/* border: 2px solid #1c2c69; */
			border: 2px solid #d3de32;
		}
		.form_container {
			margin-top: 30px;
		}
		.login_btn {
			width: 100%;
			/* background: #c0392b !important; */
			/* background: #374fc7 !important; */
			background: -webkit-linear-gradient(left, #3931af, #00c6ff);
			color: white !important;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-moz-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		}
		.login_btn:focus {
			box-shadow: none !important;
			outline: 0px !important;
		}
		.login_container {
			padding: 0 2rem;
		}
		.input-group-text {
			/* background: #c0392b !important; */
			background: #374fc7 !important;
			color: white !important;
			border: 0 !important;
			border-radius: 0.25rem 0 0 0.25rem !important;
		}
		.input_user,
		.input_pass:focus {
			box-shadow: none !important;
			outline: 0px !important;
		}
		.custom-checkbox .custom-control-input:checked~.custom-control-label::before {
			background-color: #c0392b !important;
		}
		.input-group {
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-moz-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		}
		.err { 
			color : #ff0000; 
			text-align: center;
	    	padding: 0.2rem;
    	}
</style>
</head>
<body>
	
<!-- <div class="container">
		<div class="sign-out">
             <a onclick="clearSessionValues();" href="#" class="btn btn-outline-primary btn-md"><i class="fa fa-sign-out"></i>Log out</a>
         </div>
         <div class="container">
	        <div id="login-row" class="row justify-content-center align-items-center">
	            <div id="login-column" class="col-md-6">
	                <div class="box">
	                    <div class="shape1"></div>
	                    <div class="shape2"></div>
	                    <div class="shape3"></div>
	                    <div class="shape4"></div>
	                    <div class="shape5"></div>
	                    <div class="shape6"></div>
	                    <div class="shape7"></div>
	                    <div class="float">
	                        <form class="form" method="post" id="test-auth-form" action="authenticateTest">
	                        	<div class="text-center">
	                                <h4 class="text-white">Test Authentication</h4>
	                            </div>
	                            <div class="form-group">
	                                <label for="username" class="text-white"></label><br>
	                                <input type="text" name="testAuthBean.testKey" id="test-key" class="form-control" placeholder="Enter Test Key">
	                            </div>
	                            <div class="form-group">
	                                <label for="password" class="text-white"></label><br>
	                                <input type="text" name="testAuthBean.accessKey" id="access-key" class="form-control" placeholder="Enter Access Key">
	                            </div>
	                            <div class="form-group">
	                                <input type="submit" name="submit" class="btn btn-warning" value="Go">
	                            </div>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div>
	     </div>
    </div> -->
 <div class="container h-100">
 		<div class="sign-out">
             <a onclick="clearSessionValues();" href="#" class="btn btn-outline-primary btn-md"><i class="fas fa-sign-out-alt"></i>Log out</a>
         </div>
		<div class="d-flex justify-content-center h-100">
			<div class="user_card">
				<div class="d-flex justify-content-center">
					<div class="brand_logo_container">
						<img src="./assets/images/test-auth-brand.png" class="brand_logo" alt="Logo">
					</div>
				</div>
				<div class="error-div">
            			<div class="err"><s:property value="error" /></div>
            	</div>
				<div class="d-flex justify-content-center form_container">
					<form class="form" method="post" id="test-auth-form" action="authenticateTest">
						<div class="input-group mb-3">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input type="text" name="testAuthBean.testKey" id="test-key" class="form-control input_user" placeholder="Enter test key">
						</div>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" name="testAuthBean.accessKey" id="access-key" class="form-control input_pass" placeholder="Enter access key">
						</div>
						
							<div class="d-flex justify-content-center mt-3 login_container text-uppercase">
				 	<button type="submit" class="btn login_btn">Authenticate</button>
				   </div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>