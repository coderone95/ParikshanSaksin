<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!doctype html>
<html lang="en">
  <head>
    <title>Home : Parikshan Saksin</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            $('#login-tb').click();
            $('.nav-tb-li').on('click',function(){
                $('.nav-tb-li').removeClass('active');
                $(this).addClass('active');
            });
        });
    </script>
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
    <style>
        /*Font CDN*/

@import url(https://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic);

/*Font CDN*/


/*Global CSS*/

html,
body {
    font-family: 'Roboto', sans-serif;
    font-size: 20px;
    height: 100%;
}

a,
a:hover,
a:focus,
focus {
    outline: none !important;
    text-decoration: none;
    color: #fff;
}
.container{
    max-width:800px;
    width: 100%;
    
}
li,
ul {
    margin: 0;
    padding: 0;
}

/*Global CSS*/


/*Main CSS*/


/*Login Signup Page*/

.bg-image {
    /* background: url(http://jskrishna.com/work/merkury/images/background-login.jpg) no-repeat 0 0 / cover; */
    position: relative;
    width: 100%;
    height: 100vh; 
    display: table;
    max-width: 70%;
    margin-left: 50%;
    transform: translateX(-50%);
}

.login-header {
    display: inline-block;
    width: 100%;
    /* background: #0e1a35; */
    background: #ffffff;
}

.login-signup {
    display: table-cell;
    vertical-align: middle;
    width: 100%;
}

.login-logo img {
    cursor: pointer;
    max-width: 171px;
    padding: 23px 15px 22px;
    width: 100%;
}

.login-header .navbar-right {
    margin-right: 0px;
}

.login-header .nav-tabs > li.active > a,
.login-header .nav-tabs > li.active > a:focus,
.login-header .nav-tabs > li.active > a:hover {
    background-color: transparent;
    border: none;
    /* color: #fff; */
    color: #000000;
}

.login-header .nav-tabs > li > a {
    border: medium none;
    border-radius: 0;
    font-size: 14px;
    font-weight: 500;
    line-height: 48px;
    padding: 15px 30px;
    /* color: #fff; */
    color: #000000;
}

.login-header .nav-tabs {
    border-bottom: none;
}

.login-header .nav-tabs > li {
    margin-bottom: 0px;
}

.login-header .nav > li > a:focus,
.login-header .nav > li > a:hover {
    background: none;
    text-decoration: none;
}

.login-header .nav-tabs > li.active {
    border-bottom: 6px solid #236890;
}

.login-inner h1 {
    color: #8492af;
    /* color: #ffffff; */
    font-size: 35px;
    font-weight: 300;
    text-align: center;
    margin-top: 0;
}

.login-inner h1 span {
    color: #236890;
}

.login-form {
    text-align: center;
}

.login-form input {
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
    border-color: -moz-use-text-color -moz-use-text-color #d4d9e3;
    border-image: none;
    border-style: none none solid;
    border-width: medium medium 1px;
    font-size: 13px;
    font-weight: 300;
    width: 100%;
    /* color: #8492af; */
    color:#000;
    /* color: #ffffff; */
    /* padding: 15px 50px; */
    padding: 10px 10px 10px;
    /* font-size: 17px; */
    /* max-width: 550px; */
    /* font-size: 12px; */
    font-size:0.8rem;
    max-width: 400px;
}

.login-form label {
    margin-bottom: 30px;
    width: 100%;
}
.login-signup .tab-content {
    background: #ffffff none repeat scroll 0 0;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.176);
    display: inline-block;
    margin-top: -8px;
    width: 100%;
}

button.form-btn {
    font-size: 0.8rem;
}

.form-btn {
    /* background: #5584ff none repeat scroll 0 0; */
    background: #236890 none repeat scroll 0 0;
    /* border: medium none; */
    /* border-radius: 100px; */
    color: #ffffff;
    font-weight: 400;
    /* max-width: 250px; */
    max-width: 100px;
    padding: 10px 0;
    position: relative;
    width: 100%;
    margin-bottom: 10px;
    border:none
}
.form-btn:hover{
    box-shadow: 0 2px 8px #d2d2d2;
    -moz-box-shadow: 0 2px 8px #d2d2d2;
    -webkit-box-shadow: 0 2px 8px #d2d2d2;
}

.tab-content .tab-pane {
    padding:35px 0;
    /* background: -webkit-linear-gradient(left, #0a2a5a, #127953); */
}

.credits {
	padding: 0.4rem;
    margin-left: 40%;
    transform: translateX(-50%);
    font-size: 0.671em;
    line-height: 1.8;
}
.msg-txt{
    font-size: 0.8rem;
}
.error-msg {
  color: #ed2553;
}
.error-msg p{
  padding: 5px;
  background: #ffffff;
  border: 1px solid #ed2553;
}
.success-msg{
	color: #008000;
}
.success-msg p{
  padding: 5px;
  background: #ffffff;
  border: 1px solid #008000;
}
/*Login Signup Page*/
@media only screen and (max-device-width: 767px) {
    .login-logo img {
        margin: 0 auto;
    }
    .login-details .nav-tabs > li {
        text-align: center;
        width: 50%;
    }
    .login-signup .login-inner h1 {
        font-size: 26px;
        margin-bottom: 0;
        margin-top: 10px;
    }
    .login-inner .login-form input {
        font-size: 15px;
        max-width: 100%;
        /* padding: 15px 45px; */
        padding: 10px 10px 10px;
    }
    .login-inner .form-details {
        padding: 25px;
    }
    .login-inner .login-form label {
        margin-bottom: 20px;
        width: 100%;
    }
    .login-inner .form-btn {
        margin: 0;
        max-width: 180px;
    }
    .tab-content .tab-pane {
        padding: 20px 0;
    }
    #navigation .navi a {
        font-size: 14px;
        padding: 20px;
        text-align: center;
    }
    #navigation .navi i {
        margin-right: 0px;
    }
    #navigation .navi a:hover,
    #navigation .navi .active a {
        background: #122143 none repeat scroll 0 0;
        border-left: none;
        display: block;
        padding-left: 20px;
    }
    header .header-top img {
        max-width: 38px !important;
    }
    .v-align header {
        padding: 12px 15px;
    }
    header .header-top li {
        padding-left: 13px;
        padding-right: 6px;
    }
    .navbar-default .navbar-toggle {
        border-color: rgba(0, 0, 0, 0);
    }
    .navbar-header .navbar-toggle {
        float: left;
        margin: 0;
        padding: 0;
        top: 12px;
    }
    button,
        html [type="button"],
        [type="reset"],
        [type="submit"] {
            outline: medium none;
    }
    .user-dashboard .sales h2 {
        color: #8492af;
        float: left;
        font-size: 14px;
        font-weight: 600;
        margin: 0;
        padding: 13px 0 0;
}
    .user-dashboard .btn.btn-secondary.btn-lg.dropdown-toggle > span {
        font-size: 11px;
}
    .user-dashboard .sales button {
        font-size: 11px;
        padding-right: 23px;
}  
    .user-dashboard .sales h2 {
    font-size: 12px;
}
.gutter{
    padding: 0;
}
}


@media only screen and (max-device-width: 992px) {
    header .header-top li {
        padding-left: 20px !important;
        padding-right: 0;
}
    header .logo img {
        max-width: 125px !important;
}

}

@media only screen and (min-device-width: 767px) and (max-device-width: 998px){
      .user-dashboard .header-top {
        padding-top: 5px;
}
    .user-dashboard .header-rightside {
        display: inline-block;
        float: left;
        width: 100%;
}
    .user-dashboard .header-rightside .header-top img {
        max-width: 41px !important;
} 
    .user-dashboard .sales button {
    font-size: 10px;
}
    .user-dashboard .btn.btn-secondary.btn-lg.dropdown-toggle > span {
    font-size: 12px;
}
    .user-dashboard .sales h2 {
    font-size: 15px;
}
}
@media only screen and (min-device-width:998px) and (max-device-width: 1350px){
        #navigation .logo img {
    max-width: 130px;
    padding: 16px 0 17px;
    width: 100%;
}
}

    </style>
  </head>
  <body>
      
    <div class="login-area">
        <div class="bg-image">
            <div class="login-signup">
                <div class="container">
                    <div class="login-header">
                        <div class="row">
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="login-logo">
                                    <img src="https://lab.idmission.com:9043/eVolv/images/IDM-Logo.svg" alt="merkury_logo" class="img-responsive">
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <div class="login-details">
                                    <ul class="nav nav-tabs navbar-right">
                                        <li class="nav-tb-li active"><a data-toggle="tab" id="login-tb" href="#login">Login</a></li>
                                        <li class="nav-tb-li"><a data-toggle="tab" href="#register">Register</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>
                    <br>
                    
                    <div class="error-msg msg-txt text-center">
                        <s:if test='%{errorMessagesList != null}'>
                            <s:iterator value="errorMessagesList">
                                <p><s:property value="errorMsg"/></p>
                            </s:iterator>
                        </s:if>
                    </div>
                    <div class="success-msg msg-txt text-center">
                        <s:if test='%{successMessageList != null}'>
                            <s:iterator value="successMessageList">
                                <p><s:property value="successMsg"/></p>
                            </s:iterator>
                        </s:if>
                    </div>
                </div>
                    <div class="tab-content">
                        <div id="register" class="tab-pane">
                           <div class="login-inner">
                                <div class="title">
                                    <h1>Welcome <span>back!</span></h1>
                                </div>
                                <div class="login-form">
                                    <form class="form-signup" id="registerUserForm" action="registerUser" method="post">
                                        <div class="form-details">
                                            <label class="user">
                                                <input type="text" id="name" name="userBean.name" placeholder="Enter name ">
                                            </label>
                                            <label class="mail">
                                                <input type="email" id="email" name="userBean.email_id" placeholder="Enter email">
                                            </label>
                                            <label class="phone">
                                                <input type="number" maxlength="10" minlength="10"  id="phone" name="userBean.phone_number" 
                                                placeholder="Enter phone ">
                                            </label>
                                            <label class="pass">
                                                <input type="password" id="pwd" name="userBean.password" placeholder="Enter password ">
                                            </label>
                                            <label class="pass">
                                                <input type="password" id="cpwd" name="userBean.cpassword" placeholder="Confirm password">
                                            </label>
                                        </div>
                                        <input type="hidden" name="userBean.user_type" value="CANDIDATE"/>
                                        <button type="submit" class="form-btn" onsubmit="">Register</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div id="login" class="tab-pane fade in active">
                            <div class="login-inner">
                                <div class="title">
                                    <h1>Welcome <span>back!</span></h1>
                                </div>
                                <div class="login-form">
                                    <form class="form-signin" action="login" method="post">
                                        <div class="form-details">
                                            <label class="user">
                                                <input type="text" id="login_id" name="email_id" placeholder="Enter username" >
                                            </label>
                                            <label class="pass">
                                                <input type="password" id="password" name="password" placeholder="Enter password ">
                                            </label>
                                        </div>
                                        <button type="submit" id="loginBtn" class="btnRegister form-btn">Login</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </body>
  <footer class="footer">
    <div class="container-fluid">
      <div class="row">
        <div class="credits">
          <span class="copyright">
            All rights are reserved © 2020 CodesVila
          </span>
        </div>
      </div>
    </div>
  </footer>
</html>