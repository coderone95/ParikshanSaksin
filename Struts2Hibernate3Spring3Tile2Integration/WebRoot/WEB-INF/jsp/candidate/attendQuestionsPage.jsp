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
<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<script src="./assets/js/core/jquery.min.js"></script>
<script src="./assets/js/bootstrap-select.min.js"></script>
<script src="./assets/js/core/popper.min.js"></script>
<script src="./assets/js/core/bootstrap.min.js"></script>
<!--  Candidate Panel Sources -->
	<link href="./assets/css/candidate/candidatePanel.css" rel="stylesheet" />
	<script src="./assets/js/candidate/candidatePanel.js"></script>
	<!--  Instructions Page sources  -->
	<link href="./assets/css/candidate/examSet.css" rel="stylesheet" />
	<script src="./assets/js/candidate/questionPage.js"></script>
	<script>
		$(document).ready(function(){
			$('.submit-answer').on('click',function(){
				submitAnswer();
			});
		});
	</script>
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

.question:hover{
  background: #007fbe !important;
}

.active-question{
 background: #007fbe !important; 
}

</style>
</head>
<body>
<s:hidden key="testId"></s:hidden>
<s:hidden key="loginId"></s:hidden>
<s:hidden key="hasExamStarted"></s:hidden>
<s:hidden key="groupId"></s:hidden>
<input type="hidden" id="selectedQuestionId">
<div class="page-wrapper chiller-theme toggled">
  <a id="show-sidebar" class="btn btn-sm btn-dark" href="#">
    <i class="fas fa-bars"></i>
  </a>
  <nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content">
      <div class="sidebar-brand">
        <a href="#">Pariskhan Saksin</a>
        <div id="close-sidebar">
          <i class="fas fa-times"></i>
        </div>
      </div>
      <div class="sidebar-header l-bg-orange">
        <div class="user-pic">
          <img class="img-responsive img-rounded" src="https://raw.githubusercontent.com/azouaoui-med/pro-sidebar-template/gh-pages/src/img/user.jpg"
            alt="User picture">
        </div>
        <div class="user-info">
          <span class="user-name"><s:property value="name"></s:property>
          </span>
          <span class="user-role user-email-id"><s:property value="loginId"/></span>
        </div>
      </div>
      <div class="sidebar-menu">
        <ul>
          <!-- <li class="header-menu">
            <span>Extra</span>
          </li> -->
          <li>
            <a href="testInstructions">
              <i class="fa fa-book"></i>
              <span>Exam Instructions</span>
            </a>
          </li>
          <s:if test="%{hasExamStarted == 'YES'}">
          <li class="sidebar-dropdown">
            <a href="#">
              <i class="fa fa-newspaper active"></i>
              <span id="exam-sets" class="active">Exam Set</span>
            </a>
            <div class="sidebar-submenu set-question-area-dropdown">
              <ul class="exam-set-dropdown-ul">
                <li class="lis">
                    <a href="#">
                        <span class="exam-set-name">Set 1</span>
                      </a>
                </li>
                <li class="lis">
                    <a href="#">
                        <span class="exam-set-name">Set 2</span>
                      </a>
                </li>
                <li class="lis"> 
                    <a href="#">
                        <span class="exam-set-name">Set 3</span>
                      </a>
                </li>
              </ul>
            </div>
          </li>
          </s:if>
          <li>
            <a onclick="clearSessionValues();" href="#">
                <i class="fa fa-power-off"></i>
              <span>Logout</span>
            </a>
          </li>
        </ul>
      </div>
      <!-- sidebar-menu  -->
    </div>
  </nav>
  <!-- sidebar-wrapper  -->
  <main class="page-content">
    <div class="container-fluid" id="exam-set-container">
      <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="p-2">
              <a href="examSet.action" class="text-secondary p-2" style="color:#007fbe !important;"><i class="fa fa-arrow-circle-left" aria-hidden="true"></i> Back</a>
            </div>
        </div>
      </div>
    	<div class="row">
    		<div class="col-lg-9 col-md-9 col-sm-12">
		    	<div class="privew">
            <div class="p-1" class="groupTitleSection">
              <hr>
              <span id="groupTitle" style="font-size: 1rem;"></span>
              <hr>
            </div>
				    <div class="questionsBox">
				        <div class="questions question-name"></div>
				        <ul class="answerList">
				            <!-- <li>
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
				            </li> -->
				        </ul>
				        <div class="questionsRow">
                  <a href="#" class="btn btn-outline-secondary" id="prevquestion">Prev</a>
                  <a href="#" class="btn btn-outline-secondary" id="nextquestions">Next</a> <!--  <a href="#" class="btn btn-primary" id="skipquestions">Skip</a> -->
				        <button class="btn btn-success" class="submit-answer">Submit Answer</button></div>
				    </div>
				</div>	
    		</div> 
    		<div class="col-lg-3 col-md-3 col-sm-12 questions-window">
    			<div class="row p-2">
    				<div class="text-center">
    					<h5 class="text-center"> Questions </h5>
    				</div>
    			</div>
    			<div class="row question-id-row">
    				<div class="col-lg-3">
    					<button class="btn btn-outline-secondary m-1">1</button>
    				</div>
    				<div class="col-lg-3">
    					<button class="btn btn-outline-secondary m-1">2</button>
    				</div>
    				<div class="col-lg-3">
    					<button class="btn btn-outline-secondary m-1">3</button>
    				</div>
    				<div class="col-lg-3">
    					<button class="btn btn-outline-secondary m-1">4</button>
    				</div>
    				<div class="col-lg-3">
    					<button class="btn btn-outline-secondary m-1">5</button>
    				</div>
    				<div class="col-lg-3">
    					<button class="btn btn-outline-secondary m-1">6</button>
    				</div>
    			</div>
    		</div>
    	</div>
        
    </div>
    
  </main>
  <!-- page-content" -->
</div>
	<%-- 
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
</div>--%>
</body>
<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
 			Please select option
        </div>
        
      </div>
    </div>
  </div>
</html>