<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
 



<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="./assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="./assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Admin Dashboard</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
	
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
	
<!-- CSS Files -->
<link href="./assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="./assets/css/paper-dashboard.css?v=2.0.0" rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="./assets/demo/demo.css" rel="stylesheet" />
<link href="./assets/css/dashboard-common.css" rel="stylesheet" />
<link href="./assets/css/loader.css" rel="stylesheet" />
<!-- <link href="./assets/css/bootstrap-datetimepicker.min.css" rel="stylesheet" /> -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css" rel="stylesheet" /> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script
	src="./assets/js/core/jquery.min.js"></script>
<script
	src="./assets/js/bootstrap-select.min.js"></script>
	<style>
	.padding-0-6-rem{
		padding: 0.6rem;
	}
	</style>
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
.padding-0-6-rem{
	padding: 0.6rem;
}
.custom-switch{
	cursor:pointer;
	float:right;
	font-size: 2rem;
}
.fa-toggle-on, .fa-toggle-off{
	color:#51cbce;
}
#updateOptions li{
	 list-style: none;
}
.filter-icon {
border-radius: 5px;
    cursor: pointer;
    padding: 0.5rem;
    font-size: 23px;
    background: #0b1961;
    color: #fff;
}
.table-responsive {
    overflow: auto !important;
}
.card-no-box-shadow {
	box-shadow: unset;
}
.delete , .edit{
	padding: 0.5rem;
    cursor: pointer;
}
.datepicker.datepicker-dropdown.dropdown-menu.datepicker-orient-left.datepicker-orient-bottom {
    box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important;
    font-size: unset;
    padding: 1rem;
}
.que-bank-row{
	padding: 1rem;
	background: yellow;
}

</style>
<script>
	$(document).ready(function(){
		 $('.datepicker').datepicker({
		    	format: "yyyy-mm-dd",
		    	todayHighlight : true,
		    	language:'en',
		    	/* todayBtn: true, */
		    	clearBtn : true,
		    	autoclose : true
		    });
		$('.datepicker').datepicker('setDate', new Date());
		applyQuestionsAnswersBankFilter('ON_LOAD');
	});
	
	function applyQuestionsAnswersBankFilter(flag){
		$('.questions-answer-bank-loader').show();
		 $('.question-ans-bank-area').html('');
		var startDate = '';
		var endDate = ''; 
		if(flag == 'ON_LOAD'){
			startDate = '';
			endDate = '';
		}else{
			if($('#startDate').val() != ''){
				startDate = $('#startDate').val() + " 00:00:00";
			}
			
			if($('#endDate').val() != ''){
				endDate = $('#endDate').val() + " 23:59:00";
			}
		}
		var questionName = $('#byQuestionName').val();
		var questionId = $('#byQuestionId').val();
		var createdBy = $('#createdBy').val();
		
		var data = {
				startDate : startDate,
				endDate : endDate,
				questionName : questionName,
				questionId : +questionId,
				createdBy : createdBy
		};
		
		$.ajax({
			type : "POST",
			url : "getQuestionReport",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if (itr.questionInfo != null && itr.questionInfo.length > 0) {
					for (var i = 0; i < itr.questionInfo.length; i++) {
						var queID = itr.questionInfo[i].question_id;
						//console.log(queID);
						getQuestionDetails(queID);
					}
				}else{
					$('.question-ans-bank-area').html('<div class="text-center"> No record found </div>');
				}
				$('.questions-answer-bank-loader').hide();
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
		$('#questionFilterModal').modal('hide');
	}
	
	function getQuestionDetails(queID){
		var str ='';
		var correctAns = '';
		var data = {
				quesID : queID
		};
		$.ajax({
			type : "POST",
			url : "getQuestionDetails",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if(itr.re.status == 403 && itr.re != null ){
					alert("Unable to fetch question details");
				}else{
					if(itr.questionDetail != null){
						str += '<div class="que-bank-row" style="padding: 1rem;background: yellow;"><div class="row mt-4"><div class="col-md-12 questionArea">'
								+'<h5 class="questionName">'+itr.questionDetail.question+'</h5></div></div>';
						str += '<div class="row"><div class="col-md-12 optionsArea">';
						var cnt = 65;
						for( var i = 0 ; i < itr.questionDetail.options.length; i++){
							if(itr.questionDetail.answer == itr.questionDetail.options[i]){
								ans = cnt;
								correctAns = '<i class="fa fa-check-circle ml-2" style="font-size:20px;color:#198764;"></i>';
								/* str += '<li>'+itr.questionDetail.options[i]+'<b class="ml-1" style="color:#198764;">CORRECT</b></li>';	 */
								str += '<p> &#'+cnt+'; . '+itr.questionDetail.options[i]+'  '+correctAns+'</p>';
							}else{
								str += '<p> &#'+cnt+'; . '+itr.questionDetail.options[i]+'</p>';	
							}
							cnt++;
						}
						str += '</div></div>';
						str += '<div class="row mb-2 shadow"><div class="col-md-12 answerArea"><b class="answer">Answer: &#'+ans+';</b></div></div></div><hr>';
						 $('.question-ans-bank-area').append(str);
					}
					
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}

/* 	function exportM(){
	var doc = new jsPDF();
	var specialElementHandlers = {
	    '#editor': function (element, renderer) {
	        return true;
	    }
	};
	    doc.fromHTML($('.question-ans-bank-area').html(), 15, 15, {
	        'width': 170,
	            'elementHandlers': specialElementHandlers
	    });
	    doc.save('question-answer-bank12.pdf');
	} */
	 function exportToPDF() {
        var pdf = new jsPDF('p', 'pt', 'letter');
        // source can be HTML-formatted string, or a reference
        // to an actual DOM element from which the text will be scraped.
        source = $('.question-ans-bank-area')[0];

        // we support special element handlers. Register them with jQuery-style
        // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
        // There is no support for any other type of selectors
        // (class, of compound) at this time.
        specialElementHandlers = {
            // element with id of "bypass" - jQuery style selector
            '#editor': function (element, renderer) {
                // true = "handled elsewhere, bypass text extraction"
                return true
            }
        };
        margins = {
            top: 80,
            bottom: 60,
            left: 40,
            width: 522
        };
        // all coords and widths are in jsPDF instance's declared units
        // 'inches' in this case
        pdf.fromHTML(
            source, // HTML string or DOM elem ref.
            margins.left, // x coord
            margins.top, { // y coord
                'width': margins.width, // max width of content on PDF
                'elementHandlers': specialElementHandlers
            },

            function (dispose) {
                // dispose: object with X, Y of the last line add to the PDF
                //          this allow the insertion of new lines after html
                pdf.save('question-ans-bank.pdf');
            }, margins
        );

    }
</script>
</head>

<body class="">
	<input type="hidden" id="pageId" value="questions" />
	<input type="hidden" id="page" value="Questions Answer Bank " />
		
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<!-- <div class="panel-header panel-header-sm">

</div> -->
			<div class="content">
				<div class="row">
					<div class="col-md-7 col-lg-6 col-sm-12 col-xs-12">
						
						</div>
						<div class="col-md-12">
			           <div class="card">
			              <div class="card-header">
								<a href="questionsPage"><i class="fa fa-arrow-left"></i> Back </a>
							</div>
							<div class="card-options text-right mr-1" style="margin-bottom: 0.2rem;">
								<i class="fa fa-filter filter-icon mr1" data-toggle="modal" data-target="#questionFilterModal"></i>
								<i class="fa fa-file-pdf-o filter-icon" onclick="exportToPDF();"></i>
							</div>
			              <div class="card-body" id="questions-bank-card-body">
			              <div id="editor"></div>
			              	<div class="loaddercontainer questions-answer-bank-loader" style="display:none">
								<div class="lds-ring">
							        <div></div>
							        <div></div>
							        <div></div>
							        <div></div>
								</div>
							</div>
			              	<div class="question-ans-bank-area">
			              		
			                </div>
			              </div>
			           </div>
			       </div>
					</div>
				</div>
			</div>
			<jsp:include page="adminDashboardFooter.jsp" />
		</div>
	<!-- Question Filter Modal -->
		  <div class="modal fade" id="questionFilterModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">Question Filters</h5>
		           <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->
		        <div class="modal-body">
		          	<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons card-no-box-shadow">
							<div class="card-body">
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>From Date</label> 
											<input type="text" id="startDate" class="form-control datepicker">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>To Date</label> 
											<input type="text" id="endDate" class="form-control datepicker">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Question ID</label> 
											<input type="number" id="byQuestionId" class="form-control">
										</div>
									</div>
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Created By</label> 
											<input type="text" id="createdBy" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 pr-1">
										<div class="form-group">
											<label>Question Name</label> 
											<input type="text" id="byQuestionName" class="form-control">
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" class="btn btn-primary btn-round" onclick="applyQuestionsAnswersBankFilter('on_filter');" value="Apply Filters">
											<input type="button" data-dismiss="modal" class="btn btn-primary btn-round close" value="Cancel">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
		        </div>
		      </div>
		    </div>
		  </div>        
	<!--   Core JS Files   -->
	<script src="./assets/js/core/jquery.min.js"></script>
	<script src="./assets/js/core/popper.min.js"></script>
	<script src="./assets/js/core/bootstrap.min.js"></script>
	<%-- <script src="./assets/js/bootstrap-datetimepicker.js"></script> --%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
	<script src="./assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
	<!-- Chart JS -->
	<script src="./assets/js/plugins/chartjs.min.js"></script>
	<!--  Notifications Plugin    -->
	<script src="./assets/js/plugins/bootstrap-notify.js"></script>
	<!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
	<script src="./assets/js/paper-dashboard.min.js?v=2.0.0"
		type="text/javascript"></script>
	<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
	<script src="./assets/demo/demo.js"></script>
	

</body>

</html>
