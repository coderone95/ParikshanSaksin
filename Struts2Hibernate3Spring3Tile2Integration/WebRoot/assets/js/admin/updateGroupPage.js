var isAlreadyChecked = false;
	var isSelectedAllCheckBox = false;
	var count = 1;
	$(document).ready(function(){
		var selectedID = $('#selectedId').val();
		getAddedQuestionsForSelectedGroup(selectedID);
		$('.groups-update-loader-row-1').show();
		$('.groups-update-loader-row-2').show();
		$('#selectAll').on('click',function(){
			if(!isAlreadyChecked){
				$('.selectQuestionCheckBox').each(function(){
					$(this).prop( "checked", true );
				});
				isAlreadyChecked = true;
				isSelectedAllCheckBox = true;
			}else{
				$('.selectQuestionCheckBox').each(function(){
					$(this).prop( "checked", false );
				});
				isAlreadyChecked = false;
			}
		});
		$('#addQueBtn').on('click',function(){
		if($('#selectedId').val() != "" && $('#selectedId').val() != null){
			let optionList = [];
			let question = $('#question').val();
			let correctOption = $('#correctOption').val();
			let myoptions = {};
			let answerMode = $('#answerMode').val();
			let cnt = 0;
			let groupId = $('#selectedId').val();
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
						getAddedQuestionsForSelectedGroup(selectedID);
					}else{
						if(data.errorMsg != null && data.errorMsg != undefined){
							alert(data.errorMsg);
							getAddedQuestionsForSelectedGroup(selectedID);
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
	
	function getAddedQuestionsForSelectedGroup(selectedGroupID){
		$('#u-group-questions-table-body').html('');
		$('#selectedGroupID').val(selectedGroupID);
		var data = {
				selectedGroupID: selectedGroupID
		};
		$.ajax({
			type : "POST",
			url : "getAddedQuestionsForSelectedGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				var str ='';
				if ($.fn.DataTable.isDataTable("#qTable")) {
					$('#qTable').DataTable().clear().destroy();
				}
				$('#u-group-name').val(localStorage.getItem("selectedGroupName"));
				$('#u-total-que').text(itr.totalQuestionsAddedForSelectGroup);
				if(itr.addedQuestionsList != null && itr.addedQuestionsList.length > 0){
					for(var i = 0 ; i < itr.addedQuestionsList.length;i++){
						var questionID = itr.addedQuestionsList[i].question_id;
						var question = itr.addedQuestionsList[i].question;
						var str = '<tr class="added-question ques-'+questionID+'" value="'+questionID+'">';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;">'+questionID+'</td>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;">'+question+'</td>';
						str=str+'<td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;"><button class="btn btn-outline-danger" onclick="removeThisQuestion('+selectedGroupID+','+questionID+');"><i class="fa fa-trash"></i></button></td>';
						str=str+'</tr>';
						$('#u-group-questions-table-body').append(str);
					}
					$("#qTable").DataTable();
					$('.groups-update-loader-row-1').hide();
				}else{
					str = '<div class="text-center"> No Questions are added!!</div>';
					$('#u-group-questions-table-body').append(str);
					$("#qTable").DataTable();
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function viewGroupDetails(selectedGroupID){
		$('#group-questions-table-body').html('');
		var data = {
				selectedGId : selectedGroupID,
		};
		$('#viewGroupDetailsModal').modal('show');
		$.ajax({
			type : "POST",
			url : "allAddedQuestionsOfSelectedGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				var str ='';
				$('#group-name').text('');
				$('#total-que').text(data.totalQuestionsAddedForSelectGroup);
				if(data.groupQuestionInfo != null && data.groupQuestionInfo.length > 0){
					for(var i = 0 ; i < data.groupQuestionInfo.length;i++){
						var questionID = data.groupQuestionInfo[i].question_id;
						var question = data.groupQuestionInfo[i].question;
						str += '<tr><td class="text-nowrap" style="max-height:50px;max-width:300px;overflow: auto;"><a href="#" onclick="showQuestionDetails('+questionID+');">'+questionID+'</a></td><td>'+question+'</td></tr>';
					}
					$('#group-questions-table-body').append(str);
				}else{
					str = '<div class="text-center"> No Questions are added!!</div>';
					$('#group-questions-table-body').append(str);
					$("#qTable").DataTable();
				}
			},
			error : function(itr) {
				let str = '<div class="text-center"> No Questions are added!!</div>';
				$('#group-questions-table-body').append(str);
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function removeThisQuestion(groupID,questionID){
		$('#deleteModal').modal('show');
		$('#deleteBtn').removeAttr('onclick');
		$('#deleteBtn').attr('onclick','removeSelectedQuestionFromGroup('+groupID+','+questionID+');');
	}
	function removeSelectedQuestionFromGroup(selectedGroupID,questionId){
		var data = {
				selectedGroupID : selectedGroupID,
				questionId : questionId
		};
		$.ajax({
			type : "POST",
			url : "removeSelectedQuestionFromGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				$('#deleteModal').modal('hide');
				$('.ques-'+questionId).fadeTo("slow",0.7, function(){
		            $(this).remove();
		            getAddedQuestionsForSelectedGroup(selectedGroupID);
		        })
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
	}
	
	function addThis(queID){
		$('#singleQuestionID').val(queID);
	}
	function addSelectedQuestionsToGroup(){
		var selectedGroupID = $('#selectedId').val();
		var selectedQuestionIDs = [];
		
			$('.selectQuestionCheckBox').each(function(){
				if($(this).prop('checked')){
					selectedQuestionIDs.push($(this).val());
				}
			});	
		var data = {
				selectedGroupID : selectedGroupID,
				selectedQuestionIDs : selectedQuestionIDs
		};
		$.ajax({
			type : "POST",
			url : "addSelectedQuestionsToGroup",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(data) {
				if(data.errorMessagesList != null && data.errorMessagesList.length > 0){
					alert(data.errorMessagesList[0].errorMsg);
				}else{
					alert("Questions added Successfully");
					$('#addQuestionToGroupModal').modal('hide');	
					getAddedQuestionsForSelectedGroup(selectedGroupID);
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
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
				if(itr.questionDetail != null && itr.questionDetail != undefined){
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
					
				}else{
					if(itr.re.status == 403 && itr.re != null ){
						alert(itr.re);
					}					
				}
			},
			error : function(itrr) {
				alert("Error occurred while getting question details..!!");
			}
		});
	}
	
	function updateGroupInfo(){
		var groupName = $('#u-group-name').val();
		var groupID = $('#selectedGroupID').val();
		var data = {
				selectedGroupID : groupID,
				groupName : groupName
		};
		$.ajax({
			type : "POST",
			url : "updateGroupInfo",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if(itr.errorMessagesList.length > 0 && itr.errorMessagesList != null){
					alert(itr.errorMessagesList[0].errorMsg);
				}else{
					alert("Group Updated successfully!!");
				}
			},
			error : function(itrr) {
				alert("Error occurred while updating group details..!!");
			}
		});
	}  
	function addOption(id, flag){
		var optionArea = $('#'+id);
		var idCount = count++;
		str = '<div id="option-div-'+ idCount +'"><label class="mr-2">Option</label>'
			+'<a href="javascript:void(0);" onclick="deleteOption(\''+idCount+'\');" style="color:red"><i class="fa fa-trash-o fa-lg delete-option-icon"></i></a>'
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