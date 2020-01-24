$(document).ready(function() {

		 $('.datepicker').datepicker({
		    	format: "yyyy-mm-dd",
		    	todayHighlight : true,
		    	language:'en',
		    	/* todayBtn: true, */
		    	clearBtn : true,
		    	autoclose : true
		    });
		 $('.datepicker').datepicker('setDate', new Date());
		 applyUsersFilter('ON_LOAD');
//			getUsers();
			$('#userForm').on('submit', function(){
					var formInput=$(this).serialize();    
					$.getJSON('addUserByManagementUsers.action', formInput,function(data) {
//						alert('User added successfully');
						if(data.successMsg != undefined ){
							alert(data.successMsg);
							applyUsersFilter('ON_LOAD');
						}else{
							alert(data.errorMsg);
						}
//						getUsers();
						
					});  
					return false; 	
			});
		$('#userUpdateForm').on('submit', function(){
  			var formInput=$(this).serialize();    
			$.getJSON('updateProfile', formInput,function(data) {
				var str = '';
				if(data.successMessageList != null){
					for(var i in data.successMessageList){
						alert(data.successMessageList[i].successMsg);
					}
				}
				$('#updateModal').modal('hide');
				clearFormFields($('#userUpdateForm'));
//				getUsers();
				applyUsersFilter('ON_LOAD');
			});  
			return false; 
  		});
		$('#exportBtn').on('click', function(){
			 var table = document.getElementById("userListTable");
			  var html = table.outerHTML;
			  var url = 'data:application/vnd.ms-excel,' + escape(html); 
			  $(this).attr("href", url);
			  $(this).attr("download", "users_report.xls"); 
		});
	});
	function clearFormFields(ths){
		$(ths).closest('form').find("input[type=text], input[type=password], input[type=email]").val("");
	}
	function getUsers() {
		$('#users-table-body').html('');
		$.ajax({
			type : "POST",
			url : "getUsers",
			success : function(itr) {
				var str = '';
				if (itr.userList != null && itr.userList.length > 0) {
					for (var i = 0; i < itr.userList.length; i++) {
						var userID = itr.userList[i].user_id;
						var name = itr.userList[i].name;
						var email = itr.userList[i].email_id;
						var phone = itr.userList[i].phone_number;
						var userType = itr.userList[i].user_type;
						var createdOn = itr.userList[i].created_on;
						var created_on = formatDate(new Date(itr.userList[i].created_on));
						//var btnClassforDisableEnable = 'btn-outline-warning';
						var btnClassforDisableEnable = 'text-warning';
						var disabledEnableOperationFunction = 'disableUser';
						var disabledEnableOperationText = '<i id="user-'+userID+'" class="fa fa-lock action-icon '+btnClassforDisableEnable+'" onclick="'+disabledEnableOperationFunction+'('+userID+',this);" aria-hidden="true"></i>';
						if(itr.userList[i].is_disabled == 1){
							//btnClassforDisableEnable = 'btn-outline-success';
							btnClassforDisableEnable = 'text-success';
							disabledEnableOperationFunction = 'enableUser';
							disabledEnableOperationText = '<i id="user-'+userID+'" class="fa fa-unlock action-icon '+btnClassforDisableEnable+'" onclick="'+disabledEnableOperationFunction+'('+userID+',this);" aria-hidden="true"></i>';
						}
						str += '<tr><th scope="row">' + userID + '</th><td>'
								+ name + '</td><td>' + email + '</td><td>'
								+ phone + '</td><td>' + userType + '</td><td>'
								+ created_on + '</td><td><i class="fa fa-trash text-danger delete" onclick="deleteThisUser('+userID+');"></i>'
								+disabledEnableOperationText
								+'<i class="fa fa-pencil action-icon" onclick="updateUser('+userID+',\''+email+'\');"></i></td></tr>';
					}
					$('#users-table-body').append(str);

				}else{
					str += '<div class="text-center"> No record found </div>';
					$('#users-table-body').append(str);
				}

			},
			error : function(itr) {
				alert("No values found..!!");
			}
		});
	}
	function deleteThisUser(userID){
		$('#deleteModal').modal('show');
		$('#deleteBtn').removeAttr('onclick');
		$('#deleteBtn').attr('onclick','deleteUser('+userID+');');
	}
	function deleteUser(userID){
		var data = {
				userId : userID
		};
		$.ajax({
			type : "POST",
			url : "deleteUser",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert("User deleted");
				$('#deleteModal').modal('hide');
				//getUsers();
				applyUsersFilter('ON_LOAD');
			},
			error : function(itr) {
				alert("Error....!!");
			}
		});
	}
	
	function disableUser(userID,ths){
		var data = {
				userId : userID
		};
		var thisEle = ths; 
		$.ajax({
			type : "POST",
			url : "disableUser",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert('User is disabled');
				applyUsersFilter('ON_LOAD');
//				getUsers();
			},
			error : function(itr) {
				alert("Error....!!");
			}
		});
	}
	function enableUser(userID, ths){
		var data = {
				userId : userID
		};
		var thisEle = ths; 
		$.ajax({
			type : "POST",
			url : "enableUser",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				alert('User is enabled');
				applyUsersFilter('ON_LOAD');
//				getUsers();
			},
			error : function(itr) {
				alert("Error....!!");
			}
		});
	}
	function updateUser(userID,email){
		$('#userID').val(userID);
		$('#emailID').val(email);
		getUserProfile(userID,email);
		$('#updateModal').modal('show');
	}
	function getUserProfile(userID, emailId){
		var data = {
				userID : userID,
				emailId : emailId
		};
		 $.ajax({
	  			type : "POST",
	  			url : "getUserInfo",
	  			data: JSON.stringify(data),
				dataType: 'json',
				contentType:"application/json;charset=utf-8",
	  			success : function(res) {
	  				//$('#userName').val(res.map.email);
	  				$('#userName').val(res.map.name);
	  				$('#phoneNumber').val(res.map.phone);
	  			},
	  			error : function(res) {
	  				alert('Error while processing the request');
	  			}
	  		});
	}
	function callMyAction() {
		$.ajax({
			type : "POST",
			url : "getmydata",
			success : function(itr) {
				var x = "<ol>";
				$.each(itr.dataList, function() {
					x += "<li>" + this + "</li>";
				});
				x += "</ol>";
				$("#websparrow").html(x);
			},
			error : function(itr) {
				alert("No values found..!!");
			}
		});
	}
	function formatDate(date) {
		  var monthNames = [
		    "January", "February", "March",
		    "April", "May", "June", "July",
		    "August", "September", "October",
		    "November", "December"
		  ];

		  var day = date.getDate();
		  var monthIndex = date.getMonth();
		  var year = date.getFullYear();

		  return day + ' ' + monthNames[monthIndex] + ' ' + year;
		}
	function validateForm(){
		var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
		var numbers = /^[-+]?[0-9]+$/;
		if($('#name').val() == '' || $('#name').val() == null){
			alert('Please enter name');
			return false;
		}else if($('#email').val() == '' || $('#email').val() == null){
			alert('Please enter an email');
			return false;
		}else if( $('#email').val() != null && !re.test($('#email').val())){
			alert('Please enter valid email address');
			return false;
		}else if($('#phone').val() == '' || $('#phone').val() == null){
			alert('Please enter phone');
			return false;
		}else if($('#phone').val() != null && $('#phone').val() != ''){
			if(! $('#phone').val().match(numbers)){
				alert('Please enter numbers only');
				return false;
			}else if($('#phone').val().length < 10 && $('#phone').val().length > 12 ){
				alert('Number should be between 10 and 12');
				return false;
			}			
		}else if($('#pwd').val() == '' || $('#pwd').val() == null ){
			alert('Please enter password');
			return false;
		}else if($('#cpwd').val() == '' || $('#cpwd').val() == null ){
			alert('Please confirm password');
			return false;
		}else if($('#pwd').val() != null && $('#pwd').val() != '' ){ 
			if($('#pwd').val() !=  $('#cpwd').val() ){
				alert('Password is not matched');
				return false;
			}
		}else if($('#pwd').val() != '' || $('#cpwd').val() != ''){
			if($('#pwd').val().length < 5 ||  $('#cpwd').val().length < 5 ){
				alert('Password must be of min 5 length');
				return false;
			}
		}
		return true;
		
	}
	function validateForm(){
		var re = /[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}/igm;
		var numbers = /^[-+]?[0-9]+$/;
		if($('#userName').val() == '' || $('#userName').val() == null){
			alert('Please enter name');
			return false;
		}else if($('#emailID').val() == '' || $('#emailID').val() == null){
			alert('Please enter an email');
			return false;
		}else if( $('#emailID').val() != null && !re.test($('#emailID').val())){
			alert('Please enter valid email address');
			return false;
		}else if($('#phoneNumber').val() == '' || $('#phoneNumber').val() == null){
			alert('Please enter phone');
			return false;
		}else if($('#phoneNumber').val() != null && $('#phoneNumber').val() != ''){
			if(! $('#phoneNumber').val().match(numbers)){
				alert('Please enter numbers only');
				return false;
			}else if($('#phoneNumber').val().length < 10 && $('#phoneNumber').val().length > 12 ){
				alert('Number should be between 10 and 12');
				return false;
			}			
		}else if($('#password').val() == '' || $('#password').val() == null ){
			alert('Please enter password');
			return false;
		}else if($('#cpassword').val() == '' || $('#cpassword').val() == null ){
			alert('Please confirm password');
			return false;
		}else if($('#password').val() != null && $('#password').val() != '' ){ 
			if($('#password').val() !=  $('#cpassword').val() ){
				alert('Password is not matched');
				return false;
			}
		}else if($('#password').val() != '' || $('#cpassword').val() != ''){
			if($('#password').val().length < 5 ||  $('#cpassword').val().length < 5 ){
				alert('Password must be of min 5 length');
				return false;
			}
		}
		return true;
		
	}
	
	function applyUsersFilter(flag){
		$('#users-table-body').html('');
		$('.users-table-loader').show();
		var userName = $('#byUserName').val();
		var userId = $('#byUserId').val();
		var startDate = '';
		var endDate = ''; 
		var phoneNumber = $('#byPhoneNumber').val();
		var emailId = $('#byEamil').val();
		var userType = $('#byUserType').val();
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
		
		var createdBy = $('#createdBy').val();
		
		var data = {
				startDate : startDate,
				endDate : endDate,
				userName : userName.trim(),
				userId : +userId,
				phoneNumber : phoneNumber.trim(),
				emailId : emailId.trim(),
				userType : userType
		};
		
		$.ajax({
			type : "POST",
			url : "getUserReport",
			data: JSON.stringify(data),
			dataType: 'json',
			contentType:"application/json;charset=utf-8",
			success : function(itr) {
				if ($.fn.DataTable.isDataTable("#userListTable")) {
					  $('#userListTable').DataTable().clear().destroy();
				}
				if (itr.userList != null && itr.userList.length > 0) {
					
					for (var i = 0; i < itr.userList.length; i++) {
						var userID = itr.userList[i].user_id;
						var name = itr.userList[i].name;
						var email = itr.userList[i].email_id;
						var phone = itr.userList[i].phone_number;
						var userType = itr.userList[i].user_type;
						var createdOn = itr.userList[i].created_on;
						var created_on = formatMyDate(new Date(itr.userList[i].created_on));
						//var btnClassforDisableEnable = 'btn-outline-warning';
						var btnClassforDisableEnable = 'text-warning';
						var disabledEnableOperationFunction = 'disableUser';
						var disabledEnableOperationText = '<i id="user-'+userID+'" class="fa fa-lock action-icon '+btnClassforDisableEnable+'" onclick="'+disabledEnableOperationFunction+'('+userID+',this);" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Enable User"></i>';
						if(itr.userList[i].is_disabled == 1){
							//btnClassforDisableEnable = 'btn-outline-success';
							btnClassforDisableEnable = 'text-success';
							disabledEnableOperationFunction = 'enableUser';
							disabledEnableOperationText = '<i id="user-'+userID+'" class="fa fa-unlock action-icon '+btnClassforDisableEnable+'" onclick="'+disabledEnableOperationFunction+'('+userID+',this);" aria-hidden="true" data-toggle="tooltip" data-placement="top" title="Disable User"></i>';
						}
						var manageAccessUsers = '';
						var str = '<tr>';
						str=str+'<td class="text-nowrap">'+userID+'</td>';
						str=str+'<td class="text-nowrap">'+name+'</td>';
						str=str+'<td class="text-nowrap">'+email+'</td>';
						str=str+'<td class="text-nowrap">'+phone+'</td>';
						str=str+'<td class="text-nowrap">'+userType+'</td>';
						str=str+'<td class="text-nowrap">'+created_on+'</td>';
						if(userType != 'CANDIDATE' && userType != ''){
							manageAccessUsers += '<a href="manageUsersAccess?userID='+userID+'&userType='+userType+'">'
									+'<i class="fa fa-user-plus ml-1" aria-hidden="true" style=" cursor:pointer;" data-toggle="tooltip" data-placement="top" title="Manage User Access"></i></a>';
						}
						str=str+'<td class="text-nowrap"><i class="fa fa-trash text-danger delete" onclick="deleteThisUser('+userID+');" data-toggle="tooltip" data-placement="top" title="Delete User"></i>'+disabledEnableOperationText
									+'<i class="fa fa-pencil action-icon" onclick="updateUser('+userID+',\''+email+'\');" data-toggle="tooltip" data-placement="top" title="Update User"></i>'
									+manageAccessUsers+'</td>';
						str=str+'</tr>';
						$('#users-table-body').append(str);
					}
					
//					$("#userListTable").DataTable( {
//				        "scrollY":        '90vh',
//				        "scrollCollapse": true,
//				        "paging":         true,
//						"scrollX": false,
//						"ordering": true,
//						"info":     true,
//						"searching": true,
//						"destroy": true
//				    } );
					$("#userListTable").DataTable();
					$('.users-table-loader').hide();

				}else{
					str += '<tr><td colspan="10"><div class="text-center"> No record found </div></td></tr>';
					$('#users-table-body').append(str);
					$('.users-table-loader').hide();
				}
			},
			error : function(itr) {
				alert("Error while processing the request....!!");
			}
		});
		$('#userFilterModal').modal('hide');
	}
	
	function formatMyDate(date) {
		  var day = date.getDate();
		  var monthIndex = date.getMonth();
		  monthIndex = monthIndex +1;
		  var year = date.getFullYear();
		  return day+'-'+monthIndex+'-'+year;
		}