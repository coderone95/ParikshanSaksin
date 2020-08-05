var isAlreadyChecked = false;
var isSelectedAllCheckBox = false;
$(document).ready(function(){
	$('#createGroupForm').on('submit', function(){
		var formInput=$(this).serialize();    
		$.getJSON('createGroup.action', formInput,function(data) {
			if(data.errorMsg != null && data.errorMsg != undefined){
				alert(data.errorMsg);
			}else{
				alert('Group created.')
				$('#groupId').val(data.GROUP_ID);
			}
		});  
		return false; 	
	});	
	$('#addQueBtn').on('click',function(){
		if($('#groupId').val() != "" && $('#groupId').val() != null){
			let optionList = [];
			let question = $('#question').val();
			let correctOption = $('#correctOption').val();
			let myoptions = {};
			let answerMode = $('#answerMode').val();
			let cnt = 0;
			let groupId = $('#groupId').val();
			$('.option').each(function(){
				optionList.push($(this).val());
				myoptions[cnt++] = $(this).val();
			});
			let data = {
					question : question,
					optionList : optionList,
					correctOption : correctOption.toString(),
					myoptions : myoptions,
					questionType: answerMode,
					groupId : groupId
			};
			$.ajax({
				type : "POST",
				url : "addQuestion",
				data: JSON.stringify(data),
				dataType: 'json',
				contentType:"application/json;charset=utf-8",
				success : function(data) {
					if(data.successMsg != null && data.successMsg != undefined){
						alert(data.successMsg);
						applyQuestionsFilter('ON_LOAD');
					}else{
						if(data.errorMsg != null && data.errorMsg != undefined){
							alert(data.errorMsg);
						}
					}
				},
				 error : function(er) {
					alert("Error....!!");
				} 
			});
		}else{
			alert("Please create group first!!");
		}
	});
		$('#answerMode').on('click change', function(){
			if($(this).val() == 'multi-select'){
				$('#correctOption').attr('multiple',true);
			}else{
				$('#correctOption').attr('multiple',false);
			}
		});
		$('#updateAnswerType').on('click change', function(){
			if($(this).val() == 'multi-select'){
				$('#updateCorrectOption').attr('multiple',true);
			}else{
				$('#updateCorrectOption').attr('multiple',false);
			}
		});
		
		$('.option').on('keyup blur', function(){
			selectCorrectOption();
		});
				$('#question').summernote({
			height: 200,
			width:800,
			popover: {
		         image: [],
		         link: [],
		         air: []
		    },
		    toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert', ['picture']],
			    ['view', ['codeview', 'help']]
			]
		});	
});

var count = 1;
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
					var correctOptionSelection = '';
					var cnt = 65;
					let questionType = itr.questionDetail.questionType;
					if(questionType != null && questionType == 'multi-select'){
						$('#updateCorrectOption').attr('multiple',true);
						let ele = document.getElementById('updateAnswerType');
						ele.value = 'multi-select';
					}else{
						let ele = document.getElementById('updateAnswerType');
						ele.value = 'radio';
					}

					for(var optionID in itr.questionDetail.optionsMap){
						var str = '';
						if (itr.questionDetail.optionsMap.hasOwnProperty(optionID)){
							var selectedOption ='';
							var option = itr.questionDetail.optionsMap[optionID];
							let answerList = itr.questionDetail.answer.split("answer-delimiter");
							str += '<li value="'+optionID+'" id="option-'+optionID+'"> <b class="option-var">&#'+cnt+';</b>. <textarea style="padding:0.4rem; " class="option-item update-question-field ml-1 option-item-'+optionID+'"></textarea></li><br>';
							$('#updateOptions').append(str);
							$('.option-item-'+optionID).val(option);
							if(isCorrectAnswer(answerList,option)){
								selectedOption = 'selected';
								correctOptionSelection += '<option value="'+optionID+'" '+selectedOption+'> &#'+cnt+';</option>';
							}else{
								correctOptionSelection += '<option value="'+optionID+'"> &#'+cnt+';</option>';
							} 
						}
						cnt++;
					}
					
					$('#updateCorrectOption').append(correctOptionSelection);

					triggerSummerNoteForUpdateQustionOption();
					//$('#answer').append('Answer: &#'+ans+';');
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}

	function triggerSummerNoteForUpdateQustionOption(){
		$('#updateQuestion_name').summernote({
			height: 200,
			width:700,
			popover: {
		         image: [],
		         link: [],
		         air: []
		    },
		    toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['insert', ['picture']],
			    ['view', ['codeview', 'help']]
			]
		});
		$('.option-item').summernote({
			height: 200,
			width:700,
			popover: {
		         image: [],
		         link: [],
		         air: []
		    },
		    toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['insert', ['picture']],
			    ['view', ['codeview', 'help']]
			]
		});
	}

	function removeThisOption(optionID, count){
//		$('#option-'+optionID).remove();
//		arrangeOtherOptions(optionID);
		
	}
	function arrangeOtherOptions(optionID){
//		var count = 1;
//		$('.update-question-field').each(function(){
//			$('.option-var').html('');
//			$('.option-var').html(`&#${count};`);
//			count++;
//		});
	}
	function updateQue(){
//		if($('.custom-switch').hasClass('fa-toggle-on')){
			$('.questions-edit-loader').show();
			var questionID = localStorage.getItem("selelctedQuestionID");
			var questionValue = $('#updateQuestion_name').val();
			var optionItems = $('.option-item');
			var optionMap = {};
			let updateAnswerType = $('#updateAnswerType').val();
			
			var selectedCorrectOption = $('#updateCorrectOption').val();
			$(optionItems).each(function(){
				//optionMap.put($(this).parent().attr('value'),$(this).val())
				optionMap[$(this).parent().attr('value')] = $(this).val();
			});
			console.log(optionMap);
			
			var data = {
					selelctedQuestionID : questionID,
					selectedCorrectOption : selectedCorrectOption.toString(),
					optionMap : optionMap,
					questionValue : questionValue,
					questionType : updateAnswerType
			};
			$.ajax({
				type : "POST",
				url : "updateQuestionDetails",
				dataType: 'json',
				data: JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				success : function(data) {
					if(data.successMsg != undefined && data.successMsg != null){
						alert(data.successMsg);
						$('.questions-edit-loader').hide();
						$('#updateQuestionModal').modal('hide');
						applyQuestionsFilter('ON_LOAD');
					}else{
						if(data.errorMsg != undefined){
							alert(data.errorMsg);
						}
					}
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
				if(itr.questionDetail != undefined){
					if(itr.questionDetail != null){
						$('#questionName').html(itr.questionDetail.question);
						$('#questionName').prepend("<span>Q.</span>");
						let questionType = itr.questionDetail.questionType;
						let str = '';
						let cnt = 65;
						let ans;
						if(questionType != null && questionType == 'multi-select'){
							let countList = new Array();
							let answerList = itr.questionDetail.answer.split("answer-delimiter");
							for( let i = 0 ; i < itr.questionDetail.options.length; i++){
								if(isCorrectAnswer(answerList,itr.questionDetail.options[i])){
									countList.push(cnt);
								}
								str += '<li>'+itr.questionDetail.options[i]+'</li>';
								cnt++;
							}
							let answer = '';
							let count = 0
							for(let i in countList){
								if(count < (countList.length-1)){
									answer = answer + '\t&#'+countList[i]+';'+',';
									count++;
								}
								else{
									answer = answer + '\t&#'+countList[i]+';';
								}
							}
							$('.question-ans-type').text('Multiple Choice');
							$('#optionList').append(str);
							$('#answer').append(`Answer: \t${answer}`);
						}else{
							if(questionType != null && questionType == 'radio'){
								for( let i = 0 ; i < itr.questionDetail.options.length; i++){
									if(itr.questionDetail.answer == itr.questionDetail.options[i]){
										ans = cnt;
									}
									str += '<li>'+itr.questionDetail.options[i]+'</li>';
									cnt++;
								}
								$('.question-ans-type').text('Single Choice');
								$('#optionList').append(str);
								$('#answer').append('Answer: &#'+ans+';');
							}	
						}
					}		
				}else{
					alert(itr.re);
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}

	function isCorrectAnswer(answerList,value){
		for(let i in answerList){
			if(answerList[i] == value){
				return true;
			}
		}
		return false;
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
			success : function(data) {
				if(data.successMsg != undefined && data.successMsg != null){
					alert(data.successMsg);
				}else{
					if(data.errorMsg != undefined && data.errorMsg != null){
						alert(data.errorMsg);
					}
				}
				$('#deleteModal').modal('hide');
				applyQuestionsFilter('ON_LOAD');
				//getAllQuestions();
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	function addOption(id, flag){
		var optionArea = $('#'+id);
		var idCount = count++;
		str = '<div id="option-div-'+ idCount +'"><label class="mr-2">Option</label>'
			+'<a href="#" onclick="deleteOption(\''+idCount+'\');" style="color:red"><i class="fa fa-trash-o fa-lg delete-option-icon"></i></a>'
			+'<div class="row"><div class="col-md-8"><textarea class="form-control option"  rows="1" ></textarea>'
			+'</div></div></div>';
		$(optionArea).append(str);
		if(flag == 'y'){
			selectCorrectOption();
		}
		triggerSummerNoteForOption();
	}
	
	function triggerSummerNoteForOption(){
		$('.option').summernote({
			height: 200,
			width:800,
			popover: {
		         image: [],
		         link: [],
		         air: []
		    },
		    toolbar: [
			    // [groupName, [list of button]]
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['insert', ['picture']],
			    ['view', ['codeview', 'help']]
			]
		});
	}
	function deleteOption(cnt){
		if($('.delete-option-icon').length == 1){
			alert('At least one option must be available');
		}else{
			$('#option-div-'+cnt).remove();
			count--;
			selectCorrectOption();
		}
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
	function applyQuestionsFilter(flag){
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
		$('.questions-table-loader').show();
		$('#questions-table-body').html('');
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
				var str = '';
				if (itr.QUESTION_REPORT != null && itr.QUESTION_REPORT.length > 0) {
					if ($.fn.DataTable.isDataTable("#qTable")) {
						  $('#qTable').DataTable().clear().destroy();
					}
					for (var i = 0; i < itr.QUESTION_REPORT.length; i++) {
						var queID = itr.QUESTION_REPORT[i].question_id;
						var question = itr.QUESTION_REPORT[i].question;
						var ans = itr.QUESTION_REPORT[i].answer;
						var createdBy = itr.QUESTION_REPORT[i].question_createdBy;
						var updatedBy = itr.QUESTION_REPORT[i].question_updatedBy;
//						str += '<tr><th scope="row"><a href="#" onclick="showQuestionDetails('+queID+');">'+queID+'</a></th>'
//							+'<td>'+question+'</td>'
//							//+'<td>'+ans+'</td>'
//							+'<td>'+createdBy+'</td>'
//							+'<td>'+updatedBy+'</td>'
//							+'<td><i class="fa fa-trash delete text-danger" onclick="deleteThis('+queID+');"></i><i class="fa fa-pencil edit text-primary" onclick="updateQuestion('+queID+');"></i></td>'
//							+'</tr>';
						var str = '<tr>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;"><a href="#" onclick="showQuestionDetails('+queID+');">'+queID+'</a></td>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;">'+question+'</td>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;">'+createdBy+'</td>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;">'+updatedBy+'</td>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;">';
						if(itr.hasQuestionDeleteAccess == false &&  itr.hasQuestionEditAccess == false){
							str=str+'No ACTION';
						}else{
							if(itr.hasQuestionDeleteAccess == true)
								str=str+'<i class="fa fa-trash delete text-danger" onclick="deleteThis('+queID+');"></i>';
							if(itr.hasQuestionEditAccess == true)
								str=str+'<i class="fa fa-pencil edit text-primary" onclick="updateQuestion('+queID+');"></i>';
						}
						str=str+'</td>';
						str=str+'</tr>';
						$('#questions-table-body').append(str);
					}
					$("#qTable").DataTable();
//					$("#qTable").DataTable( {
//				        "scrollY":        '90vh',
//				        "scrollCollapse": true,
//				        "paging":         true,
//						"scrollX": false,
//						"ordering": true,
//						"info":     true,
//						"searching": true,
//						"destroy": true,
//					    'colReorder': {
//					        'allowReorder': false
//					    }
//				    } );
					$('.questions-table-loader').hide();

				}else{
					str += '<tr><td colspan="6"><div class="text-center"> No record found </div></td></tr>';
					$('#questions-table-body').append(str);
					$('.questions-table-loader').hide();
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
		$('#questionFilterModal').modal('hide');
	}
	function formatMyDate(date) {
		  var day = date.getDate();
		  var monthIndex = date.getMonth();
		  monthIndex = monthIndex +1;
		  var year = date.getFullYear();
		  return day+'-'+monthIndex+'-'+year;
		}