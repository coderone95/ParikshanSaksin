/**
 *	manageUsersAccess.js
 * 
 */

$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
	getUsersAccessGiven();
	getUsersAccessNOTGiven();
	$('#give-selected-access').click(function(){
		var accessList  = [];
		var i = 0;
		$('.give-access').each(function(){
			if($(this). prop("checked") == true){
			    console.log($(this).val());
			    accessList[i++] = $(this).val();
			}
		});
//		console.log(accessList);
		givenSelectedAccessToUser(accessList);
	});
});

function removeAccess(accessCode){
	var data = {
			userID : $('#userID').val(),
			accessCode : accessCode,
			userType : $('#userType').val()
	};
	$.ajax({
		type : "POST",
		url : "removeAccess",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if(itr.successMsg != null){
				alert(itr.successMsg);
			}
			getUsersAccessGiven();
			getUsersAccessNOTGiven();
		},
		error : function(itrr) {
			alert("Error occurred while getting performing removeAccess.");
		}
	});
//	console.log(accessCode);
}

function givenSelectedAccessToUser(accessList){
	var data = {
			userID : $('#userID').val(),
			accessList : accessList,
			userType : $('#userType').val() 
	};
	$.ajax({
		type : "POST",
		url : "givenSelectedAccessToUser",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			if(itr.successMsg != ''){
				alert(itr.successMsg);
			}else{
				alert(itr.errorMsg);
			}
			getUsersAccessGiven();
			getUsersAccessNOTGiven();
		},
		error : function(itrr) {
			alert("Error occurred while getting performing givenSelectedAccessToUser.");
		}
	});
}

function getUsersAccessGiven(){
	$('.access-given-area').html('');
	var data = {
			userID : $('#userID').val()
	};
	$.ajax({
		type : "POST",
		url : "getUsersAccessGiven",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			str = '';
			if(itr.accessRightsList.length > 0){
				for(let i = 0 ; i < itr.accessRightsList.length; i++){
					str += '<div class="col-md-4 shadow p-3"><b style="font-size: 0.7rem;">'+itr.accessRightsList[i].functionality_code.replace('M_',' ')+'<b>';
					str += '<i class="fa fa-minus-circle ml-2 remove-access-btn" data-toggle="tooltip" data-placement="top" onclick="removeAccess(\''+itr.accessRightsList[i].functionality_code+'\');" title="Remove Access" style="font-size:20px;color:#da3009;cursor:pointer"></i></div>';
				}
			}else{
				str += '<div class="col-md-12"><div class="text-center text-success"><h4>User has no access<h4></div><div>';
			}
			$('.access-given-area').append(str);
		},
		error : function(itrr) {
			alert("Error occurred while getting performing getUsersAccessGiven.");
		}
	});
}

function getUsersAccessNOTGiven(){
	$('.access-not-given-area').html('');
	var data = {
			userID : $('#userID').val()
	};
	$.ajax({
		type : "POST",
		url : "getUsersAccessNOTGiven",
		dataType: 'json',
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		success : function(itr) {
			str = '';
			if(itr.accessRightsList.length > 0){
				for(let i = 0 ; i < itr.accessRightsList.length; i++){
					str += '<div class="col-md-4 shadow p-3"><b style="font-size: 0.7rem;">'+itr.accessRightsList[i].functionality_code.replace('M_',' ')+'<b>';
					str += '<input type="checkbox" class="give-access ml-1" value="'+itr.accessRightsList[i].functionality_code+'"></div>';
				}
			}else{
				str += '<div class="col-md-12"><div class="text-center text-success"><h4>User has all required access<h4></div><div>';
			}
			$('.access-not-given-area').append(str);
		},
		error : function(itrr) {
			alert("Error occurred while getting performing getUsersAccessNOTGiven.!!");
		}
	});
}

