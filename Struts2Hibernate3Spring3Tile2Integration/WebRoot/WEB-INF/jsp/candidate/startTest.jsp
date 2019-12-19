<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Test</title>
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
	$('#testID').val(sessionStorage.getItem('EVGivingTestForID'));
	getGroupsInfoAndNumberOfQuestionCount();
	getTestNameAndTime();
	$('#user-logged-id').text($('#loginId').val());
	$('.sidebar-menu').on('click', function(){
		var menu = $(this).attr('id');
		$('.content-pane').addClass('display-none');
		$('.sidebar-menu').removeClass('active');
		$(this).addClass('active');
		if(menu == 'exam-set-menu'){
			$('#examset').removeClass('display-none');	
		}
	});
});
function clearSessionValues(){
	sessionStorage.clear();
		// similar behavior as clicking on a link
	window.location.href = "logout";
}
function getGroupsInfoAndNumberOfQuestionCount(){
	$('#examset').html('');
	var testID = $('#testID').val();
	var data = {
			testID : testID	
	};
	$.ajax({
		type : "POST",
		url : "getGroupsInfoAndNumberOfQuestionCount",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			var str = '';
			if(itr.groupInfoAndCountList != null && itr.groupInfoAndCountList.length >0){
				//console.table(itr.groupInfoAndCountList);
				var sr = 1;
				for(var i = 0 ; i < itr.groupInfoAndCountList.length; i++){
					var groupID = itr.groupInfoAndCountList[i].group_id;
					var groupName = itr.groupInfoAndCountList[i].group_name;
					var count = itr.groupInfoAndCountList[i].numberOfQuestionsCount;
					//console.log('\n'+groupID+'\t'+groupName+'\t'+count);
					str += '<div class="col-md-3 shadow p-3 mb-5 bg-white rounded" style="margin-left:2rem;" id="group-id-'+groupID+'"><div class="text-center text-success"><a href="#" class="text-success" onclick="attendAvailableGroupsQuestions('+groupID+');"><b class="set-name">'+groupName+'</b></a></div><div class="text-center"><span class="text-primary">No of Questions:</span> <span>'+count+'</span></div></div>'; 
				}
				$('#examset').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});
}

function attendAvailableGroupsQuestions(groupID){
	sessionStorage.removeItem("selectedGroup");
	sessionStorage.setItem("selectedGroup",groupID);
	window.location.href = "questions.action";
}
function startTime(time){
	
	var minSec = (time/60);
	//console.log(hrsMin);
	minSec = minSec.toFixed(2);
	minSec = minSec.replace('.',':');
	//console.log(hrsMin);
	var timer2 = minSec;
	var interval = setInterval(function() {
	  var timer = timer2.split(':');
	  //by parsing integer, I avoid all extra string processing
	  var minutes = parseInt(timer[0], 10);
	  var originalMin = minutes;
	  var seconds = parseInt(timer[1], 10);
	  --seconds;
	  minutes = (seconds < 0) ? --minutes : minutes;
	  if (minutes < 0) clearInterval(interval);
	  seconds = (seconds < 0) ? 59 : seconds;
	  seconds = (seconds < 10) ? '0' + seconds : seconds;
	  //minutes = (minutes < 10) ?  minutes : minutes;
	  $('#test-time').html(minutes + ':' + seconds);
	  if (minutes < 0) {
		  clearInterval(interval);
		  submitTest();
	  }
	  //check if both minutes and seconds are 0
	  if ((seconds <= 0) && (minutes <= 0)) {
		  clearInterval(interval);
		  submitTest();
	  }
	  timer2 = minutes + ':' + seconds;
	}, 1000);
}

function submitTest(){
	alert("Test Submitted");
}
function getTestNameAndTime(){
	var testID = $('#testID').val();
	var data = {
			testID : testID	
	};
	$.ajax({
		type : "POST",
		url : "getTestNameAndTime",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			$('#test-name').text(itr.testBo.test_name);
			startTime(itr.testBo.test_time);
			//setTimer(itr.testBo.test_time);
			$('.loader').hide();;
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});
}

function setTimer(timeInSec){
	var totalSeconds = timeInSec;
	var hours = Math.floor(totalSeconds / 3600);
	totalSeconds %= 3600;
	
	var minutes = Math.floor(totalSeconds / 60);
	var seconds = totalSeconds % 60;
	var now  = new Date(sessionStorage.getItem('exam-start-time'));
	now.setHours(now.getHours()+hours);
	now.setMinutes(now.getMinutes()+minutes);
	now.setSeconds(now.getSeconds()+seconds);
	
	saveAttendedTestDetails(sessionStorage.getItem('exam-start-time'),now);
	var deadline = now.getTime(); 

	var x = setInterval(function() { 

	var now = new Date().getTime(); 
	var t = deadline - now; 
	var days = Math.floor(t / (1000 * 60 * 60 * 24)); 
	var hours = Math.floor((t%(1000 * 60 * 60 * 24))/(1000 * 60 * 60)); 
	var minutes = Math.floor((t % (1000 * 60 * 60)) / (1000 * 60)); 
	var seconds = Math.floor((t % (1000 * 60)) / 1000); 
	document.getElementById("hour").innerHTML = hours; 
	document.getElementById("minute").innerHTML = minutes; 
	document.getElementById("second").innerHTML =seconds; 
	if (t < 0) { 
			clearInterval(x); 
			document.getElementById("hour").innerHTML ='0'; 
			document.getElementById("minute").innerHTML ='0' ; 
			document.getElementById("second").innerHTML = '0'; } 
	}, 1000); 
}
function saveAttendedTestDetails(starttime,endtime){
	var testID =  $('#testID').val();
	var starttime = new Date(starttime);
	var data = {
			testID : testID,
			starttime : convertToLocalStringTime(starttime),
			endtime :  convertToLocalStringTime(endtime)
	};
	$.ajax({
		type : "POST",
		url : "saveAttendedTestDetails",
		data: JSON.stringify(data),
		dataType: 'json',
		contentType:"application/json;charset=utf-8",
		success : function(data) {
			
		},
		error : function(itr) {
			alert("Error while processing the request....!!");
		}
	});
}
function convertToLocalStringTime(today){
	var day = today.getDate() + "";
	var month = (today.getMonth() + 1) + "";
	var year = today.getFullYear() + "";
	var hour = today.getHours() + "";
	var minutes = today.getMinutes() + "";
	var seconds = today.getSeconds() + "";

	day = checkZero(day);
	month = checkZero(month);
	year = checkZero(year);
	hour = checkZero(hour);
	mintues = checkZero(minutes);
	seconds = checkZero(seconds);
	
	console.log(day + "/" + month + "/" + year + " " + hour + ":" + minutes + ":" + seconds);
	return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
}

function checkZero(data){
	  if(data.length == 1){
	    data = "0" + data;
	  }
	  return data;
}
</script>
<style>
	.sign-out{
		float:right;
		margin-top: 1rem;
	}
	.back-sign { float:left;margin-top: 1rem; }
	.set {width: auto;height: auto;background: #2e1f7d;padding: 1rem; color:#fff;}
	.set-icon {padding: 0.5rem;}
	.set-name {font-size: 18px;}
	.set-row {color:#000;}
	#test-name {padding:1rem;}
	.table-dark {background-color: #1863af;}
	
	
	
.loader{
  position: fixed;
  top: 0;
  left: 0;
  width: 100%; 
  height: 100%;
  z-index: 99999;
  transition: 1s;
  background: #28094a4f;
}
.span{
  position: absolute;
  transform: translate(-50%, 50%);
  width: 60px; 
  height: 60px;
  top: 35%;
  border: 5px solid #262626;
  z-index: 9999;
  animation: animar 2.5s linear infinite;
}
.span:before{
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: #262626;
  animation: animarbg 2.5s linear infinite;
}

@keyframes animar {
    0% {
        transform: translate(-50%, 50%) rotate(0deg);
    }
    25% {
        transform: translate(-50%, 50%) rotate(180deg);
    }
    50% {
        transform: translate(-50%, 50%) rotate(180deg);
    }
    75% {
        transform: translate(-50%, 50%) rotate(360deg);
    }
    100% {
        transform: translate(-50%, 50%) rotate(360deg);
    }
}
@keyframes animarbg {
    0% {
        height: 0;
    }
    25% {
        height: 0;
    }
    50% {
        height: 100%;
    }
    75% {
        height: 100%;
    }
    100% {
        height: 0;
    }
}
</style>
<style> 

h1{ 
color: #396; 
font-weight: 100; 
font-size: 40px; 
margin: 40px 0px 20px; 
} 
#clockdiv{ 
	font-family: sans-serif; 
	color: #fff; 
	display: inline-block; 
	font-weight: 100; 
	text-align: center; 
	font-size: 20px; 
} 
#clockdiv > div{ 
	padding: 10px; 
	border-radius: 3px; 
	background: #00BF96; 
	display: inline-block; 
} 
#clockdiv div > span{ 
	padding: 15px; 
	border-radius: 3px; 
	background: #00816A; 
	display: inline-block; 
} 
.smalltext{ 
	padding-top: 5px; 
	font-size: 10px;
} 
</style> 
<style>
@import "https://fonts.googleapis.com/css?family=Roboto:400,100,100italic,300,300italic,400italic,500,500italic,700,700italic,900,900italic&subset=latin,cyrillic";
/* -- import Roboto Font ---------------------------- */
/* -- import Material Icons Font -------------------- */
@font-face {
  font-family: 'Material Design Iconic Font';
  src: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/53474/Material-Design-Iconic-Font.eot?v=1.0');
  src: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/53474/Material-Design-Iconic-Font.eot?#iefix&v=1.0') format('embedded-opentype'), url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/53474/Material-Design-Iconic-Font.woff?v=1.0') format('woff'), url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/53474/Material-Design-Iconic-Font.ttf?v=1.0') format('truetype'), url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/53474/Material-Design-Iconic-Font.svg?v=1.0#Material-Design-Iconic-Font') format('svg');
  font-weight: normal;
  font-style: normal;
}
[class^="md-"],
[class*=" md-"] {
  display: inline-block;
  font: normal normal normal 14px/1 'Material Design Iconic Font';
  font-size: inherit;
  speak: none;
  text-rendering: auto;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.md {
  line-height: inherit;
  vertical-align: bottom;
}
.md-inbox:before {
  content: "\f10c";
}
.md-star:before {
  content: "\f2e5";
}
.md-send:before {
  content: "\f119";
}
.md-drafts:before {
  content: "\f107";
}
.md-arrow-back:before {
  content: "\f297";
}
.md-arrow-forward:before {
  content: "\f298";
}
.md-log-out:before{
 content:"\f2f5";
}
/* -- You can use this sidebar in Bootstrap (v3) projects. HTML-markup like Navbar bootstrap component will make your work easier. -- */
/* -- Box model ------------------------------- */
*,
*:after,
*:before {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
/* -- Demo style ------------------------------- */
html,
body {
  position: relative;
  min-height: 100%;
  height: 100%;
}
body {
  font-family: 'RobotoDraft', 'Roboto', 'Helvetica Neue, Helvetica, Arial', sans-serif;
  font-style: normal;
  font-weight: 300;
  font-size: 14px;
  line-height: 1.4;
  color: #212121;
  background-color: #f5f5f5;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-rendering: optimizeLegibility;
}
.sidebar-overlay {
  visibility: hidden;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  opacity: 0;
  background: #000;
  z-index: 1034;
  -webkit-transition: visibility 0 linear 0.4s, opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  -moz-transition: visibility 0 linear 0.4s, opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  transition: visibility 0 linear 0.4s, opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  -webkit-transform: translateZ(0);
  -moz-transform: translateZ(0);
  -ms-transform: translateZ(0);
  -o-transform: translateZ(0);
  transform: translateZ(0);
}
.sidebar-overlay.active {
  opacity: 0.5;
  visibility: visible;
  -webkit-transition-delay: 0;
  -moz-transition-delay: 0;
  transition-delay: 0;
}
.top-bar {
  height: 25px;
  background: rgba(0, 0, 0, 0.1);
}
/* -- Google typography ------------------------------- */
.headline {
  font-size: 24px;
  font-weight: 300;
  line-height: 1.1;
  color: #212121;
  text-transform: inherit;
  letter-spacing: inherit;
}
.subhead {
  font-size: 16px;
  font-weight: 300;
  line-height: 1.1;
  color: #212121;
  text-transform: inherit;
  letter-spacing: inherit;
}
/* -- Bootstrap-like style ------------------------------- */
.caret {
  display: inline-block;
  width: 0;
  height: 0;
  margin-left: 2px;
  vertical-align: middle;
  border-top: 4px solid;
  border-right: 4px solid transparent;
  border-left: 4px solid transparent;
}
.dropdown-menu {
  display: none;
}
/* -- Constructor style ------------------------------- */
.constructor {
  position: relative;
  margin: 0;
  /* padding: 0 50px; */
  -webkit-transition: all 0.5s cubic-bezier(0.55, 0, 0.1, 1);
  -o-transition: all 0.5s cubic-bezier(0.55, 0, 0.1, 1);
  transition: all 0.5s cubic-bezier(0.55, 0, 0.1, 1);
}
.sidebar,
.wrapper {
  display: table-cell;
  vertical-align: top;
  width:100%
}
.sidebar-stacked.open + .wrapper .constructor {
  margin-left: 280px;
}
@media (max-width: 768px) {
  .sidebar-stacked.open + .wrapper .constructor {
    margin-left: 240px;
  }
}
/* -- Sidebar style ------------------------------- */
.sidebar {
  position: relative;
  display: block;
  min-height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
  border: none;
  -webkit-transition: all 0.5s cubic-bezier(0.55, 0, 0.1, 1);
  -o-transition: all 0.5s cubic-bezier(0.55, 0, 0.1, 1);
  transition: all 0.5s cubic-bezier(0.55, 0, 0.1, 1);
}
.sidebar:before,
.sidebar:after {
  content: " ";
  display: table;
}
.sidebar:after {
  clear: both;
}
.sidebar::-webkit-scrollbar-track {
  border-radius: 2px;
}
.sidebar::-webkit-scrollbar {
  width: 5px;
  background-color: #F7F7F7;
}
.sidebar::-webkit-scrollbar-thumb {
  border-radius: 10px;
  -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
  background-color: #BFBFBF;
}
.sidebar .sidebar-header {
  position: relative;
  height: 86px;
  margin-bottom: 8px;
  -webkit-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}

.sidebar .icon-material-sidebar-arrow:before {
  content: "\e610";
}
.sidebar .sidebar-image img {
  width: 54px;
  height: 54px;
  margin-left: 56px;
  margin-top: -23px;
  /* margin: 16px; */
  border-radius: 50%;
  -webkit-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.sidebar .sidebar-brand {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  display: block;
  height: 48px;
  line-height: 48px;
  padding: 0;
  padding-left: 16px;
  padding-right: 56px;
  text-decoration: none;
  clear: both;
  font-weight: 500;
  overflow: hidden;
  -o-text-overflow: ellipsis;
  text-overflow: ellipsis;
  white-space: nowrap;
  -webkit-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.sidebar .sidebar-brand:hover,
.sidebar .sidebar-brand:focus {
  -webkit-box-shadow: none;
  box-shadow: none;
  outline: none;
}
.sidebar .sidebar-brand .caret {
  position: absolute;
  right: 24px;
  top: 24px;
}
.sidebar .sidebar-brand .sidebar-badge {
  position: absolute;
  right: 16px;
  top: 12px;
}
.sidebar .sidebar-brand:hover,
.sidebar .sidebar-brand:focus {
  text-decoration: none;
}
.sidebar .sidebar-badge {
  display: inline-block;
  min-width: 24px;
  height: 24px;
  line-height: 24px;
  padding: 0 3px;
  font-size: 10px;
  text-align: center;
  white-space: nowrap;
  vertical-align: baseline;
}
.sidebar .sidebar-badge.badge-circle {
  border-radius: 50%;
}
.sidebar .sidebar-divider,
.sidebar .sidebar-nav .divider {
  position: relative;
  display: block;
  height: 1px;
  margin: 8px 0;
  padding: 0;
  overflow: hidden;
}
.sidebar .sidebar-text {
  display: block;
  height: 48px;
  line-height: 48px;
  padding: 0;
  padding-left: 16px;
  padding-right: 56px;
  text-decoration: none;
  clear: both;
  font-weight: 500;
  overflow: hidden;
  -o-text-overflow: ellipsis;
  text-overflow: ellipsis;
  white-space: nowrap;
  -webkit-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.sidebar .sidebar-text:hover,
.sidebar .sidebar-text:focus {
  -webkit-box-shadow: none;
  box-shadow: none;
  outline: none;
}
.sidebar .sidebar-text .caret {
  position: absolute;
  right: 24px;
  top: 24px;
}
.sidebar .sidebar-text .sidebar-badge {
  position: absolute;
  right: 16px;
  top: 12px;
}
.sidebar .sidebar-icon {
  display: inline-block;
  margin-right: 16px;
  min-width: 40px;
  width: 40px;
  text-align: left;
  font-size: 20px;
}
.sidebar .sidebar-icon:before,
.sidebar .sidebar-icon:after {
  vertical-align: middle;
}
.sidebar .sidebar-nav {
  margin: 0;
  padding: 0;
}
.sidebar .sidebar-nav li {
  position: relative;
  list-style-type: none;
}
.sidebar .sidebar-nav li a {
  position: relative;
  cursor: pointer;
  user-select: none;
  display: block;
  height: 48px;
  line-height: 48px;
  padding: 0;
  padding-left: 16px;
  padding-right: 56px;
  text-decoration: none;
  clear: both;
  font-weight: 500;
  overflow: hidden;
  -o-text-overflow: ellipsis;
  text-overflow: ellipsis;
  white-space: nowrap;
  -webkit-transition: all 0.2s ease-in-out;
  -o-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.sidebar .sidebar-nav li a:hover,
.sidebar .sidebar-nav li a:focus {
  -webkit-box-shadow: none;
  box-shadow: none;
  outline: none;
}
.sidebar .sidebar-nav li a .caret {
  position: absolute;
  right: 24px;
  top: 24px;
}
.sidebar .sidebar-nav li a .sidebar-badge {
  position: absolute;
  right: 16px;
  top: 12px;
}
.sidebar .sidebar-nav li a:hover {
  background: transparent;
}
.sidebar .sidebar-nav .dropdown-menu {
  position: relative;
  width: 100%;
  margin: 0;
  padding: 0;
  border: none;
  border-radius: 0;
  -webkit-box-shadow: none;
  box-shadow: none;
}
.sidebar-colored {
  background-color: #ffffff;
}
.sidebar-colored .sidebar-header {
  background-color: #000000;
}
.sidebar-colored .sidebar-brand {
  color: #e0e0e0;
  background-color: transparent;
}
.sidebar-colored .sidebar-brand:hover,
.sidebar-colored .sidebar-brand:focus {
  color: #f5f5f5;
  background-color: rgba(0, 0, 0, 0.1);
}
.sidebar-colored .sidebar-badge {
  color: #ffffff;
  background-color: #ec407a;
}
.sidebar-colored .sidebar-divider,
.sidebar-colored .sidebar-nav .divider {
  background-color: #bdbdbd;
}
.sidebar-colored .sidebar-text {
  color: #212121;
}
.sidebar-colored .sidebar-nav li > a {
  color: #212121;
  background-color: transparent;
}
.sidebar-colored .sidebar-nav li > a i {
  color: #757575;
}
.sidebar-colored .sidebar-nav li:hover > a,
.sidebar-colored .sidebar-nav li > a:hover {
  color: #e91e63;
  background-color: #e0e0e0;
}
.sidebar-colored .sidebar-nav li:hover > a i,
.sidebar-colored .sidebar-nav li > a:hover i {
  color: #f06292;
}
.sidebar-colored .sidebar-nav li:focus > a,
.sidebar-colored .sidebar-nav li > a:focus {
  color: #212121;
  background-color: transparent;
}
.sidebar-colored .sidebar-nav li:focus > a i,
.sidebar-colored .sidebar-nav li > a:focus i {
  color: #f06292;
}
.sidebar-colored .sidebar-nav > .open > a,
.sidebar-colored .sidebar-nav > .open > a:hover,
.sidebar-colored .sidebar-nav > .open > a:focus {
  color: #e91e63;
  background-color: #e0e0e0;
}
.sidebar-colored .sidebar-nav > .active > a,
.sidebar-colored .sidebar-nav > .active > a:hover,
.sidebar-colored .sidebar-nav > .active > a:focus {
  color: #212121;
  background-color: #f5f5f5;
}
.sidebar-colored .sidebar-nav > .disabled > a,
.sidebar-colored .sidebar-nav > .disabled > a:hover,
.sidebar-colored .sidebar-nav > .disabled > a:focus {
  color: #e0e0e0;
  background-color: transparent;
}
.sidebar-colored .sidebar-nav > .dropdown > .dropdown-menu {
  background-color: #e0e0e0;
}
.sidebar-colored .sidebar-nav > .dropdown > .dropdown-menu > li > a:focus {
  background-color: #e0e0e0;
  color: #e91e63;
}
.sidebar-colored .sidebar-nav > .dropdown > .dropdown-menu > li > a:hover {
  background-color: #cecece;
  color: #e91e63;
}
.sidebar-colored .sidebar-nav > .dropdown > .dropdown-menu > .active > a,
.sidebar-colored .sidebar-nav > .dropdown > .dropdown-menu > .active > a:hover,
.sidebar-colored .sidebar-nav > .dropdown > .dropdown-menu > .active > a:focus {
  color: #212121;
  background-color: #f5f5f5;
}
.sidebar {
  width: 0;
  -webkit-transform: translate3d(-280px, 0, 0);
  transform: translate3d(-280px, 0, 0);
}
.sidebar.open {
  /* min-width: 280px;
  width: 280px; */
  max-width: 250px;
  width: 240px;
  -webkit-transform: translate3d(0, 0, 0);
  transform: translate3d(0, 0, 0);
}
.sidebar-fixed-left,
.sidebar-fixed-right,
.sidebar-stacked {
  position: fixed;
  top: 0;
  bottom: 0;
  z-index: 1035;
}
.sidebar-stacked {
  left: 0;
}
.sidebar-fixed-left {
  left: 0;
  box-shadow: 2px 0px 15px rgba(0, 0, 0, 0.35);
  -webkit-box-shadow: 2px 0px 15px rgba(0, 0, 0, 0.35);
}
.sidebar-fixed-right {
  right: 0;
  box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.35);
  -webkit-box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.35);
  -webkit-transform: translate3d(280px, 0, 0);
  transform: translate3d(280px, 0, 0);
}
.sidebar-fixed-right.open {
  -webkit-transform: translate3d(0, 0, 0);
  transform: translate3d(0, 0, 0);
}
.sidebar-fixed-right .icon-material-sidebar-arrow:before {
  content: "\e614";
}
@media (max-width: 768px) {
  .sidebar.open {
    min-width: 240px;
    width: 240px;
  }
  .sidebar .sidebar-header {
    height: 135px;
  }
  .sidebar .sidebar-image img {
    width: 44px;
    height: 44px;
  }
}
.sidebar-colored .sidebar-nav .active{
	color: #e91e63;
}

</style>
<%-- <script type="text/javascript">
// Sidebar toggle
//
// -------------------
$(document).ready(function() {
    var overlay = $('.sidebar-overlay');

    overlay.on('click', function() {
        $(this).removeClass('active');
        $('#sidebar').removeClass('open');
    });

});

// Sidebar constructor
	
//
// -------------------
$(document).ready(function() {

    var sidebar = $('#sidebar');
    var sidebarHeader = $('#sidebar .sidebar-header');
    var sidebarImg = sidebarHeader.css('background-image');

    // Hide toggle buttons on default position
    toggleButtons.css('display', 'none');
    $('body').css('display', 'table');


    
});
(function(removeClass) {

    jQuery.fn.removeClass = function( value ) {
		if ( value && typeof value.test === "function" ) {
			for ( var i = 0, l = this.length; i < l; i++ ) {
				var elem = this[i];
				if ( elem.nodeType === 1 && elem.className ) {
					var classNames = elem.className.split( /\s+/ );

					for ( var n = classNames.length; n--; ) {
						if ( value.test(classNames[n]) ) {
							classNames.splice(n, 1);
						}
					}
					elem.className = jQuery.trim( classNames.join(" ") );
				}
			}
		} else {
			removeClass.call(this, value);
		}
		return this;
	}

})(jQuery.fn.removeClass);
</script> --%>
<script>


// Sidebar toggle
//
// -------------------
$(document).ready(function() {
    var overlay = $('.sidebar-overlay');

    $('.sidebar-toggle').on('click', function() {
        var sidebar = $('#sidebar');
        sidebar.toggleClass('open');
        if ((sidebar.hasClass('sidebar-fixed-left') || sidebar.hasClass('sidebar-fixed-right')) && sidebar.hasClass('open')) {
            overlay.addClass('active');
        } else {
            overlay.removeClass('active');
        }
    });

    overlay.on('click', function() {
        $(this).removeClass('active');
        $('#sidebar').removeClass('open');
    });

});

// Sidebar constructor
//
// -------------------
$(document).ready(function() {

    var sidebar = $('#sidebar');
    var sidebarHeader = $('#sidebar .sidebar-header');
    var sidebarImg = sidebarHeader.css('background-image');
    var toggleButtons = $('.sidebar-toggle');

    // Hide toggle buttons on default position
    toggleButtons.css('display', 'none');
    $('body').css('display', 'table');


    // Sidebar position
    $('#sidebar-position').change(function() {
        var value = $( this ).val();
        sidebar.removeClass('sidebar-fixed-left sidebar-fixed-right sidebar-stacked').addClass(value).addClass('open');
        if (value == 'sidebar-fixed-left' || value == 'sidebar-fixed-right') {
            $('.sidebar-overlay').addClass('active');
        }
        // Show toggle buttons
        if (value != '') {
            toggleButtons.css('display', 'initial');
            $('body').css('display', 'initial');
        } else {
            // Hide toggle buttons
            toggleButtons.css('display', 'none');
            $('body').css('display', 'table');
        }
    });

    // Sidebar theme
    $('#sidebar-theme').change(function() {
        var value = $( this ).val();
        sidebar.removeClass('sidebar-default sidebar-inverse sidebar-colored sidebar-colored-inverse').addClass(value)
    });

    // Header cover
    $('#sidebar-header').change(function() {
        var value = $(this).val();

        $('.sidebar-header').removeClass('header-cover').addClass(value);

        if (value == 'header-cover') {
            sidebarHeader.css('background-image', sidebarImg)
        } else {
            sidebarHeader.css('background-image', '')
        }
    });
});

/**
 * Created by Kupletsky Sergey on 08.09.14.
 *
 * Add JQuery animation to bootstrap dropdown elements.
 */

(function($) {
    var dropdown = $('.dropdown');

    // Add slidedown animation to dropdown
    dropdown.on('show.bs.dropdown', function(e){
        $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
    });

    // Add slideup animation to dropdown
    dropdown.on('hide.bs.dropdown', function(e){
        $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
    });
})(jQuery);



(function(removeClass) {

    jQuery.fn.removeClass = function( value ) {
		if ( value && typeof value.test === "function" ) {
			for ( var i = 0, l = this.length; i < l; i++ ) {
				var elem = this[i];
				if ( elem.nodeType === 1 && elem.className ) {
					var classNames = elem.className.split( /\s+/ );

					for ( var n = classNames.length; n--; ) {
						if ( value.test(classNames[n]) ) {
							classNames.splice(n, 1);
						}
					}
					elem.className = jQuery.trim( classNames.join(" ") );
				}
			}
		} else {
			removeClass.call(this, value);
		}
		return this;
	}

})(jQuery.fn.removeClass);
</script>
<style>
@import url("//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css");
.navbar-icon-top .navbar-nav .nav-link > .fa {
  position: relative;
  width: 36px;
  font-size: 24px;
}

.navbar-icon-top .navbar-nav .nav-link > .fa > .badge {
  font-size: 0.75rem;
  position: absolute;
  right: 0;
  font-family: sans-serif;
}

.navbar-icon-top .navbar-nav .nav-link > .fa {
  top: 3px;
  line-height: 12px;
}

.navbar-icon-top .navbar-nav .nav-link > .fa > .badge {
  top: -10px;
}

@media (min-width: 576px) {
  .navbar-icon-top.navbar-expand-sm .navbar-nav .nav-link {
    text-align: center;
    display: table-cell;
    height: 70px;
    vertical-align: middle;
    padding-top: 0;
    padding-bottom: 0;
  }

  .navbar-icon-top.navbar-expand-sm .navbar-nav .nav-link > .fa {
    display: block;
    width: 48px;
    margin: 2px auto 4px auto;
    top: 0;
    line-height: 24px;
  }

  .navbar-icon-top.navbar-expand-sm .navbar-nav .nav-link > .fa > .badge {
    top: -7px;
  }
}

@media (min-width: 768px) {
  .navbar-icon-top.navbar-expand-md .navbar-nav .nav-link {
    text-align: center;
    display: table-cell;
    height: 70px;
    vertical-align: middle;
    padding-top: 0;
    padding-bottom: 0;
  }

  .navbar-icon-top.navbar-expand-md .navbar-nav .nav-link > .fa {
    display: block;
    width: 48px;
    margin: 2px auto 4px auto;
    top: 0;
    line-height: 24px;
  }

  .navbar-icon-top.navbar-expand-md .navbar-nav .nav-link > .fa > .badge {
    top: -7px;
  }
}

@media (min-width: 992px) {
  .navbar-icon-top.navbar-expand-lg .navbar-nav .nav-link {
    text-align: center;
    display: table-cell;
    height: 70px;
    vertical-align: middle;
    padding-top: 0;
    padding-bottom: 0;
  }

  .navbar-icon-top.navbar-expand-lg .navbar-nav .nav-link > .fa {
    display: block;
    width: 48px;
    margin: 2px auto 4px auto;
    top: 0;
    line-height: 24px;
  }

  .navbar-icon-top.navbar-expand-lg .navbar-nav .nav-link > .fa > .badge {
    top: -7px;
  }
}

@media (min-width: 1200px) {
  .navbar-icon-top.navbar-expand-xl .navbar-nav .nav-link {
    text-align: center;
    display: table-cell;
    height: 70px;
    vertical-align: middle;
    padding-top: 0;
    padding-bottom: 0;
  }

  .navbar-icon-top.navbar-expand-xl .navbar-nav .nav-link > .fa {
    display: block;
    width: 48px;
    margin: 2px auto 4px auto;
    top: 0;
    line-height: 24px;
  }

  .navbar-icon-top.navbar-expand-xl .navbar-nav .nav-link > .fa > .badge {
    top: -7px;
  }
}

.display-none{
	display: none;
}

</style>
</head>
<body>
<s:hidden key="testID" />
<s:hidden key="loginId" />
<%-- <div class="container">
		<div class="loader text-center">
    		<span class="span"></span>
		</div>
 		<div class="row">
 			<div class="col-md-12">
 				<!-- <div class="back-sign">
 					<a href="auth-page" class="btn btn-outline-warning btn-md">Back</a>
 				</div> -->
	 			<div class="sign-out">
	            	<a onclick="clearSessionValues();" href="#" class="btn btn-outline-primary btn-md"><i class="fa fa-sign-out"></i>Log out</a>
	         	</div>
	        </div>
 		</div>
 		<div class="row" style="margin-top:1rem;">
 			<div class="col-md-12">
	 			<h4 class="mb30 text-center" id="test-name"></h4>
	 			<div class="text-success text-left" style="float: left;"><button class="btn btn-primary">SUBMIT TEST</button></div>
	            <!-- <div class="text-danger text-right" id="test-time" style="float: right;"></div> -->
	            <div class="text-right" style="float:right;">
	            	<div id="clockdiv"> 
						<div> 
							<span class="hours" id="hour"></span> 
							<div class="smalltext">Hours</div> 
						</div> 
						<div> 
							<span class="minutes" id="minute"></span> 
							<div class="smalltext">Minutes</div> 
						</div> 
						<div> 
							<span class="seconds" id="second"></span> 
							<div class="smalltext">Seconds</div> 
						</div> 
						</div> 
	            </div>
	        </div>
 		</div>
 		<div class="row"  style="margin-top:1rem;" id="examset">
		</div>
</div> --%>

<!-- Overlay for fixed sidebar -->
<div class="sidebar-overlay"></div>

<!-- Material sidebar -->
<aside id="sidebar" class="sidebar sidebar-colored open" role="navigation">
    <!-- Sidebar header -->
    <div class="sidebar-header header-cover">
        <!-- Top bar -->
        <div class="top-bar"></div>
        <!-- Sidebar brand image -->
        <div class="sidebar-image">
            <img src="https://aesusdesign.com/wp-content/uploads/2019/06/mans-blank-profile-768x768.png">
        </div>
        <!-- Sidebar brand name -->
        <a data-toggle="dropdown" id="user-logged-id" class="sidebar-brand" href="#">
        </a>
    </div>

    <!-- Sidebar navigation -->
    <ul class="nav sidebar-nav">
        <li>
            <a href="#" class="sidebar-menu" id="exam-instructions-menu">
               <i class="sidebar-icon fa fa-sticky-note-o" aria-hidden="true"></i>
                Exam Instructions
            </a>
        </li>
        <li>
            <a href="#" class="sidebar-menu" id="exam-set-menu">
                <i class="sidebar-icon fa fa-newspaper-o" aria-hidden="true"></i>
                Exam Set
            </a>
        </li>
        <li>
            <a href="#" onclick="clearSessionValues();">
                <i class="sidebar-icon fa fa-sign-out" aria-hidden="true"></i>
                Logout
            </a>
        </li>
        <li class="divider"></li>
    </ul>
    <!-- Sidebar divider -->
    <!-- <div class="sidebar-divider"></div> -->
    
    <!-- Sidebar text -->
    <!--  <div class="sidebar-text">Text</div> -->
</aside>

<div class="wrapper">
    <!-- Sidebar Constructor -->
    <div class="constructor">
	<nav class="navbar navbar-icon-top navbar-expand-lg navbar-dark bg-dark">
  <div class="collapse navbar-collapse" id="navbarSupportedContent" style="height:70px">
    <%-- <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">
          <i class="fa fa-home"></i>
          Home
          <span class="sr-only">(current)</span>
          </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-envelope-o">
            <span class="badge badge-danger">11</span>
          </i>
          Link
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">
          <i class="fa fa-envelope-o">
            <span class="badge badge-warning">11</span>
          </i>
          Disabled
        </a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fa fa-envelope-o">
            <span class="badge badge-primary">11</span>
          </i>
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
    </ul> --%>
    <div class="text-success text-left" style="float: left;"><button class="btn btn-primary">SUBMIT TEST</button></div>
    <div class="text-right" style="float:right;">
	            	<div id="clockdiv"> 
						<div> 
							<span class="hours" id="hour"></span> 
							<div class="smalltext">Hours</div> 
						</div> 
						<div> 
							<span class="minutes" id="minute"></span> 
							<div class="smalltext">Minutes</div> 
						</div> 
						<div> 
							<span class="seconds" id="second"></span> 
							<div class="smalltext">Seconds</div> 
						</div> 
						</div> 
	 </div>
    <ul class="navbar-nav display-none">
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-bell">
            <span class="badge badge-info">11</span>
          </i>
          Test
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">
          <i class="fa fa-globe">
            <span class="badge badge-success">11</span>
          </i>
          Test
        </a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0 display-none">
      <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>

<div class="row content-pane display-none" style="margin-top:1rem;" id="examset">
</div>
 		</div>
    </div>
</div>
</body>
</html>