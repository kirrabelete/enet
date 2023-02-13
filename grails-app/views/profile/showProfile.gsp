<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Show Profile</title>

</head>
<body>
<div class="wrapper">



    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                View Profile
            </h1>

        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-3">

                    <!-- Profile Image -->
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <g:if test="${selectedUser.profile?.profilePicture}">
                                <img class="profile-user-img img-responsive img-circle" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: selectedUser.id])}" alt="User profile picture">
                            </g:if>
                            <g:else>
                                <img class="profile-user-img img-responsive img-circle" src="${resource(dir: 'images', file: 'avatar.png')}" alt="User profile picture">
                            </g:else>

                            <h3 class="profile-username text-center">${selectedUser.fullname}</h3>
                        <!-- Role -->
                            <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                <p class="text-muted text-center">Studnet</p>
                            </g:if>
                            <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_TEACHER")}">
                                <p class="text-muted text-center">Teacher</p>
                            </g:if>
                            <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_ADMIN")}">
                                <p class="text-muted text-center">Admin</p>
                            </g:if>
                            <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_OFFICE_EMPLOYEE")}">
                                <p class="text-muted text-center">Office Employee</p>
                            </g:if>
                            <ul class="list-group list-group-unbordered">
                               <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                <li class="list-group-item">
                                    <b>Year</b> <a class="pull-right">${selectedUser.profile?.year}</a>
                                </li>
                                </g:if>
                                <g:if test="${!selectedUser.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                    <li class="list-group-item">
                                        <b>Year Started</b> <a class="pull-right">${selectedUser.profile?.year}</a>
                                    </li>
                                </g:if>
                                <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                    <li class="list-group-item">
                                        <b>Id Number</b> <a class="pull-right">${selectedUser.profile?.idNumber}</a>
                                    </li>
                                </g:if>
                            </ul>
                            <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_TEACHER") && selectedUser != user && !user.following.contains(selectedUser)}">
                                <a href="${createLink(controller: 'profile', action: 'createRelation', params: [userId: selectedUser.id])}" class="btn btn-primary btn-block"><b>Follow</b></a>
                            </g:if>

                            <g:if test="${user.following.contains(selectedUser)}">
                                <a href="${createLink(controller: 'profile', action: 'removeRelation', params: [userId: selectedUser.id])}" class="btn btn-danger btn-block"><b>Unfollow</b></a>
                            </g:if>


                        </div><!-- /.box-body -->
                    </div><!-- /.box -->

                    <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_STUDENT") || selectedUser.getAuthorities().authority.contains("ROLE_TEACHER")}">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">
                                <i class="fa fa-book margin-r-5"></i>  Education
                            </h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <strong>Department</strong>
                            <p class="text-muted">
                                ${selectedUser.profile?.department}
                            </p>
                            <strong>Stream</strong>
                            <p class="text-muted">
                                ${selectedUser.profile?.stream}
                            </p>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
               </g:if>
                    <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_OFFICE_EMPLOYEE")}">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i class="fa fa-briefcase margin-r-5"></i>  Employment
                                </h3>
                            </div><!-- /.box-header -->
                            <div class="box-body">
                                <strong>Job Position</strong>
                                <p class="text-muted">
                                    ${selectedUser.profile?.position}
                                </p>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                    </g:if>
                <!-- About Me Box -->
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">About Me</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <p class="text-muted">
                                ${selectedUser.profile?.aboutMe}
                            </p>

                            <hr>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->
                <div class="col-md-9">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#activity" data-toggle="tab">Activities</a></li>

                <g:if test="${selectedUser.getAuthorities().authority.contains("ROLE_TEACHER")}">
                        <li><a href="#profile" data-toggle="tab">Storage</a></li>
                </g:if>
                    </ul>
                    <div class="tab-content">
                        <div class="active tab-pane" id="activity">

                                    <g:if test="${postsBySelectedUser}">
                                        <g:each in="${postsBySelectedUser}" var="post">
                                            <div class="post">
                                                <div class="user-block">
                                                    <g:if test="${post.user.profile?.profilePicture}">
                                                        <img class="img-circle img-bordered-sm" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: post.user.id])}" alt="User profile picture">
                                                    </g:if>
                                                    <g:else>
                                                        <img class="img-circle img-bordered-sm" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                                    </g:else>

                                                    <span class='username'>
                                                        <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: post.user?.fullname +" | "+ post.user.username] )}">${post.user?.fullname}</a>
                                                    </span>
                                                    <span class='description'>
                                                        <g:if test="${post.isComment}">
                                                            Commented on a <a href="${createLink(controller: 'post', action: 'showPostForThisReply', params:[postId: post.id] )}">Post</a>
                                                        </g:if> ${post.dateCreated.toLocaleString()}</span>
                                                </div><!-- /.user-block -->
                                                <p>
                                                    ${raw(post?.content)}
                                                </p>
                                                <p>
                                                    <g:if test="${post?.attachment}">
                                                        <b>Attachment: </b>  <a href="${createLink(controller: 'dashboard', action: 'downloadAttachedFiles', params: [postId: post?.id])}">${post.attachedFileName}</a>
                                                    </g:if>
                                                </p>
                                                <ul class="list-inline">
                                                    <li><a href="${createLink(controller: 'post', action: 'showPost', params: [postId: post.id])}" class="link-black text-sm"><i class="fa  fa-external-link-square margin-r-5"></i>Show Detail</a></li>
                                                    <li class="pull-right"><a class="link-black text-sm btn" data-toggle="modal" data-target="#modal-comments-${post.id}"><i class="fa fa-comments-o margin-r-5"></i> Comments (${post.replies.size()})</a></li>
                                                </ul>
                                                <div class="modal" id="modal-comments-${post.id}" role="dialog">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                <h3 class="modal-title">Comments</h3>
                                                            </div>
                                                            <div class="modal-body">
                                                                <g:if test="${post.replies}">
                                                                    <g:each in="${post.replies}" var="reply">
                                                                        <div class="post">
                                                                            <div class="user-block">
                                                                                <g:if test="${reply.user.profile?.profilePicture}">
                                                                                    <img class="img-circle img-bordered-sm" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: reply.user.id])}" alt="User profile picture">
                                                                                </g:if>
                                                                                <g:else>
                                                                                    <img class="img-circle img-bordered-sm" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                                                                </g:else>

                                                                                <span class='username'>
                                                                                    <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: reply.user?.fullname +" | "+ reply.user.username] )}">${reply.user?.fullname}</a>
                                                                                </span>
                                                                                <span class='description'>${reply.dateCreated.toLocaleString()}</span>
                                                                            </div><!-- /.user-block -->
                                                                            <p>
                                                                                ${raw(reply?.content)}
                                                                            </p>

                                                                        </div><!-- /.post -->
                                                                    </g:each>
                                                                </g:if>
                                                                <g:else>
                                                                    <h4 class="col-md-offset-2">There are no comments for this post.</h4>
                                                                </g:else>

                                                            </div>
                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>
                                                    <!-- /.modal-dialog -->
                                                </div>

                                                <g:form controller="dashboard" action="saveComments" params="[postId : post.id]">
                                                    <input class="form-control input-sm" name="comment" type="text" placeholder="Type a comment and press Enter">
                                                </g:form>

                                            </div><!-- /.post -->
                                        </g:each>
                                    </g:if>

                                    <g:if test="${!postsBySelectedUser}">
                                        <div class="post clearfix">
                                                <h1 class="text-center"><i class="fa fa-feed"></i></h1>
                                                <h3 class="text-center">No Activities from this user</h3>
                                        </div><!-- /.post -->
                                    </g:if>

                        </div><!-- /.tab pane-->
                        <div class="tab-pane" id="profile">
                        <div class="box box-default">
                            <div class="box-header">
                                <h4 class="box-title"> Shared Documents</h4>
                            </div><!-- /.box-header -->
                            <div class="box-body table-responsive">
                                <table id="docTable" class="table table-bordered table-hover table-striped">
                                    <thead>
                                    <tr>
                                        <th>File Name</th>
                                        <th>Size</th>
                                        <th>Date Uploaded</th>
                                        <th>Download</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${sharedDocuments}" var="file">
                                        <tr>
                                            <td>
                                                <a href="${createLink(controller: 'storage', action: 'downloadFile', params: [fileId: file?.id])}">${file.fileName}</a>
                                            </td>
                                            <td>${(file.fileSize / 1048576).round(2)} MB</td>
                                            <td>${new java.text.DateFormatSymbols().months[file.dateCreated.month]} ${file.dateCreated.getDate()}, ${file.dateCreated.getYear() + 1900}</td>
                                            <td>
                                                 <a href="${createLink(controller: 'storage', action: 'downloadFile', params: [fileId: file.id])}" class="btn btn-primary btn-sm"
                                                    title="make public"><i class="fa fa-cloud-download"></i></a>
                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div><!-- /.tab-pane -->
                   </div><!-- /.col -->
         </div><!-- /.row -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<!-- REQUIRED JS for this page -->

<!-- DataTables -->

<script src="${resource(dir: 'plugins/datatables',file:'jquery.dataTables.min.js')}"></script>
<script src="${resource(dir: 'plugins/datatables',file:'dataTables.bootstrap.min.js')}"></script>

<script>
    $(function () {
        $("#docTable").DataTable();
    });
</script>
</body>
</html>
