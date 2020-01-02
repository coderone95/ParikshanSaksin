/**
 *  testAuth.js
 */

	$(document).ready(function(){
		$('#user-name').html($('#loggedInUserName').val());
		$('#user-login-id').html($('#login_id').val());
	});
		function clearSessionValues(){
			sessionStorage.clear();
			// similar behavior as clicking on a link
			window.location.href = "logout";
		}