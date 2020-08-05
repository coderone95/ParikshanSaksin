    <script>
    var currentPageId
    var page
    $(document).ready(function() {
    	currentPageId = $('#pageId').val();
    	$('nav li').removeClass('active');
    	$('#lnk-'+currentPageId).parent().addClass('active');
    	page = $('#page').val();
    	$('#page-header').html('');
    	$('#page-header').html(page);
    });

    </script>
    <style>
    	.sidebar .sidebar-wrapper{
    		overflow: unset !important;
    	}
      .dropdown-groups{
        transform: translate3d(25px, 36px, 0px) !important;
      }
    </style>
    <div class="sidebar" data-color="white" data-active-color="danger">
      <!--
        Tip 1: You can change the color of the sidebar using: data-color="blue | green | orange | red | yellow"
    -->
      <div class="logo">
        <a href="http://www.creative-tim.com" class="simple-text logo-mini">
          <div class="logo-image-small">
            <img src="./assets/img/logo-small.png">
          </div>
        </a>
        <a href="#" class="simple-text logo-normal">
          ExamsVilla
          <!-- <div class="logo-image-big">
            <img src="./assets/img/logo-big.png">
          </div> -->
        </a>
      </div>
      <div class="sidebar-wrapper">
        <ul class="nav">
          <li >
            <a href="adminDashboardPage.action" id="lnk-dash" class="nav-lnk-dash nav-lnk" >
              <i class="fa fa-home" aria-hidden="true"></i>
              <p>Dashboard</p>
            </a>
          </li>
          <!-- <li >
            <a href="adminIconsPage.action"   id="lnk-icons" class="nav-lnk-icons nav-lnk">
              <i class="nc-icon nc-diamond"></i>
              <p>Icons</p>
            </a>
          </li> -->
          <!-- <li  >
            <a href="./map.html" id="lnk-map" class="nav-lnk" >
              <i class="nc-icon nc-pin-3"></i>
              <p>Maps</p>
            </a>
          </li> -->
          <!-- <li  >
            <a href="./notifications.html" id="lnk-not" class="nav-lnk" >
              <i class="nc-icon nc-bell-55"></i>
              <p>Notifications</p>
            </a>
          </li> -->
          <li >
            <a href="adminUserProfilePage"  id="lnk-user" class="nav-lnk-user nav-lnk">
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>
              <p>User Profile</p>
            </a>
          </li>
          <li >
            <a href="adminUserListePage"  id="lnk-userList" class="nav-lnk-userList nav-lnk">
              <i class="fa fa-users" aria-hidden="true"></i>
              <p>Users</p>
            </a>
          </li>
          <li >
            <a href="testsPage"  id="lnk-tests" class="nav-lnk-tests nav-lnk">
               <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
              <p>Tests</p>
            </a>
          </li>
          
          <li class="nav-item btn-rotate dropdown">
            <!-- <a href="groups"  id="lnk-groups" class="nav-lnk-groups nav-lnk">
               <i class="fa fa-newspaper-o" aria-hidden="true"></i>
              <p>Groups</p>
            </a> -->
            <a class="nav-link dropdown-toggle" href="javascript:void(0);" id="lnk-groups" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="fa fa-newspaper-o" aria-hidden="true"></i>
                  Groups
            </a>
             <div class="dropdown-menu dropdown-menu-right dropdown-groups" aria-labelledby="navbarDropdownMenuLink">
                  <a class="dropdown-item" href="groups" style="font-size: 12px !important"><i class="fa fa-plus-circle" aria-hidden="true"></i></i>CREATE GROUP</a>
                  <a class="dropdown-item" href="groupReport" style="font-size: 12px !important"><i class="fa fa-bar-chart" aria-hidden="true"></i>GROUP REPORT</a>
            </div>

          </li>
          
          <li >
            <a href="questionsPage"  id="lnk-questions" class="nav-lnk-questions nav-lnk">
               <i class="fa fa-question-circle-o" aria-hidden="true"></i>
              <p>Questions</p>
            </a>
          </li>
          
          <!-- <li >
            <a href="./typography.html"  id="lnk-typh" class="nav-lnk">
              <i class="nc-icon nc-caps-small"></i>
              <p>Typography</p>
            </a>
          </li> -->
        </ul>
      </div>
    </div>