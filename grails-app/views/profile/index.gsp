<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Profile</title>

</head>
<body>
<div class="wrapper">

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                User Profile
            </h1>

        </section>
        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-3">

                    <!-- Profile Image -->
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <g:if test="${user.profile?.profilePicture}">
                                <img class="profile-user-img img-responsive img-circle" src="${createLink(controller: 'profile', action: 'renderImage')}" alt="User profile picture">
                            </g:if>
                            <g:else>
                                <img class="profile-user-img img-responsive img-circle" src="${resource(dir: 'images', file: 'avatar.png')}" alt="User profile picture">
                            </g:else>
                        <!--            <div class="profile-user-img img-responsive img-circle"><span class="fa fa-user col-md-offset-5"></span></div>-->
                            <h3 class="profile-username text-center">${user.fullname}</h3>
                        <!-- Role -->
                            <sec:ifAllGranted roles="ROLE_STUDENT">
                                <p class="text-muted text-center">Studnet</p>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <p class="text-muted text-center">Admin</p>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_TEACHER">
                                <p class="text-muted text-center">Teacher</p>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                                <p class="text-muted text-center">Office Employee</p>
                            </sec:ifAllGranted>

                            <ul class="list-group list-group-unbordered">
                                <g:if test="${user.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                    <li class="list-group-item">
                                        <b>Year</b> <a class="pull-right">${user.profile?.year}</a>
                                    </li>
                                </g:if>
                                <g:if test="${!user.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                    <li class="list-group-item">
                                        <b>Year Started</b> <a class="pull-right">${user.profile?.year}</a>
                                    </li>
                                </g:if>
                                <li class="list-group-item">
                                    <b>ID Number</b> <a class="pull-right">${user.profile?.idNumber}</a>
                                </li>

                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->

                    <g:if test="${user.getAuthorities().authority.contains("ROLE_STUDENT") || user.getAuthorities().authority.contains("ROLE_TEACHER")}">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">
                                <i class="fa fa-book margin-r-5"></i>  Education
                            </h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <strong>Department</strong>
                            <p class="text-muted">
                                ${user.profile?.department}
                            </p>
                            <strong>Stream</strong>
                            <p class="text-muted">
                                ${user.profile?.stream}
                            </p>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                    </g:if>
                    <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                        <div class="box box-primary">
                            <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i class="fa fa-briefcase margin-r-5"></i>  Employment
                                </h3>
                            </div><!-- /.box-header -->
                            <div class="box-body">
                                <strong>Job Position</strong>
                                <p class="text-muted">
                                    ${user.profile?.position}
                                </p>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                    </sec:ifAllGranted>
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">About Me</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <p class="text-muted">
                                ${user.profile?.aboutMe}
                            </p>

                            <hr>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#activity" data-toggle="tab">Profile</a></li>
                            <li><a href="#settings" data-toggle="tab">Activity</a></li>
                            <li><a href="#profile" data-toggle="tab">Settings</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="active tab-pane" id="activity">
                                <g:form controller="profile" action="uploadProfilePic" method="post" enctype="multipart/form-data" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="file-0a" class="col-sm-2 control-label">Profile Picture</label>
                                        <div class="col-sm-10">
                                            <input id="file-0a"  class="file" name="profilePic" type="file" multiple data-min-file-count="1">
                                        </div>
                                    </div>
                                    <br>
                                </g:form>
                                <g:form controller="profile" action="updateProfile" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="id-no" class="col-sm-2 control-label">Id Number</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="id-no" name="idNumber" value="${user.profile?.idNumber}" placeholder="ID Number">
                                        </div>
                                    </div>
                                    <g:if test="${user.getAuthorities().authority.contains("ROLE_STUDENT") || user.getAuthorities().authority.contains("ROLE_TEACHER")}">
                                        <div class="form-group">
                                        <label for="department" class="col-sm-2 control-label">Department</label>
                                        <div class="col-sm-10">
                                            <select class="form-control select2"  id="department" name="department" required="required">
                                                <option value="${user.profile?.department}">${user.profile?.department}</option>
                                                <g:each in="${departments.department - user.profile?.department}" var="d">
                                                    <option value="${d}">${d}</option>
                                                </g:each>
                                            </select>
                                        </div>
                                    </div>
                                    </g:if>
                                    <g:if test="${user.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                        <div class="form-group">
                                            <label for="years" class="col-sm-2 control-label">Year</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="years" name="year" style="width: 100%;">
                                                    <option value="${user.profile?.year}">${user.profile?.year}</option>
                                                    <option value="1st">1st Year</option>
                                                    <option value="2nd">2nd Year</option>
                                                    <option value="3rd">3rd Year</option>
                                                    <option value="4th">4th Year</option>
                                                    <option value="5th">5th Year</option>
                                                </select>
                                            </div>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <div class="form-group">
                                            <label for="year" class="col-sm-2 control-label">Year Started</label>
                                            <div class="col-sm-10">
                                                <input type="number" min="1" class="form-control" id="year" name="year" placeholder="year" value="${user.profile?.year}" required>
                                            </div>
                                        </div>
                                    </g:else>
                                    <g:if test="${user.getAuthorities().authority.contains("ROLE_STUDENT") || user.getAuthorities().authority.contains("ROLE_TEACHER")}">
                                    <div class="form-group">
                                        <label for="stream" class="col-sm-2 control-label">Stream</label>
                                        <div class="col-sm-10">
                                            <input type=text class="form-control" id="stream" name="stream" value="${user.profile?.stream}" placeholder="Stream">
                                        </div>
                                    </div>
                                    </g:if>
                                    <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                                        <div class="form-group">
                                            <label for="position" class="col-sm-2 control-label">Job Posititon</label>
                                            <div class="col-sm-10">
                                                <input type=text class="form-control" id="position" name="position" value="${user.profile?.position}" placeholder="Job Position">
                                            </div>
                                        </div>
                                    </sec:ifAllGranted>
                                    <div class="form-group">
                                        <label for="inputExperience" class="col-sm-2 control-label">About Me</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" id="inputExperience" name="aboutMe" placeholder="About Me">${user.profile?.aboutMe}</textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <button type="submit" class="btn btn-danger">Submit</button>
                                        </div>
                                    </div>
                                </g:form>

                            </div><!-- /.tab-pane -->
                            <div class="tab-pane" id="settings">
                                <g:if test="${postsByThisUser}">
                                    <g:each in="${postsByThisUser}" var="post">
                                        <div class="post">
                                            <div class="user-block">
                                                <g:if test="${post.user.profile?.profilePicture}">
                                                    <img class="img-circle img-bordered-sm" src="${createLink(controller: 'profile', action: 'renderImage', params: [userId: post.user.id])}" alt="profile picture">
                                                </g:if>
                                                <g:else>
                                                    <img class="img-circle img-bordered-sm" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                                </g:else>

                                                <span class='username'>
                                                    <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: post.user?.fullname +" | "+ post.user.username] )}">${post.user?.fullname}</a>
                                                    <a href='#' class='btn btn-default pull-right' title="Delete Post"
                                                       data-toggle="modal" data-target="#delete-post-${post.id}"><i class='fa fa-trash-o'></i></a>
                                                </span>
                                                <div class="modal" id="delete-post-${post.id}" role="dialog">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                <h4 class="modal-title">Delete Post Permanently</h4>
                                                            </div>

                                                            <div class="modal-body">

                                                                <p>Are you sure you want to delete this post permanently?</p>

                                                            </div>
                                                            <g:form class="form-horizontal" method="post" controller="profile" action="deletePost" params="[postId: post.id]">

                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary ">Yes</button>
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                </div>
                                                            </g:form>
                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>

                                                </div>

                                                <span class='description'>
                                                    <g:if test="${post.isComment}">
                                                        Commented on a <a href="${createLink(controller: 'post', action: 'showPostForThisReply', params:[postId: post.id] )}">Post</a>
                                                    </g:if>  ${post.dateCreated.toLocaleString()}</span>
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
                                                                                <img class="img-circle img-bordered-sm" src="${createLink(controller: 'profile', action: 'renderImageForuser', params: [userId: reply.user.id])}" alt="User profile picture">
                                                                            </g:if>
                                                                            <g:else>
                                                                                <img class="img-circle img-bordered-sm" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                                                            </g:else>

                                                                            <span class='username'>
                                                                                <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: reply.user?.fullname +" | "+ post.user.username] )}">${reply.user?.fullname}</a>
                                                                            </span>
                                                                            <span class='description'>${reply.dateCreated.toLocaleString()}</span>
                                                                        </div><!-- /.user-block -->
                                                                        <p>
                                                                            ${raw(reply?.content)}
                                                                        </p>

                                                                    </div><!-- /.post -->
                                                 <!-- Post -->
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
                                                <input class="form-control input-sm" name="comment" type="text" placeholder="Type a comment and Press Enter">
                                            </g:form>

                                        </div><!-- /.post -->

                                    </g:each>

                                </g:if>
                            <g:else>
                                <h1 class="text-center"><i class="fa fa-feed"></i></h1>
                                <h4 class="text-center">There are no Activities from you</h4>
                            </g:else>

                            </div><!-- /.tab-pane -->
                            <div class="tab-pane" id="profile">
                            <div class="box box-info">
                                <div class="box-header with-border">
                                    <h3 class="box-title">
                                        <i class="fa fa-user margin-r-5"></i>  Change Personal Details
                                    </h3>
                                </div><!-- /.box-header -->
                                <div class="box-body">
                                <g:form controller="profile" action="updateUser" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="username" class="col-sm-2 control-label">Username</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="fullname" class="col-sm-2 control-label">Full Name</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" id="fullname" name="fullname" value="${user.fullname}" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-offset-10 col-xs-12">
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                        </div>
                                    </div>
                                </g:form>
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                           <div class="box box-info">
                                <div class="box-header with-border">
                                <h3 class="box-title">
                                    <i class="fa fa-lock margin-r-5"></i>  Change Password
                                </h3>
                            </div><!-- /.box-header -->
                            <div class="box-body">
                                <g:form controller="profile" action="changePassword" class="form-horizontal">
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Current Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control"  name="curPassword" placeholder="current password" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">New Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control"id="newPassword" name="newPassword" placeholder="new password" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">Confirm Password</label>
                                        <div class="col-sm-10">
                                            <input type="password" class="form-control" id="conPassword" name="conPassword" placeholder="confirm password" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-offset-10 col-xs-12">
                                            <button type="submit" id="submit" class="btn btn-primary">Submit</button>
                                        </div>
                                    </div>
                                </g:form>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                        </div><!-- /.tab-pane -->
                        </div><!-- /.tab-content -->
                    </div><!-- /.nav-tabs-custom -->
                </div><!-- /.col -->
            </div><!-- /.row -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<!-- REQUIRED JS for this page -->

<!-- For file upload purposes -->
<script src="${resource(dir: 'plugins/file-upload-previewer/js', file: 'fileinput.min.js')}" type="text/javascript"></script>
<!-- Select2 -->
<script src="${resource(dir: 'plugins/select2', file: 'select2.full.min.js')}"></script>

<script>
    $(function () {
        $(".select2").select2({
            placeholder: 'select a department'
        });

        $("#years").select2({
            placeholder: 'select your year'
        });

    });
</script>

%{-- script for conformation of password equals repeated password --}%

<script>

    $(document).ready(function(){
        $('#submit').click(function(event){
            if($('#newPassword').val() != $('#conPassword').val()) {
                alert("Password and Confirm password don't match, Please correct your inputs");
                event.preventDefault();
            }
        });
    });
</script>


<script type="text/javascript">
    $("#file-0a").fileinput({
        'allowedFileExtensions' : ['jpg', 'png','gif'],
    });
</script>
</body>
</html>





