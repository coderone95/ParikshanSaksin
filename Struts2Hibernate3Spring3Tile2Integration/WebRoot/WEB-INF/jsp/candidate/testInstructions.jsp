<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Parikshan Saksin</title>
    <link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
	<!-- page-wrapper -->
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/bootstrap-select.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<!--  Candidate Panel Sources -->
	<link href="./assets/css/candidate/candidatePanel.css" rel="stylesheet" />
	<script src="./assets/js/candidate/candidatePanel.js"></script>
	<!--  Instructions Page sources  -->
	<link href="./assets/css/candidate/testInstructionsPage.css" rel="stylesheet" />
	<script src="./assets/js/candidate/testInstructionPage.js"></script>
</head>

<body>
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
      <div class="sidebar-header">
        <div class="user-pic">
          <img class="img-responsive img-rounded" src="https://raw.githubusercontent.com/azouaoui-med/pro-sidebar-template/gh-pages/src/img/user.jpg"
            alt="User picture">
        </div>
        <div class="user-info">
          <span class="user-name">Jhon
            <strong>Smith</strong>
          </span>
          <span class="user-role">johnp@gmail.com</span>
        </div>
      </div>
      <div class="sidebar-menu">
        <ul>
          <!-- <li class="header-menu">
            <span>Extra</span>
          </li> -->
          <li>
            <a href="#">
              <i class="fa fa-book active"></i>
              <span>Exam Instructions</span>
            </a>
          </li>
          <li class="sidebar-dropdown">
            <a href="#">
              <i class="fa fa-newspaper"></i>
              <span id="exam-sets">Exam Set</span>
            </a>
            <div class="sidebar-submenu set-question-area-dropdown">
              <ul>
                <li class="lis">
                    <a href="#">
                        <span id="exam-set-name-1">Set 1</span>
                      </a>
                </li>
                <li class="lis">
                    <a href="#">
                        <span id="exam-set-name-2">Set 2</span>
                      </a>
                </li>
                <li class="lis"> 
                    <a href="#">
                        <span id="exam-set-name-3">Set 3</span>
                      </a>
                </li>
              </ul>
            </div>
          </li>
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
    <div class="container-fluid">
        <div class="card">
            <div class="card-header no-header-bg">
                <p>EXAM INSTRUCTIONS</p>
                <!-- <div class="card-option text-right"><button class="btn btn-info">SUBMIT</button><button type="button" class="btn btn-primary ml-1">
                    <i class="fa fa-hourglass-half"></i> <span class="badge badge-light" id="time">12.45</span>
                </button></div> -->
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-xs-1-12 col-sm-12 col-lg-12">
                        <div class="test-instructions-area">
                            <div class="test-instructions" style="max-height: 500px; overflow: auto;">
                            </div>
                        </div>
                        <div>
                            <button type="button" class="btn btn-dark btn-block">START EXAM</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </main>
  <!-- page-content" -->
</div>

</body>

</html>