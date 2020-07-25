//questionPage.jssd
$(document).ready(function(){
	getQuestionIds();
	getGroupTitle();
	if($('#hasExamStarted').val() == 'YES'){
		getGroupsInfoAndNumberOfQuestionCount();
	}
});

function getGroupTitle(){
	var testID = $('#testId').val();
	var data = {
			testID : testID	
	};
	$.ajax({
		type : "POST",
		url : "getGroupsInfoAndNumberOfQuestionCount",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(data) {
			var str = '';
			var str2 = '';
			if(data.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT != null && data.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT.length >0){
				let groupInfoAndCountList = data.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT;
				for(let i = 0 ; i < groupInfoAndCountList.length; i++){
					let groupID = groupInfoAndCountList[i].group_id;
					if(groupID == $('#groupId').val()){
						let groupName = groupInfoAndCountList[i].group_name;
						$('#groupTitle').text(groupName);
						break;	
					}
				}
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});	
}

function getGroupsInfoAndNumberOfQuestionCount(){
	$('.exam-set-dropdown-ul').html('');
	
	var testID = $('#testId').val();
	var data = {
			testID : testID	
	};
	$.ajax({
		type : "POST",
		url : "getGroupsInfoAndNumberOfQuestionCount",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(data) {
			var str = '';
			var str2 = '';
			if(data.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT != null && data.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT.length >0){
				var sr = 1;
				let groupInfoAndCountList = data.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT;
				for(var i = 0 ; i < groupInfoAndCountList.length; i++){
					var groupID = groupInfoAndCountList[i].group_id;
					var groupName = groupInfoAndCountList[i].group_name;
					var count = groupInfoAndCountList[i].numberOfQuestionsCount;
					str += '<li class="lis"><a href="javascript:void(0);" onclick="gotoQuestionBank(this);" value="'+groupID+'"><span class="exam-set-name" id="exam-set-id-'+groupID+'" value="'+groupID+'">'+groupName+'</span><span class="badge badge-primary">'+count+'</span></a></li>';
				}
				$('.exam-set-dropdown-ul').append(str);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});
}
var questionIDList = [];
var nextCount = 1;
var currentIndexCount = 0;
function getQuestionIds(){
	$('.question-id-row').html('');
	var testID = $('#testId').val();
	var groupId = $('#groupId').val();
	var data = {
			testId : testID,
			groupId : groupId
	};
	$.ajax({
		type : "POST",
		url : "getQuestionIds.action",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if(itr !=null && itr.QUESTION_IDS != undefined){
				let questionIDs = itr.QUESTION_IDS;
				
				let str = '';
				let count = 0;
				let index = 0
				for(let id of questionIDs){
//					console.log(id.question_id);
					questionIDList.push(id);
					str += `<div class="col-lg-3">
    							<button class="btn btn-outline-secondary m-1 question l-bg-orange" id="question-${id}" onclick="retrieveQustionWithOptions(${id},${index++})">${++count}</button>
							</div>`;
				}
				$('.question-id-row').append(str);
				retrieveQustionWithOptions(questionIDs[0],0);
				
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});
}

function retrieveQustionWithOptions(queID,index){
	$('.question-name').html('');
	$('.answerList').html('');
	$('#nextquestions').attr('disabled','false');
	$('#prevquestion').attr('disabled','false');
	$('#nextquestions').removeClass('disabled');
	$('#prevquestion').removeClass('disabled');
	$('#selectedQuestionId').val(queID);
	$('.question').removeClass('active-question');
	$('#question-'+queID).addClass('active-question');
	var data = {
			quesID : queID
	};
	$.ajax({
		type : "POST",
		url : "retrieveQustionWithOptions",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if(itr !=null){
				if(itr.QUESTION != null && itr.QUESTION != undefined){
					$('.question-name').html('Q.'+(index+1)+'] '+itr.QUESTION);
					$('.question-name').attr('QuestionID',queID);
					if(index == 0){
						$('#nextquestions').attr('onclick','goToNextQuestion('+nextQuestionId(index+1)+','+(index+1)+')');
						$('#prevquestion').attr('disabled','true');
						$('#prevquestion').addClass('disabled');
					}else if(questionIDList.length-1 == index){
						$('#nextquestions').attr('disabled','true');
						$('#nextquestions').addClass('disabled');
						$('#prevquestion').attr('onclick','goToPrevQuestion('+questionIDList[index-1]+','+(index-1)+')');
					}else{
						$('#nextquestions').attr('onclick','goToNextQuestion('+nextQuestionId(index+1)+','+(index+1)+')');
						$('#prevquestion').attr('onclick','goToPrevQuestion('+questionIDList[index-1]+','+(index-1)+')');
					}
					let str = '';
					if(itr.OPTIONS != null && itr.OPTIONS != undefined){
						for(let option of itr.OPTIONS){
							str += `<li><label><input type="radio" name="answerGroup" value="${option.optionId}" > ${option.option}</label></li>`;
						}
						$('.answerList').append(str);
					}
				}
				
			}
		},
		error : function(er) {
			alert("Error occurred while getting question details..!!");
		}
	});
}

function nextQuestionId(index){
	if(questionIDList !=null && questionIDList != undefined ){
		let id =  questionIDList[index];
		return id;
	}
}

function goToNextQuestion(id,index){
	if(id !=null){
		retrieveQustionWithOptions(id,index);
	}
}

function goToPrevQuestion(id,index){
	if(id !=null){
		retrieveQustionWithOptions(id,index);
	}
}

function submitAnswer(){
	var testID = $('#testId').val();
	var groupId = $('#groupId').val();
	var quesID = $('.question-name').attr('QuestionID');
	var optionId = $('input[name=answerGroup]:checked').val();
	if(isOptionSelected()){
		var data = {
			testId : testID,
			groupId : groupId,
			quesID : quesID,
			optionId : optionId	
		};
		$.ajax({
			type : "POST",
			url : "submitAnswer",
			dataType: 'json',
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				
			},
			error : function(itrr) {
				alert("Error occurred while submitting answer..!!");
			}
		});
		
	}else{
		alert('Please select option');
	}
	
}

function isOptionSelected(){
	var optionId = $('input[name=answerGroup]:checked').val();
	if(optionId == undefined){
		return false;
	}
	return true;
}