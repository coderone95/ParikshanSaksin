<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Instructions</title>
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
<script>
	$(document).ready(function(){
		getTestInstructions();	
	});
	
	function startTest(){
		sessionStorage.removeItem("EVGivingTestForID");
		sessionStorage.setItem('EVGivingTestForID',$('#testID').val());
		sessionStorage.removeItem('exam-start-time');
		sessionStorage.setItem('exam-start-time',new Date());
		window.location.href = 'startTest.action';
	}
	
	function getTestInstructions(){
		$('.test-instructions').html('');
		var testID = $('#testID').val();
		var data = {
				testID : testID
		};
		$.ajax({
			type : "POST",
			url : "getTestInstructions",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				$('.test-instructions').append(itr.testAuthBean.test_instructions);
			},
			error : function(itrr) {
				alert("Error occurred while fetching the test instructions..!!");
			}
		});
	}
	function clearSessionValues(){
		sessionStorage.clear();
			// similar behavior as clicking on a link
		window.location.href = "logout";
	}
</script>
<style>
.sign-out { float:right; margin-top: 1rem;}
body { -webkit-font-smoothing: antialiased; text-rendering: optimizeLegibility; }
h1, h2, h3, h4, h5, h6 { color: #161718; margin: 0px 0px 15px 0px; font-weight: 400; font-family: 'Lato', sans-serif; }
h1 { font-size: 30px; line-height: 42px; }
h2 { font-size: 24px; line-height: 32px; font-weight: 400; }
h3 { font-size: 21px; line-height: 30px; font-weight: 400; }
h4 { font-size: 18px; line-height: 26px; font-weight: 400; }
h5 { font-size: 13px; font-weight: 400; }
h6 { font-size: 12px; font-weight: 400; }
p { margin: 0 0 20px; line-height: 1.8; }
p:last-child { margin: 0px; }
ul, ol { list-style: none; margin: 0; padding: 0; }
a { text-decoration: none; color: #161718; -webkit-transition: all 0.3s; -moz-transition: all 0.3s; transition: all 0.3s; }
a:focus, a:hover { text-decoration: none; color: #0170a2; }
label { }
.control-label { font-size: 13px; text-transform: capitalize; color: #3c424b; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 1px; }
.form-control:focus { }
.textarea.form-control { }
.required { }
.form-group { margin-bottom: 5px; }
.form-control { border-radius: 0px; color: #656869; font-size: 16px; font-weight: 400; width: 100%; height: 52px; padding: 0px; line-height: 1.42857143; border-top: transparent; border-left: transparent; border-right: transparent; border-bottom: 1px solid #a6a9ad; background-color: transparent; text-transform: capitalize; letter-spacing: 0px; margin-bottom: 10px; -webkit-box-shadow: inset 0 0px 0px rgba(0, 0, 0, .075); box-shadow: inset 0 0px 0px rgba(0, 0, 0, .075); }
.form-control:focus { color: #0084bf !important; outline: 0; -webkit-box-shadow: none; box-shadow: none; }
.input-group { position: relative; display: table; border-collapse: separate; }
input[type=checkbox], input[type=radio] { margin: 8px 0 0; margin-top: 9px; line-height: normal; }
input::-webkit-input-placeholder { color: #6b6c6d !important; }
input:focus::-webkit-input-placeholder { color: #0084bf !important; bottom: 20px; position: relative; }
textarea::-webkit-input-placeholder { color: #6b6c6d !important; }
textarea:focus::-webkit-input-placeholder { color: #0084bf !important; bottom: 20px; position: relative; }
.input-group-addon { background-color: transparent; border: 1px solid #e8ecf0; border-radius: 0px; }
.focus { border-top: transparent; border-left: transparent; border-right: transparent; border-bottom: 1px solid #a6a9ad; background-color: #fff; }
.focus:focus { border-top: transparent; border-left: transparent; border-right: transparent; border-bottom: 1px solid #0084bf; outline: 0; -webkit-box-shadow: none; box-shadow: none; }
.has-success .form-control { border-color: #3c763d; background-color: #fff; box-shadow: none; }
.has-success .form-control:focus { border-color: #3c763d; outline: 0; -webkit-box-shadow: none; box-shadow: none; }
.has-error .form-control { border-color: #a94442; background-color: #fff; box-shadow: none; }
.has-error .form-control:focus { border-color: #a94442; outline: 0; -webkit-box-shadow: none; box-shadow: none; }

.consultantion-form { /* background-color: #f5f5f5; *//*  background-color: #091279; */ background: -webkit-linear-gradient(left, #3931af, #00c6ff); /*  padding: 60px 50px; */ padding: 2rem; margin-top:50px;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-moz-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); }
.btn { font-family: 'Lato', sans-serif; font-size: 16px; text-transform: capitalize; font-weight: 700; padding: 10px 20px; border-radius: 0px; line-height: 1.8; letter-spacing: 0px; -webkit-transition: all 0.3s; -moz-transition: all 0.3s; transition: all 0.3s; word-wrap: break-word; white-space: normal !important; }
.btn-primary { background-color: #0084bf; color: #fff; border: 2px solid #0084bf; }
.btn-primary:hover { background-color: #0170a2; color: #fff; border: 2px solid #0170a2; }
.pdt20{ padding-top:20px;}
.back-sign{ float:left;margin-top: 1rem;}
.test-instructions{ max-height: 500px; overflow: auto;}

</style>
</head>

<body>
<s:hidden key="testID" />
 <div class="container">
 		<div class="row">
 			<!-- <div class="col-md-12">
 				<div class="back-sign">
 					<a href="auth-page" class="btn btn-outline-warning btn-md">Back</a>
 				</div>
	 			<div class="sign-out">
	            	<a onclick="clearSessionValues();" href="#" class="btn btn-outline-primary btn-md"><i class="fa fa-sign-out"></i>Log out</a>
	         	</div>
	        </div> -->
 		</div>
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="consultantion-form">
                	<!-- <a href="auth-page" class="btn btn-outline-warning btn-md text-left">Back</a>
                    <p class="mb30 text-center text-uppercase" style="color: #fff;">EXAM Instructions </p><hr style="border-top: 2px solid rgba(232, 227, 56, 0.68);">
                    <a onclick="clearSessionValues();" href="#" class="btn btn-outline-primary text-right btn-md"><i class="fa fa-sign-out"></i>Log out</a><br> -->
                    <div class="row">
                    	<div class="col-md-4 col-lg-4"><a href="auth-page" class="btn btn-outline-warning text-left">Back</a></div>
                    	<div class="col-md-4 col-lg-4"><h3 class="mb30 text-center text-uppercase" style="color: #fff;">EXAM Instructions </h3></div>
                    	<div class="col-md-4 col-lg-4"><a onclick="clearSessionValues();" href="#" style="float:right;" class="btn btn-danger text-right"><i class="fa fa-sign-out"></i>Log out</a></div>
                    </div><br/>
                    <div class="row">
                    	<div class="col-md-12 col-lg-12">
                    		<div class="test-instructions" style="background: #fefeff;padding: 2rem;">
                    			
                    		</div>
                    		<div class="start-test text-center">
                    			<a href="#" class="btn btn-success btn-md" style="margin-top:0.5rem;" onclick="startTest();" id="start-test">Start Test</a>
                    		</div>
                    	</div>
                    </div>
                </div>
            </div>
        </div>
         <div class="row">
          <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 ">
          </div>
         </div>
    </div>
</body>
</html>