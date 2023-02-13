<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Show Post</title>

</head>
<body>


<div class="wrapper">


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <i class="fa fa-edit"></i> <span>Post</span>
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">Show Post</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <g:if test="${posts}">
                                <g:each in="${posts}" var="post">
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
                                            <input class="form-control input-sm" name="comment" type="text" placeholder="Type a comment and press Enter">
                                        </g:form>

                                    </div><!-- /.post -->

                                </g:each>

                            </g:if>
                            <g:else>
                                <h3 class="col-md-offset-3">The Post No Longer Exists.</h3>
                            </g:else>

                        </div><!-- ./box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->
            </div><!-- /.row -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->

</body>
</html>
