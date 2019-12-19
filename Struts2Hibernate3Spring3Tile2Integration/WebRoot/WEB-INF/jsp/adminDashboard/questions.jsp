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
 <sx:head />
<script
	src="./assets/js/core/jquery.min.js"></script>
<script
	src="./assets/js/bootstrap-select.min.js"></script>
	<style>
	.padding-0-6-rem{
		padding: 0.6rem;
	}
	</style>

<script>
	$(document).ready(function(){
		addOption('option-area','y');
		getAllQuestions();
		
		$('#addQueBtn').on('click',function(){
			var optionList = [];
			var question = $('#question').val();
			var correctOption = $('#correctOption').val();
			var myoptions = {};
			var cnt = 0;
			$('.option').each(function(){
				optionList.push($(this).val());
				myoptions[cnt++] = $(this).val();
			});
			var data = {
					question : question,
					optionList : optionList,
					correctOption : correctOption,
					myoptions : myoptions
			};
			$.ajax({
				type : "POST",
				url : "addQuestion",
				data: JSON.stringify(data),
				dataType: 'json',
				contentType:"application/json;charset=utf-8",
				success : function(itr) {
					if(itr.successMessageList != null && itr.successMessageList.length > 0){
						alert("Question added successfully");
						getAllQuestions();
					}else{
						if(itr.errorMessagesList != null && itr.errorMessagesList.length > 0){
							alert("Question already exists!");
						}else{
							alert("Error while processing the request");	
						}
					}
				}
				/* error : function(itr) {
					alert("Error....!!");
				} */
			});
		});
		$('.option').on('keyup blur', function(){
			selectCorrectOption();
		});
		$('#searchQuestion').on('keyup keydown', function(){
			var searchKey = $(this).val();
			var data = {
					searchKey : searchKey	
			};
			$.ajax({
				type : "POST",
				url : "getSearchedQuestion",
				data: JSON.stringify(data),
				dataType: 'json',
				contentType:"application/json;charset=utf-8",
				success : function(itr) {
					
				}
				/* error : function(itr) {
					alert("Error....!!");
				} */
			});
		});
		$('.custom-switch').on('click',function(){
			if($(this).hasClass('fa-toggle-on')){
				$(this).removeClass('fa-toggle-on');
				$(this).addClass('fa-toggle-off');
				toggleSwitch('on');
			}else if($(this).hasClass('fa-toggle-off')){
				$(this).removeClass('fa-toggle-off');
				$(this).addClass('fa-toggle-on');
				toggleSwitch('off');
			}
		});
	});
	
	function toggleSwitch(flag){
		var fields = $('.update-question-field');
		if(flag == 'off'){
			$(fields).each(function(index){
				$(this).removeAttr('disabled');
			});	
		}else{
			$(fields).each(function(index){
				$(this).attr('disabled','true');
			});
		}
	}
	var count = 1;
	function getAllQuestions(){
		$('#questions-table-body').html('');
		$.ajax({
			type : "POST",
			url : "getAllQuestions",
			success : function(itr) {
				var str = '';
				if (itr.questionInfo != null && itr.questionInfo.length > 0) {
					for (var i = 0; i < itr.questionInfo.length; i++) {
						var queID = itr.questionInfo[i].question_id;
						var question = itr.questionInfo[i].question;
						var ans = itr.questionInfo[i].answer;
						var createdBy = itr.questionInfo[i].question_createdBy;
						var updatedBy = itr.questionInfo[i].question_updatedBy;
						
						str += '<tr><th scope="row"><a href="#" onclick="showQuestionDetails('+queID+');">'+queID+'</a></th>'
							+'<td>'+question+'</td>'
							+'<td>'+ans+'</td>'
							+'<td>'+createdBy+'</td>'
							+'<td>'+updatedBy+'</td>'
							+'<td><button class="btn btn-outline-danger" onclick="deleteThis('+queID+');"><i class="fa fa-trash"></i></button>|<button class="btn btn-outline-primary" onclick="updateQuestion('+queID+');"><i class="fa fa-pencil"></i></button></td>'
							+'</tr>';
					}
					$('#questions-table-body').append(str);

				}else{
					str += '<div class="text-center"> No record found </div>';
					$('#questions-table-body').append(str);
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting all questions...!!");
			}
		});
	}
	function updateQuestion(queID){
		localStorage.removeItem("selelctedQuestionID");
		localStorage.setItem("selelctedQuestionID",queID);
		updateQestionDetails(queID);
		$('#updateQuestionModal').modal('show');
	}
	function updateQestionDetails(quesID){
		$('#updateOptions').html('');
		//$('#updateOptions').text('');
		$('#updateCorrectOption').html('');
		var data = {
				quesID : quesID
		};
		$.ajax({
			type : "POST",
			url : "getQuestionDetails",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if(itr.questionDetail != null){
					$('#updateQuestion_name').val(itr.questionDetail.question);
					var str = '';
					var correctOptionSelection = '';
					var cnt = 65;
					for(var optionID in itr.questionDetail.optionsMap){
						if (itr.questionDetail.optionsMap.hasOwnProperty(optionID)){
							var selectedOption ='';
							var option = itr.questionDetail.optionsMap[optionID];
							str += '<li value="'+optionID+'"><input type="text" style="padding:0.4rem; " class="option-item update-question-field" value="'+option+'" disabled /></li><br>';
							if(itr.questionDetail.answer == option){
								selectedOption = 'selected';
								correctOptionSelection += '<option value="'+optionID+'" '+selectedOption+'> &#'+cnt+';</option>';
							}else{
								correctOptionSelection += '<option value="'+optionID+'"> &#'+cnt+';</option>';
							} 
						}
						cnt++;
					}
					$('#updateOptions').append(str);
					$('#updateCorrectOption').append(correctOptionSelection);
					//$('#answer').append('Answer: &#'+ans+';');
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}
	function updateQue(){
		var questionID = localStorage.getItem("selelctedQuestionID");
		var questionValue = $('#updateQuestion_name').val();
		var optionItems = $('.option-item');
		var optionMap = {};
		
		var selectedCorrectOption = $('#updateCorrectOption').val();
		$(optionItems).each(function(){
			//optionMap.put($(this).parent().attr('value'),$(this).val())
			optionMap[$(this).parent().attr('value')] = $(this).val();
		});
		console.log(optionMap);
		
		var data = {
				selelctedQuestionID : questionID,
				selectedCorrectOption : selectedCorrectOption,
				optionMap : optionMap,
				questionValue : questionValue
		};
		$.ajax({
			type : "POST",
			url : "updateQuestionDetails",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert("Question Updated successfully!!");
				$('#updateQuestionModal').modal('hide');
				getAllQuestions();
				/* toggleSwitch('on'); */
				
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
		
	}
	function showQuestionDetails(queID){
		getQuestionDetails(queID);
		$('#showQuestionDetailsModal').modal('show');
	}
	function getQuestionDetails(queID){
		$('#optionList').html('');
		$('#answer').html('');
		$('#questionName').text('');
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
						$('#questionName').text(itr.questionDetail.question);
						var str = '';
						var cnt = 65;
						for( var i = 0 ; i < itr.questionDetail.options.length; i++){
							if(itr.questionDetail.answer == itr.questionDetail.options[i]){
								ans = cnt;
							}
							str += '<li>'+itr.questionDetail.options[i]+'</li>';
							cnt++;
						}
						$('#optionList').append(str);
						$('#answer').append('Answer: &#'+ans+';');
					}					
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}
	function deleteThis(queID){
		$('#deleteModal').modal('show');
		$('#deleteBtn').removeAttr('onclick');
		$('#deleteBtn').attr('onclick','deleteQuestion('+queID+');');
	}
	function deleteQuestion(queID){
		
		var data = {
				queID : queID
		};
		$.ajax({
			type : "POST",
			url : "deleteQuestion",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert("Question deleted");
				$('#deleteModal').modal('hide');
				getAllQuestions();
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	function addOption(id, flag){
		var optionArea = $('#'+id);
		var idCount = count++;
		str = '<div id="option-div-'+ idCount +'"><label>Option</label>'
			+'<div class="row"><div class="col-md-8"><textarea class="form-control option"  rows="1" ></textarea>'
			+'</div><div class="col-md-4"><a href="#" onclick="deleteOption(\''+idCount+'\');" style="color:red"><i class="fa fa-trash-o fa-lg"></i></a></div></div></div>';
		$(optionArea).append(str);
		if(flag == 'y'){
			selectCorrectOption();
		}
	}
	
	function deleteOption(cnt){
		$('#option-div-'+cnt).remove();
		count--;
		selectCorrectOption();
	} 
	function selectCorrectOption(){
		$('#correctOption').html('');
		var str = '';
		var cnt = 0;
		$('.option').each(function(){
			var option = cnt+1;
			str += '<option value="'+cnt+'">Option '+ option +'</option>';
			cnt++;
		});
		$('#correctOption').append(str);
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
</style>

</head>

<body class="">
	<input type="hidden" id="pageId" value="questions" />
	<input type="hidden" id="page" value="Questions" />
		
	<div class="wrapper ">
		<jsp:include page="adminSideBar.jsp"></jsp:include>
		<div class="main-panel">
			<jsp:include page="adminDashboardTopNav.jsp"></jsp:include>
			<!-- <div class="panel-header panel-header-sm">

</div> -->
			<div class="content">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="card-header">
								<h4 id="user-form-card-heading">Add New Question</h4>
								<div class="error-div" style="display: none;">
											<div class="err"
												style="padding: 0.5rem; border: 1px solid red;"></div>
								</div>
							</div>
							<div class="card-body" id="">
									<div class="row">
										<div class="msg-div" style="display: none;color:#008000;margin: 0.5rem;">
											<div class="msg"
												style="padding: 0.1rem; border: 1px solid #008000;"></div>
										</div>
										
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label>Question</label> 
												<textarea class="form-control" name="question" rows="4" id="question"></textarea>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-10 pr-1">
											<div class="form-group" id="option-area">
											</div>
										</div>
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<a href="#" onclick="addOption('option-area','y');">
													<i class="fa fa-plus-circle fa-lg"></i> Add option
												</a>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-8 pr-1">
											<div class="form-group">
												<label> Correct Answer</label>
												<select id="correctOption" class="form-control"></select>
											</div>											
										</div>
									</div>
									</div>
									<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" id="addQueBtn" class="btn btn-primary btn-round" value="Add Question">
										</div>
									</div>
							</div>
						</div>
						<div class="col-md-12">
			           <div class="card">
			              <div class="card-header"></div>
			              <div class="card-body" id="questions-card-body">
			              	<div class="table-responsive">
                  				<table class="table">
                    				<thead class=" text-primary">
                      						<th>Question ID</th>
											<th>Question</th>
											<th>Answer</th>
											<th>Created By</th>
											<th>Updated By</th>
											<th>Action</th>
                    				</thead>
			                    <tbody id="questions-table-body">
			                    
			                    </tbody>
			                  </table>
			                </div>
			              </div>
			           </div>
			       </div>
					</div>
				</div>
			</div>
			<jsp:include page="adminDashboardFooter.jsp" />
		</div>
	
	<div class="modal fade" id="showQuestionDetailsModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<b style="font-size:1.5rem;" class="modal-title">Question</b>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="card-header">
								
							</div>
							<div class="card-body" id="question-options-card-body">
							<div class="row">
								<div class="col-md-12" id="questionArea">
									<h5 id="questionName"></h5>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" id="optionsArea">
									<ol type="A"  id="optionList">
										
									</ol>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12" id="answerArea">
									<hr>
									<b id="answer"></b>
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
	
	<div class="modal fade" id="updateQuestionModal" role="dialog">
    <div class="modal-dialog" style="min-width: 900px;max-width: 900px;">
    
      <!-- Modal content-->
      <div class="modal-content">
       <div class="modal-header">
       		<h5 class="modal-title">Update Question</h5>
        	<button type="button" style="font-size: 2.5rem;" class="close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card demo-icons">
							<div class="card-header">
								<div class="card-options">
									<i class="fa fa-toggle-off custom-switch"></i>
								</div>
							</div>
							<div class="card-body">
								<div class="row">
									<div class="col-md-12 pr-1">
										<div class="form-group">
											<label>Question</label> 
											<textarea class="form-control update-question-field" name="question" id="updateQuestion_name" disabled></textarea>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 pr-1">
										<div class="form-group" id="">
											<div id="updateOptions">
												
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12 pr-1">
										<div class="form-group" id="updateAnswer_name">
											<label>Select Answer</label> 
											<select id="updateCorrectOption" class="form-control update-question-field" disabled="true"></select>
										</div>
									</div>
								</div>
								<div class="row">
										<div class="update ml-auto mr-auto">
											<input type="button" id="updateQueBtn" class="btn btn-primary btn-round" onclick="updateQue();" value="Update Question">
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
<!--Delete Modal -->
		  <div class="modal" id="deleteModal">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <!-- Modal body -->
		        <div class="modal-body">
		          <p>Do you want to delete it?</p>
		          <div class="row">
		          		<div class="col-md-6">
		          			<button type="button" style="float:right;" class="btn btn-danger" id="deleteBtn">Yes</button>
		          		</div>
		          		<div class="col-md-6">
		          			<button type="button" class="btn btn-primary" data-dismiss="modal">No</button>
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
