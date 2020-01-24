/**
 * 
 */

$(document).ready(function(){
		addOption('option-area','y');
		//getAllQuestions();
		/* $('.selectpicker').datetimepicker({
	        'showTimepicker': false,
	        format: 'DD-MM-YYYY'
	    }); */
	    $('.datepicker').datepicker({
	    	format: "yyyy-mm-dd",
	    	todayHighlight : true,
	    	language:'en',
	    	/* todayBtn: true, */
	    	clearBtn : true,
	    	autoclose : true
	    });
	    $('.datepicker').datepicker('setDate', new Date());
	    applyQuestionsFilter('ON_LOAD');
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
						applyQuestionsFilter('ON_LOAD');
					}else{
						if(itr.errorMsg != null && itr.errorMsg != ''){
							alert(itr.errorMsg);
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
//		$('.custom-switch').on('click',function(){
//			if($(this).hasClass('fa-toggle-on')){
//				$(this).removeClass('fa-toggle-on');
//				$(this).addClass('fa-toggle-off');
//				toggleSwitch('on');
//			}else if($(this).hasClass('fa-toggle-off')){
//				$(this).removeClass('fa-toggle-off');
//				$(this).addClass('fa-toggle-on');
//				toggleSwitch('off');
//			}
//		});
	});
	function formatDate(date) {
	  var day = date.getDate();
	  var monthIndex = date.getMonth();
	  var year = date.getFullYear();
	  return year+'-'+monthIndex+'-'+day;
	}
//	function toggleSwitch(flag){
//		var fields = $('.update-question-field');
//		if(flag == 'off'){
//			$(fields).each(function(index){
//				$(this).removeAttr('disabled');
//			});	
//		}else{
//			$(fields).each(function(index){
//				$(this).attr('disabled','true');
//			});
//		}
//	}
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
					var str = '';
					var correctOptionSelection = '';
					var cnt = 65;
					for(var optionID in itr.questionDetail.optionsMap){
						if (itr.questionDetail.optionsMap.hasOwnProperty(optionID)){
							var selectedOption ='';
							var option = itr.questionDetail.optionsMap[optionID];
							str += '<li value="'+optionID+'" id="option-'+optionID+'"> <b class="option-var">&#'+cnt+';<b>. <input type="text" style="padding:0.4rem; " class="option-item update-question-field ml-1" value="'+option+'" /></li><br>';
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
					$('.questions-edit-loader').hide();
					$('#updateQuestionModal').modal('hide');
					//getAllQuestions();
					applyQuestionsFilter('ON_LOAD');
//					toggleSwitch('on'); 
					
				},
				error : function(itrr) {
					alert("Error occurred while getting question details..!!");
				}
			});
//		}else{
//			alert('Enable editing mode!!');
//		}
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
		str = '<div id="option-div-'+ idCount +'"><label>Option</label>'
			+'<div class="row"><div class="col-md-8"><textarea class="form-control option"  rows="1" ></textarea>'
			+'</div><div class="col-md-4"><a href="#" onclick="deleteOption(\''+idCount+'\');" style="color:red"><i class="fa fa-trash-o fa-lg delete-option-icon"></i></a></div></div></div>';
		$(optionArea).append(str);
		if(flag == 'y'){
			selectCorrectOption();
		}
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
				if (itr.questionInfo != null && itr.questionInfo.length > 0) {
					if ($.fn.DataTable.isDataTable("#qTable")) {
						  $('#qTable').DataTable().clear().destroy();
					}
					for (var i = 0; i < itr.questionInfo.length; i++) {
						var queID = itr.questionInfo[i].question_id;
						var question = itr.questionInfo[i].question;
						var ans = itr.questionInfo[i].answer;
						var createdBy = itr.questionInfo[i].question_createdBy;
						var updatedBy = itr.questionInfo[i].question_updatedBy;
//						str += '<tr><th scope="row"><a href="#" onclick="showQuestionDetails('+queID+');">'+queID+'</a></th>'
//							+'<td>'+question+'</td>'
//							//+'<td>'+ans+'</td>'
//							+'<td>'+createdBy+'</td>'
//							+'<td>'+updatedBy+'</td>'
//							+'<td><i class="fa fa-trash delete text-danger" onclick="deleteThis('+queID+');"></i><i class="fa fa-pencil edit text-primary" onclick="updateQuestion('+queID+');"></i></td>'
//							+'</tr>';
						var str = '<tr>';
						str=str+'<td class="text-nowrap"><a href="#" onclick="showQuestionDetails('+queID+');">'+queID+'</a></td>';
						str=str+'<td class="text-nowrap">'+question.substring(0,10)+ '...'+'</td>';
						str=str+'<td class="text-nowrap">'+createdBy+'</td>';
						str=str+'<td class="text-nowrap">'+updatedBy+'</td>';
						str=str+'<td class="text-nowrap">';
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
	
