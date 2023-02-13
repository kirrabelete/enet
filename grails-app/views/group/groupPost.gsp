<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Group Posts</title>

</head>
<body>
<div class="wrapper">

    <div class="modal" id="modal-group-post" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Create New Group Post</h4>
                </div>
                <g:form method="post" controller="group" action="createGroupPost" params="[groupId: selectedGroup.id]" enctype="multipart/form-data">
                    <div class="modal-body">
                        <!-- Title input-->
                        <div class="form-group">
                            <textarea id="compose-textarea" name="content" placeholder="Write Your post here..."
                                      class="form-control col-md-8" style="height: 150px" required>
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

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            <i class="fa fa-group"></i> <span>GroupPosts</span>
        </h1>
        <br>
        <g:form method="post" controller="group" action="searchGroupByName">
            <div class="input-group col-md-offset-4  col-md-4">
                <input type="text" name="groupName" autocomplete="off" placeholder="Search Groups ..." class="form-control searchGroups">
                <span class="input-group-btn">
                    <button class="btn btn-info btn-flat" type="submit">Search</button>
                </span>
            </div><!-- /input-group -->
        </g:form>
    </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-3">

                    <!-- Profile Image -->
                    <div class="box box-primary">
                    <div class="box-body box-profile">
                        <div class="small-box bg-aqua-active">
                        <div class="inner">
                            <h3>${selectedGroup.members.size()}</h3> <!--number of people-->
                            <p>${selectedGroup.name}</p> <!--group name-->
                            <small>${selectedGroup.type}</small> <!--group type-->
                        </div>
                        <div class="icon">
                            <i class="fa fa-group"></i>
                        </div>

                        <a href="${createLink(controller: 'group', action: 'showGroup', params: [groupId: selectedGroup.id])}" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>

                    </div>

                    <ul class="list-group list-group-unbordered">
                        <li class="list-group-item">
                            <b>Members</b> <span class="label label-info pull-right">${selectedGroup.members.size()}</span>
                        </li>
                    </ul>
                    <a href="${createLink(controller: 'group', action: 'showGroup', params: [groupId: selectedGroup.id])}" class="btn btn-primary btn-block"><b>More Info</b></a>


                </div><!-- /.box -->

                </div>
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header with-border">
                                    <h3 class="box-title">Group Posts</h3>
                                    <div class="box-tools pull-right">
                                        <button class="btn btn-default" data-toggle="modal" data-target="#modal-group-post"><i class="fa fa-edit"></i> Write Group Post</button>
                                    </div>
                                </div><!-- /.box-header -->
                                <div class="box-body">

                                    <g:if test="${groupPosts}">
                                        <g:each in="${groupPosts}" var="post">
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
                                                    <span class='description'>${post.dateCreated.toLocaleString()}</span>
                                                </div><!-- /.user-block -->
                                                <p>
                                                    ${raw(post?.content)}
                                                </p>
                                                <p>
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
                                                                                    <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: reply.user?.fullname +" | "+ reply.user.username] )}">${post.user?.fullname}</a>
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

                                                <g:form controller="group" action="addGroupComment" params="[groupId: selectedGroup.id, postId: post.id]">
                                                    <input class="form-control input-sm" name="comment" type="text" placeholder="Type a comment and Press Enter">
                                                </g:form>

                                            </div><!-- /.post -->

                                        </g:each>

                                    </g:if>

                                    <g:if test="${!groupPosts}">
                                        <div class="post clearfix">
                                            <h3 class="col-md-offset-3">

                                                No Posts found for this group.

                                            </h3>

                                        </div><!-- /.post -->
                                    </g:if>

                                </div><!-- ./box-body -->
                                <div class="box-footer">

                                </div><!-- /.box-footer -->
                            </div><!-- /.box -->
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                </div>
              </div>
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<!-- REQUIRED JS for this page -->

<!-- Bootstrap WYSIHTML5 -->
<script src="${resource(dir: 'plugins/bootstrap-wysihtml5', file: 'bootstrap3-wysihtml5.all.min.js')}"></script>

<!-- Page Script -->
<script>
    $(function () {
        //Add text editor
        $("#compose-textarea").wysihtml5();

    });

    $(document).ready(function(){
        var allGroups = [

            <g:each in='${allGroups}' var='group'>
            '${group.name}',
            </g:each>

        ];
        $(".searchGroups").typeahead({
            source: allGroups
        });

    });
</script>
</body>
</html>
