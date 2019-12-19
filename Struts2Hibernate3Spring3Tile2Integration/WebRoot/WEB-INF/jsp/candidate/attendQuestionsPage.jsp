<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Attend Questions</title>
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
<style>
.privew {
    margin-bottom: 20px;
    margin-top: 20px;
}
.questionsBox {
    display: block;
    border: solid 1px #e3e3e3;
    padding: 10px 20px 0px;
    box-shadow: inset 0 0 30px rgba(000,000,000,0.1), inset 0 0 4px rgba(255,255,255,1);
    border-radius: 3px;
    margin: 0 10px;
}.questions {
    background: #007fbe;
    color: #FFF;
    font-size: 22px;
    padding: 8px 30px;
    font-weight: 300;
    margin: 0 -30px 10px;
    position: relative;
}
.questions:after {
    background: url(../img/icon.png) no-repeat left 0;
    display: block;
    position: absolute;
    top: 100%;
    width: 9px;
    height: 7px;
    content: '.';
    left: 0;
    text-align: left;
    font-size: 0;
}
.questions:after {
    left: auto;
    right: 0;
    background-position: -10px 0;
}
.questions:before, .questions:after {
    background: black;
    display: block;
    position: absolute;
    top: 100%;
    width: 9px;
    height: 7px;
    content: '.';
    left: 0;
    text-align: left;
    font-size: 0;
}
.answerList {
    margin-bottom: 15px;
}


ol, ul {
    list-style: none;
}
.answerList li:first-child {
    border-top-width: 0;
}

.answerList li {
    padding: 3px 0;
}
.answerList label {
    display: block;
    padding: 6px;
    border-radius: 6px;
    border: solid 1px #dde7e8;
    font-weight: 400;
    font-size: 13px;
    cursor: pointer;
    font-family: Arial, sans-serif;
}
input[type=checkbox], input[type=radio] {
    margin: 4px 0 0;
    margin-top: 1px;
    line-height: normal;
}
.questionsRow {
    background: #dee3e6;
    margin: 0 -20px;
    padding: 10px 20px;
    border-radius: 0 0 3px 3px;
}
.button, .greyButton {
    background-color: #f2f2f2;
    color: #888888;
    display: inline-block;
    border: solid 3px #cccccc;
    vertical-align: middle;
    text-shadow: 0 1px 0 #ffffff;
    line-height: 27px;
    min-width: 160px;
    text-align: center;
    padding: 5px 20px;
    text-decoration: none;
    border-radius: 0px;
    text-transform: capitalize;
}
.questionsRow span {
    float: right;
    display: inline-block;
    line-height: 30px;
    border: solid 1px #aeb9c0;
    padding: 0 10px;
    background: #FFF;
    color: #007fbe;
}
.sign-out{
		float:right;
		margin-top: 1rem;
}
.back-sign { float:left;margin-top: 1rem; }

</style>
<style>
.pag-link {
    display: inline-block;
    vertical-align: middle;
    padding: 5px;
}
.pag-link.disabled > span,
.pag-link.current > span,
.pag-link > a{
    display: block;
    border-radius: 50%;
    font-size: 16px;
    line-height: 1.42857;
    margin-right: 5px;
    padding: 10px 17px;
    position: relative;
    text-decoration: none;
    border: none;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -o-transition: all 0.3s ease-in-out;
    -ms-transition: all 0.3s ease-in-out;
    transition: all 0.3s ease-in-out;
}
.pag-link:active > a,
.pag-link:hover > a,
.pag-link:focus > a,
.pag-link.current > span{
    font-size: 24px;
    font-weight: bold;
    padding: 10px 20px;
}
.pag-link > a{
    background-color: #7f4189;
    color: #fff;
    cursor: pointer;
}
.pag-link.disabled > span,
.pag-link.current > span{
    background-color: #13b3bc;
    color: #fff;
    cursor: inherit;
}
.pag-link:active > a,
.pag-link:hover > a,
.pag-link:focus > a {
    background-color: #ec217c !important;
    border-color: #ec217c;
    color: #fff;
}

</style>
</head>
<body>
	<div class="container">
		<div class="row">
 			<div class="col-md-12">
 				<div class="back-sign">
 					<a href="startTest.action" class="btn btn-outline-warning btn-md">Back</a>
 				</div>
	 			<div class="sign-out">
	            	<a onclick="clearSessionValues();" href="#" class="btn btn-outline-primary btn-md"><i class="fa fa-sign-out"></i>Log out</a>
	         	</div>
	        </div>
 		</div>
		<div class="privew">
		    <div class="questionsBox">
		        <div class="questions">Which of the following is correct about data-keyboard Data attribute of Modal Plugin?</div>
		        <ul class="answerList">
		            <li>
		                <label>
		                    <input type="radio" name="answerGroup" value="0" id="answerGroup_0"> It specifies static for a backdrop, if you don't want the modal to be closed when the user clicks outside of the modal.</label>
		            </li>
		            <li>
		                <label>
		                    <input type="radio" name="answerGroup" value="1" id="answerGroup_1"> It closes the modal when escape key is pressed; set to false to disable.</label>
		            </li>
		            <li>
		                <label>
		                    <input type="radio" name="answerGroup" value="2" id="answerGroup_2"> It shows the modal when initialized.</label>
		            </li>
		            <li>
		                <label>
		                    <input type="radio" name="answerGroup" value="3" id="answerGroup_3"> Using the jQuery .load method, injects content into the modal body. If an href with a valid URL is added, it will load that content.</label>
		            </li>
		        </ul>
		        <div class="questionsRow"><a href="#" class="btn btn-primary" id="nextquestions">Next</a> <a href="#" class="btn btn-primary" id="prevquestion">Prev</a> <a href="#" class="btn btn-primary" id="skipquestions">Skip</a><span>2 of 20</span></div>
		    </div>
		</div>
	</div>
	<div class="container">
	<div class="row">
		<ul class="pagination-custom text-center">
	        <li class="pag-link"><a href="#">1</a></li>
	        <li class="pag-link"><a href="#">2</a></li>
	        <li class="pag-link current"><span>3</span></li>
	        <li class="pag-link"><a href="#">4</a></li>
	        <li class="pag-link"><a href="#">5</a></li>
        </ul>
	</div>
</div>
</body>
</html>