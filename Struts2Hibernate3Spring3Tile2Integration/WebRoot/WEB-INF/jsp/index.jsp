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
<script
	src="./assets/js/core/jquery.min.js"></script>

<script>
	$(document).ready(function(){
		$('#registerBtn').on('click',function(){
			if(validateForm()){
				$('#registerUserForm').submit();				
			}
		});
	});
	function validateForm(){
		var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
		var numbers = /^[-+]?[0-9]+$/;
		if($('#name').val() == '' || $('#name').val() == null){
			alert('Please enter name');
			return false;
		}else if($('#email').val() == '' || $('#email').val() == null){
			alert('Please enter an email');
			return false;
		}else if( $('#email').val() != null && !re.test($('#email').val())){
			alert('Please enter valid email address');
			return false;
		}else if($('#phone').val() == '' || $('#phone').val() == null){
			alert('Please enter phone');
			return false;
		}else if($('#pwd').val() == '' || $('#pwd').val() == null ){
			alert('Please enter password');
			return false;
		}else if($('#cpwd').val() == '' || $('#cpwd').val() == null ){
			alert('Please confirm password');
			return false;
		}else if($('#pwd').val() != null && $('#pwd').val() != '' ){ 
			if($('#pwd').val() !=  $('#cpwd').val() ){
				alert('Password is not matched');
				return false;
			}
		}else if($('#pwd').val() != '' || $('#cpwd').val() != ''){
			if($('#pwd').val().length < 5 ||  $('#cpwd').val().length < 5 ){
				alert('Password must be of min 5 length');
				return false;
			}
		}else if($('#phone').val() != null && $('#phone').val() != ''){
			if(! $('#phone').val().match(numbers)){
				alert('Please enter numbers only');
				return false;
			}else if($('#phone').val().length < 10 && $('#phone').val().length > 12 ){
				alert('Number should be between 10 and 12');
				return false;
			}			
		}
		return true;
		
	}
</script>
<style type="text/css">
.errorDiv {
	color: red;
}
.error-msg {
	color:red
}
.success-msg{
	color: #008000;
}
.error-msg b{
	margin-bottom: 1rem;
    padding: 0.1rem;
    border: 1px solid red;
}
.success-msg b{
	margin-bottom: 1rem;
    padding: 0.1rem;
    border: 1px solid #008000;
}
.credits {
	padding: 2rem;
    margin-left: 46%;
    font-size: 0.8571em;
    line-height: 1.8;
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
                                				<b style="margin-bottom:1rem;"><s:property value="errorMsg"/></b>
                                			<br/>
                                			</s:iterator>
                                		</s:if>
                                	</div>
                                	<div class="success-msg">
                                		<s:if test='%{successMessageList != null}'>
                                			<s:iterator value="successMessageList">
                                				<b style="margin-bottom:1rem;"><s:property value="successMsg"/></b>
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
 	                                        <input type="submit" id="loginBtn" class="btnRegister"  value="SignIn"/>
	                                    </div>
	                                </div>
	                            </form>
                            </div>
                            <div class="tab-pane fade show" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <h3  class="register-heading">Sign Up here</h3>
                                <form class="form-signup" id="registerUserForm" action="registerUser" method="post">
	                                <div class="row register-form">
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <input type="text" class="form-control" id="name" name="userBean.name" placeholder="Enter your Name *" />
	                                        </div>
	                                        <div class="form-group">
	                                            <input type="email" class="form-control" id="email" name="userBean.email_id" placeholder="Enter Email address *" />
	                                        </div>
	                                        <div class="form-group">
	                                            <input type="number" maxlength="10" minlength="10"  id="phone" name="userBean.phone_number" class="form-control" placeholder="Phone *" />
	                                        </div>
	                                    </div>
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <input type="password" class="form-control" id="pwd" name="userBean.password" placeholder="Password *" />
	                                        </div>
	                                        <div class="form-group">
	                                            <input type="password" class="form-control" id="cpwd" name="userBean.cpassword" placeholder="Confirm Password *" />
	                                        </div>
	                                        <input type="hidden" name="userBean.user_type" value="CANDIDATE"/>
	                                        <input type="button" id="registerBtn" class="btnRegister"  value="Register"/>
	                                    </div>
	                                </div>
	                           </form> 
                            </div>
                        </div>
                    </div>
                </div>

            </div>
</body>
      <footer class="footer footer-black ">
        <div class="container-fluid">
          <div class="row">
            <div class="credits">
              <span class="copyright">
                ©
                <script>
                  document.write(new Date().getFullYear())
                </script> CodesVila
              </span>
            </div>
          </div>
        </div>
      </footer>
</html>