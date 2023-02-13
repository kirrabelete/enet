<!-- Main Header -->
<header class="main-header">

    <!-- Logo -->
    <a href="${createLink(controller: 'dashboard')}" class="logo">
        <!-- mini dlogo for sidebar mini 50x50 pixels -->
        <span class="logo-mini"><b><i>e</i></b></span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg"><b><i>e</i></b>net</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
        <!-- Sidebar toggle button-->
        <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Toggle navigation</span>
        </a>
        <!-- Navbar Right Menu -->
        <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
                <!-- Messages: style can be found in dropdown.less-->
              <g:if test="${unreadMails}">
                <li class="dropdown messages-menu">
                    <!-- Menu toggle button -->
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-envelope-o"></i>
                        <span class="label label-success">${unreadMails.size}</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header">You have ${unreadMails.size} new messages</li>
                        <li>
                            <!-- inner menu: contains the messages -->
                            <ul class="menu">
                            <g:each in="${unreadMails}" var="mail">
                                <li><!-- start message -->
                                    <a href="${createLink(controller: 'mail', action: 'readMail', params: [mailId: mail.id])}">
                                        <div class="pull-left">
                                            <!-- User Image -->
                                            <g:if test="${mail.sender.profile?.profilePicture}">
                                                <img class="img-circle" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: mail.sender.id])}" alt="profile picture">
                                            </g:if>
                                            <g:else>
                                                <img class="img-circle" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                            </g:else>
                                        </div>
                                        <!-- Message title and timestamp -->
                                        <h4>
                                            ${mail.sender.fullname}
                                            <small><i class="fa fa-clock-o"></i> ${new java.text.DateFormatSymbols().months[mail.dateCreated.month]} ${mail.dateCreated.getDate()}</small>
                                        </h4>
                                        <!-- The message -->
                                        <p>${raw(mail.content)}</p>
                                    </a>
                                </li><!-- end message -->
                            </g:each>
                            </ul><!-- /.menu -->
                        </li>
                        <li class="footer"><a href="${createLink(controller: 'mail', action: 'inbox')}">See All Messages</a></li>
                    </ul>
                </li><!-- /.messages-menu -->
              </g:if>
              <g:else>
                  <!-- Messages: style can be found in dropdown.less-->
                  <li class="dropdown messages-menu">
                      <!-- Menu toggle button -->
                      <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                          <i class="fa fa-envelope-o"></i>
                      </a>
                      <ul class="dropdown-menu">
                          <li class="header">You have no new messages</li>
                          <li>
                              <!-- inner menu: contains the messages -->
                              <ul class="menu">
                                  <li><!-- start message -->

                                  </li><!-- end message -->
                              </ul><!-- /.menu -->
                          </li>
                          <li class="footer"><a href="${createLink(controller: 'mail', action: 'inbox')}">See All Messages</a></li>
                      </ul>
                  </li><!-- /.messages-menu -->

              </g:else>
            <!-- Notifications Menu -->
            <g:if test="${notifications}">
                <li class="dropdown messages-menu">
                    <!-- Menu toggle button -->
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-bell-o"></i>
                        <span class="label label-warning">${notifications.size}</span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="header">You have ${notifications.size} notifications</li>
                        <li>
                            <!-- Inner Menu: contains the notifications -->
                            <ul class="menu">
                            <g:each in="${notifications}" var="noty">
                                <li><!-- start message -->
                                    <a href="${createLink(controller: 'post', action: 'showPost', params: [postId: noty.id])}">
                                        <div class="pull-left">
                                        <!-- User Image -->
                                            <g:if test="${noty.user.profile?.profilePicture}">
                                                <img class="img-circle" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: noty.user.id])}" alt="profile picture">
                                            </g:if>
                                            <g:else>
                                                <img class="img-circle" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                            </g:else>
                                        </div>
                                        <!-- Message title and timestamp -->
                                        <h4>
                                        ${noty.user.fullname}
                                            <small><i class="fa fa-clock-o"></i> ${new java.text.DateFormatSymbols().months[noty.dateCreated.month]} ${noty.dateCreated.getDate()}</small>
                                        </h4>
                                        <!-- The message -->
                                          <g:if test="${noty.isComment}">
                                              <p>has commented on a post</p>
                                          </g:if>
                                          <g:else>
                                              <p>has posted a new notice</p>
                                          </g:else>
                                    </a>
                                </li><!-- end message -->
                            </g:each>
                            </ul>
                        </li>
                        <li class="footer"></li>
                    </ul>
                </li>
               </g:if>
                <g:else>
                    <!-- Messages: style can be found in dropdown.less-->
                    <li class="dropdown messages-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">You have no notifications</li>
                            <li>
                                <!-- inner menu: contains the messages -->
                                <ul class="menu">
                                    <li><!-- start message -->

                                    </li><!-- end message -->
                                </ul><!-- /.menu -->
                            </li>
                            <li class="footer"></li>
                        </ul>
                    </li><!-- /.messages-menu -->

                </g:else>
            <!-- User Account Menu -->
                <li class="dropdown user user-menu">
                    <!-- Menu Toggle Button -->
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <!-- The user image in the navbar-->
                        <g:if test="${user.profile?.profilePicture}">
                            <img src="${createLink(controller: 'profile', action: 'renderImage')}" class="user-image" alt="User Image">
                        </g:if>
                        <g:else>
                            <img src="${resource(dir: 'images', file: 'avatar.png')}" class="user-image" alt="User Image">
                        </g:else>

                    <!-- hidden-xs hides the username on small devices so only the image appears. -->
                        <span class="hidden-xs">${user.fullname}</span>
                    </a>
                    <ul class="dropdown-menu">
                        <!-- The user image in the menu -->
                        <li class="user-header">
                            <g:if test="${user.profile?.profilePicture}">
                                <img src="${createLink(controller: 'profile', action: 'renderImage')}" class="img-circle" alt="User Image">
                            </g:if>
                            <g:else>
                                <img src="${resource(dir: 'images', file: 'avatar.png')}" class="img-circle" alt="User Image">
                            </g:else>

                            <p>
                                ${user.fullname}<br>
                                <!-- Role -->
                                <sec:ifAllGranted roles="ROLE_STUDENT">
                                    Student
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    Admin
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_TEACHER">
                                    Teacher
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                                    Office Emloyee
                                </sec:ifAllGranted>

                                <small>Member Since ${new java.text.DateFormatSymbols().months[user.dateCreated.month]} ${user.dateCreated.getDate()}, ${user.dateCreated.getYear() + 1900}</small>
                            </p>
                        </li>
                        <!-- Menu Body -->
                        <li class="user-body">
                            <div class="col-xs-4 text-center">
                                <a href="${createLink(controller: 'profile', action: 'myTeachers')}">Teachers</a>
                            </div>
                            <div class="col-xs-4 text-center">
                                <a href="${createLink(controller: 'group', action: 'index')}">Groups</a>
                            </div>
                            <div class="col-xs-4 text-center">
                                <a href="${createLink(controller: 'mail', action: 'inbox')}">Mails</a>
                            </div>
                        </li>
                        <!-- Menu Footer-->
                        <li class="user-footer">
                            <div class="pull-left">
                                <a href="${createLink(controller: 'profile', action: 'index')}" class="btn btn-default btn-flat">Profile</a>
                            </div>
                            <div class="pull-right">
                                <form action="${createLink(controller: 'logout')}" method="post" name="logout">
                                    <button  type="submit" class="btn btn-default btn-flat">Log out</button>
                                </form>
                            </div>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
</header>
<!-- Left side column. contains the logo and sidebar -->
