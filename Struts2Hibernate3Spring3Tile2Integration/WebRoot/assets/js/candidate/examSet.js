/**
 *  examSet.js
 */

$(document).ready(function(){
		if($('#hasExamStarted').val() == 'YES'){
			getGroupsInfoAndNumberOfQuestionCount();
		}
		
//		$('.group').click(function(){
//			var groupID = Integer.parseInt($(this).attr('value'));
//			console.log(groupID);
//		});

});
var bgGradientClassArray = ['l-bg-cherry','l-bg-blue-dark','l-bg-green-dark','l-bg-orange-dark','l-bg-cyan','l-bg-green','l-bg-orange','l-bg-cyan'];
function getGroupsInfoAndNumberOfQuestionCount(){
	$('.exam-set-dropdown-ul').html('');
	$('.exam-set-row').html('');
	
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
			var str2 = '';
			if(itr.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT != null && itr.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT.length >0){
				var sr = 1;
				let index = 0;
				let groupInfoAndCountList = itr.GROUPS_INFO_AND_NUMBER_OF_QUE_COUNT;
				for(var i = 0 ; i < groupInfoAndCountList.length; i++){
					var groupID = groupInfoAndCountList[i].group_id;
					var groupName = groupInfoAndCountList[i].group_name;
					var count = groupInfoAndCountList[i].numberOfQuestionsCount;
					str += '<li class="lis"><a href="javascript:void(0);"><span class="exam-set-name" id="exam-set-id-'+groupID+'" value="'+groupID+'">'+groupName+'</span><span class="badge badge-primary '+bgGradientClassArray[index++]+'">'+count+'</span></a></li>';
					str2 += `
						<div class="col-xl-3 col-lg-6">
	                    	<div class="card ${bgGradientClassArray[index]}" onclick="gotoQuestionBank(this);" value="${groupID}" style="cursor:pointer">
	                        	<div class="card-statistic-3 p-4">
	                            	<div class="card-icon card-icon-large"><i class="fas fa-question"></i></div>
	                            	<div class="mb-4">
	                                	<h5 class="card-title mb-0">${groupName}</h5>
	                            	</div>
	                            	<div class="row align-items-center mb-2 d-flex">
	                                	<div class="col-4">
	                                    	<h4 class="d-flex align-items-center mb-0">
	                                        	${count}
	                                    	</h4>
	                                	</div>
	                                	<div class="col-8 text-right">
				                            <span>No. of Questions</span>
				                        </div>
	                            	</div>
	                      		</div>
	                  		</div>
	              		</div>
					`
					// str2 += '<div class="col-md-3 col-sm-6 col-lg-3 shadow-on-hover p-3 text-center group" onclick="gotoQuestionBank(this);" value="'+groupID+'"><h4 class="text-warning">'+groupName+'</h4><div class="badge text-primary">No. of Questions : '+count+'</div></div>';
				}
				$('.exam-set-dropdown-ul').append(str);
				$('.exam-set-row').append(str2);
			}
		},
		error : function(itrr) {
			alert("Error occurred while fetching the data..!!");
		}
	});
}

	function clearSessionValues(){
		sessionStorage.clear();
			// similar behavior as clicking on a link
		window.location.href = "logout";
	}
	
	function gotoQuestionBank(ths){
		var formEle = document.createElement("form");
		formEle.setAttribute("action","questions.action?allowGoBack=true");
		formEle.setAttribute("method","post");
		var testIdEle = document.createElement("input");
		testIdEle.setAttribute("name","testId");
		testIdEle.setAttribute("type","hidden");
		testIdEle.setAttribute("value",$('#testID').val());
		var GroupIdEle = document.createElement("input");
		GroupIdEle.setAttribute("name","groupId");
		GroupIdEle.setAttribute("type","hidden");
		GroupIdEle.setAttribute("value",$(ths).attr('value'));
		formEle.appendChild(testIdEle);
		formEle.appendChild(GroupIdEle);
		document.body.appendChild(formEle);
		formEle.submit();
	}
	