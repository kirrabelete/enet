<aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

        <!-- Sidebar user panel (optional) -->
        <div class="user-panel">
            <div class="pull-left image">
                <g:if test="${user.profile?.profilePicture}">
                    <img src="${createLink(controller: 'profile', action: 'renderImage')}" class="img-circle img-responsive" alt="User Image">
                </g:if>
                <g:else>
                    <img src="${resource(dir: 'images', file: 'avatar.png')}" class="img-circle img-responisive" alt="User Image">
                </g:else>
            </div>
            <div class="pull-left info">

                <p><a href="${createLink(controller: 'profile', action: 'index')}"><b>${user.fullname}</b></a></p>

            <!-- Role -->
                <sec:ifAllGranted roles="ROLE_STUDENT">
                    <a><i class="text-success"></i>Student</a>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <a><i class="text-success"></i>Admin</a>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="ROLE_TEACHER">
                    <a><i class="text-success"></i>Teacher</a>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                    <a><i class="text-success"></i>Office Employee</a>
                </sec:ifAllGranted>
            </div>

        </div>
        <!-- search form (Optional) -->
        <form action="${createLink(controller: 'profile', action: 'showProfile')}"  class="sidebar-form">
            <div class="input-group">
                <input required type="text" name="selectedName" placeholder="Search Users..." class="form-control searchUsers"
                       autocomplete="off">
                <span class="input-group-btn">
                    <button type="submit" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i></button>
                </span>
            </div>
        </form>
        <!-- /.search form -->

        <!-- Sidebar Menu -->
        <ul class="sidebar-menu">
            <li class="header">HEADER</li>
            <!-- Optionally, you can add icons to the links -->
            <li><a href="${createLink(controller: 'dashboard')}"><i class="fa fa-home"></i> <span>Home</span></a></li>
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <li><a href="${createLink(controller: 'admin')}"><i class="fa fa-user-secret"></i> <span> Admin</span></a></li>
            </sec:ifAllGranted>
            <sec:ifAllGranted roles="ROLE_TEACHER">
            <li><a href="${createLink(controller: 'profile', action: 'myStudents')}"><i class="fa fa-user"></i> <span>My Students</span></a></li>
            </sec:ifAllGranted>
            <sec:ifAllGranted roles="ROLE_STUDENT">
                <li><a href="${createLink(controller: 'profile', action: 'myTeachers')}"><i class="fa fa-user"></i> <span>My Teachers</span></a></li>
            </sec:ifAllGranted>
            <li><a href="${createLink(controller: 'group')}"><i class="fa fa-group"></i> <span>Groups</span></a></li>
            <li class="treeview">
                <a href="#"><i class="fa fa-envelope-o"></i> <span>Mail</span> <i class="fa fa-angle-left pull-right"></i></a>
                <ul class="treeview-menu">
                    <li><a href="${createLink(controller: 'mail', action: 'compose')}"><i class="fa fa-edit"></i> <span>Compose</span></a></li>
                    <li><a href="${createLink(controller: 'mail', action: 'inbox')}"><i class="fa fa-inbox"></i> <span>Inbox</span>
                        <g:if test="${unreadMails}">
                            <span class="label label-primary pull-right">${unreadMails.size}</span>
                        </g:if>
                        </a></li>
                    <li><a href="${createLink(controller: 'mail', action: 'sent')}"><i class="fa fa-send-o"></i> <span>Sent</span></a></li>
                </ul>
            </li>
            <sec:ifAllGranted roles="ROLE_TEACHER">
                <li><a href="${createLink(controller: 'storage', action: 'index')}"><i class="fa fa-database"></i> <span>Storage</span></a></li>
            </sec:ifAllGranted>
        </ul><!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
</aside>



