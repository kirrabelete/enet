<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Home</title>

</head>
<body>

<div class="modal" id="modal-search" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Search Users</h4>
            </div>
                <div class="modal-body">
                    <form action="${createLink(controller: 'profile', action: 'showProfile')}">
                        <div class="input-group col-md-offset-2  col-md-8">
                            <input type="text" name="selectedName" autocomplete="off" placeholder="Search Users..." class="form-control searchUsers">
                            <span class="input-group-btn">
                                <button class="btn btn-info btn-flat" type="submit">Search</button>
                            </span>
                        </div><!-- /input-group -->
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="pull-right">
                        <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div><!-- /.modal-footer -->
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="modal" id="modal-post" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Create New Post</h4>
            </div>
            <g:form method="post" controller="post" action="addNewPost" enctype="multipart/form-data">
                <div class="modal-body">
                    <!-- Title input-->
                    <div class="form-group">
                        <textarea name="content" placeholder="Write Your post here..."
                                  class="form-control col-md-8 compose-textarea" style="height: 150px" required>
                        </textarea>
                    </div>
                    <div class="form-group">
                        <div class="btn btn-default btn-file">
                            <i class="fa fa-paperclip"></i> Attachment
                            <input type="file" name="attachment">
                        </div>
                        <p class="help-block">Max. Size 15MB</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right">
                        <button type="submit" class="btn btn-primary">Post</button>
                        <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div><!-- /.modal-footer -->
            </g:form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
 </div>

<div class="modal" id="modal-post-reg" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Create New Post</h4>
            </div>
            <g:form method="post" controller="post" action="addNewRegistrarPost" enctype="multipart/form-data">
                <div class="modal-body">
                    <!-- Title input-->
                    <div class="form-group col-md-8">
                        <label>Departments</label>
                        <select class="form-control select2" name="department" style="width: 100%;">
                            <option value="all">All Departments</option>
                            <g:each in="${departments.department}" var="d">
                                <option value="${d}">${d}</option>
                            </g:each>
                        </select>
                    </div><!-- /.form-group -->
                    <div class="form-group col-md-4">
                        <label>Years</label>
                            <select class="form-control select2" id="year" name="year" style="width: 100%;">
                                <option value="0">All Years</option>
                                <option value="1st">1st Year</option>
                                <option value="2nd">2nd Year</option>
                                <option value="3rd">3rd Year</option>
                                <option value="4th">4th Year</option>
                                <option value="5th">5th Year</option>
                            </select>
                    </div><!-- /.form-group -->
                    <div class="form-group">
                        <br>
                        <textarea name="content" placeholder="Write Your post here..."
                                  class="form-control col-md-8 compose-textarea" style="height: 150px" required>
                        </textarea>
                    </div>
                    <div class="form-group">
                        <div class="btn btn-default btn-file">
                            <i class="fa fa-paperclip"></i> Attachment
                            <input type="file" name="attachment">
                        </div>
                        <p class="help-block">Max. Size 15MB</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="pull-right">
                        <button type="submit" class="btn btn-primary">Post</button>
                        <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </div><!-- /.modal-footer -->
            </g:form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<div class="wrapper">


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <i class="fa fa-home"></i> <span>Home</span>
            </h1>
            <ol class="breadcrumb">
                <sec:ifAllGranted roles="ROLE_TEACHER">
                    <button class="btn btn-primary" data-toggle="modal" data-target="#modal-post"><i class="fa fa-edit"></i> Create New Post</button>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                    <button class="btn btn-primary" data-toggle="modal" data-target="#modal-post-reg"><i class="fa fa-edit"></i> Create New Post </button>
                </sec:ifAllGranted>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">Important Posts</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                        <g:if test="${(!user?.profile) || (user.getAuthorities().authority.contains("ROLE_STUDENT") && !user.following)}">
                            <div class="box">
                                <div class="box-header with-border">
                                    <h5 class="box-title">new to enet?</h5>
                                    <div class="box-tools pull-right">
                                        <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                                    </div><!-- /.box-tools -->
                                </div><!-- /.box-header -->
                                <div class="box-body">
                                    <p>You can use the links below to get the best out of enet and be more productive.</p>
                                    <div class="row">
                                        <div class="col-lg-4 col-xs-6">
                                            <!-- small box -->
                                            <div class="small-box bg-aqua">
                                                <div class="inner">
                                                    <h4>Profile</h4> <!--group name-->
                                                    <p>Update your user profile.</p> <!--group type-->
                                                </div>
                                                <div class="icon">
                                                    <i class="fa fa-user"></i>
                                                </div>
                                                <a href="${createLink(controller: 'profile')}" class="small-box-footer">Go to profile <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div><!-- ./col -->
                                    <div class="col-lg-4 col-xs-6">
                                        <!-- small box -->
                                        <div class="small-box bg-yellow">
                                            <div class="inner">
                                                <h4>Connect</h4> <!--group name-->
                                                <p>search for teachers to follow.</p> <!--group type-->
                                            </div>
                                            <div class="icon">
                                                <i class="fa fa-search"></i>
                                            </div>
                                            <a href="#" data-toggle="modal" data-target="#modal-search" class="small-box-footer">Search <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div><!-- ./col -->
                                    <div class="col-lg-4 col-xs-12">
                                        <!-- small box -->
                                        <div class="small-box bg-green">
                                            <div class="inner">
                                                <h4>Groups</h4> <!--group name-->
                                                <p>create a group or join others.</p> <!--group type-->
                                            </div>
                                            <div class="icon">
                                                <i class="fa fa-group"></i>
                                            </div>
                                            <a href="${createLink(controller: 'group')}" class="small-box-footer">Go to groups <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>
                                    </div><!-- ./col -->
                                </div><!-- /.row -->
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->
                      </g:if>
                        <g:if test="${postsForCurrentUser}">
                            <g:each in="${postsForCurrentUser}" var="post">
                                <div class="post">
                                    <div class="user-block">
                                        <g:if test="${post.user.profile?.profilePicture}">
                                            <img class="img-circle img-bordered-sm" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: post.user.id])}" alt="profile picture">
                                        </g:if>
                                        <g:else>
                                            <img class="img-circle img-bordered-sm" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                        </g:else>

                                        <span class='username'>
                                            <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: post.user] )}">${post.user?.fullname}</a>
                                        </span>
                                        <span class='description'>${post.dateCreated.toLocaleString()}</span>
                                    </div><!-- /.user-block -->
                                    <p>
                                        ${raw(post?.content)}
                                        <g:if test="${post?.attachment}">
                                            <b>Attachement: </b>  <a href="${createLink(controller: 'dashboard', action: 'downloadAttachedFiles', params: [postId: post?.id])}">${post.attachedFileName}</a>
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
                                                                        <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: reply.user] )}">${reply.user?.fullname}</a>
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
                                                        <h4 class="text-center">There are no comments for this post.</h4>
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
                        <g:else>
                            <h3 class="text-center">
                                There are no posts for you.
                            </h3>
                        </g:else>

                    </div><!-- ./box-body -->
                   </div><!-- /.box -->
                </div><!-- /.col -->
            </div><!-- /.row -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->

<!-- Select2 -->
<script src="${resource(dir: 'plugins/select2', file: 'select2.full.min.js')}"></script>


<script>
    $(function () {
        $(".select2").select2();
    });
</script>

<!-- Bootstrap WYSIHTML5 -->
<script src="${resource(dir: 'plugins/bootstrap-wysihtml5', file: 'bootstrap3-wysihtml5.all.min.js')}"></script>

<!-- Page Script -->
<script>
    $(function () {
        //Add text editor
        $(".compose-textarea").wysihtml5();
    });
</script>

</body>
</html>
