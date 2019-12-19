<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ExamsVilla</title>
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

<link rel="stylesheet" href="./assets/css/common.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.slim.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" />
<script src="./assets/js/login_home.js"></script>
<style type="text/css">
.errorDiv {
	color: red;
}
.error-msg {
	color:red
}
</style>
</head>
<body>

<div class="container register">
                <div class="row">
                    <div class="col-md-3 register-left">
                        <img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
                        <h3>Welcome</h3>
                        <p>You are 30 seconds away from earning your own money!</p>
                        <!-- <input type="submit" name="" value="Login"/> --><br/>
                    </div>
                    <div class="col-md-9 register-right">
                        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">SignUp</a>
                            </li>
                        </ul>
                        <div class="text-center">
                                	<div class="error-msg">
                                		<s:if test='%{errorMessagesList != null}'>
                                			<s:iterator value="errorMessagesList">
                                				<b style="background: #eeff00; margin-bottom:1rem;"><s:property value="errorMsg"/></b>
                                			<br/>
                                			</s:iterator>
                                		</s:if>
                                	</div>
                                	<div class="error-msg">
                                		<s:if test='%{successMessageList != null}'>
                                			<s:iterator value="successMessageList">
                                				<b style="background: #eeff00; margin-bottom:1rem;"><s:property value="successMsg"/></b>
                                			<br/>
                                			</s:iterator>
                                		</s:if>
                                	</div>
                                </div>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <h3 class="register-heading">Login Here</h3>
                                
                                <form class="form-signin" action="login" method="post">
	                                <div class="row register-form">
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <input type="text" class="form-control" id="login_id" name="email_id" placeholder="Enter username *"  />
	                                        </div>
	                                    </div>
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password *"/>
	                                        </div>
 	                                        <input type="submit" class="btnRegister"  value="SignIn"/>
	                                    </div>
	                                </div>
	                            </form>
                            </div>
                            <div class="tab-pane fade show" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <h3  class="register-heading">Sign Up here</h3>
                                <form class="form-signup" action="register" method="post">
	                                <div class="row register-form">
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter your Name *"  />
	                                        </div>
	                                        <div class="form-group">
	                                            <input type="email" class="form-control" id="email" name="email_id" placeholder="Enter Email address *" />
	                                        </div>
	                                        <div class="form-group">
	                                            <input type="text" maxlength="10" minlength="10"  id="phone" name="phone_number" class="form-control" placeholder="Phone *" />
	                                        </div>
	                                    </div>
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <input type="password" class="form-control" id="pwd" name="password" placeholder="Password *" />
	                                        </div>
	                                        <div class="form-group">
	                                            <input type="password" class="form-control" id="cpwd" name="cpassword" placeholder="Confirm Password *" />
	                                        </div>
	                                        <input type="submit" class="btnRegister"  value="Register"/>
	                                    </div>
	                                </div>
	                           </form> 
                            </div>
                        </div>
                    </div>
                </div>

            </div>
</body>
</html>