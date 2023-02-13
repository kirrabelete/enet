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
                            <g:if test="${post}">
                                <g:each in="${post}">
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
                                            <g:if test="${post?.attachment}">
                                                <ul class="mailbox-attachments clearfix">
                                                    <li>
                                                        <g:if test="${post.attachedFileName.endsWith(".pdf")}">
                                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-pdf-o"></i></span>
                                                        </g:if>
                                                        <g:if test="${post.attachedFileName.endsWith(".docx") || post.attachedFileName.endsWith(".doc")}">
                                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-word-o"></i></span>
                                                        </g:if>
                                                        <g:if test="${post.attachedFileName.endsWith(".pptx") || post.attachedFileName.endsWith(".ppt")}">
                                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-powerpoint-o"></i></span>
                                                        </g:if>
                                                        <g:if test="${post.attachedFileName.endsWith(".txt")}">
                                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-text-o"></i></span>
                                                        </g:if>
                                                        <g:if test="${post.attachedFileName.endsWith(".html") || post.attachedFileName.endsWith(".css") || post.attachedFileName.endsWith(".js")}">
                                                            <span class="mailbox-attachment-icon"><i class="fa fa-firefox"></i></span>
                                                        </g:if>
                                                        <g:if test="${post.attachedFileName.endsWith(".png") || post.attachedFileName.endsWith(".jpeg") || post.attachedFileName.endsWith(".jpg") || post.attachedFileName.endsWith(".gif")}">
                                                            <span class="mailbox-attachment-icon has-img"><img src="${createLink(controller: 'post', action: 'renderAttachedImage', params: [postId: post.id])}" alt=" "></span>
                                                        </g:if>
                                                        <g:if test="${post.attachedFileName.endsWith(".zip") || post.attachedFileName.endsWith(".rar") || post.attachedFileName.endsWith(".rars")}">
                                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-zip-o"></i></span>
                                                        </g:if>
                                                        <div class="mailbox-attachment-info">
                                                            <a href="${createLink(controller: 'dashboard', action: 'downloadAttachedFiles', params: [postId: post?.id])}" class="mailbox-attachment-name"><i class="
                                                            <g:if test="${post.attachedFileName.endsWith(".png") || post.attachedFileName.endsWith(".jpeg") || post.attachedFileName.endsWith(".jpg") || post.attachedFileName.endsWith(".gif")}">
                                                                fa-fa-camera
                                                            </g:if>
                                                            <g:else>
                                                                fa fa-paperclip
                                                            </g:else>
                                                            ">
                                                            </i> ${post.attachedFileName}</a>
                                                            <span class="mailbox-attachment-size">
                                                                ${(post.attachment.size().toDouble()/1024).round(1)} KB
                                                                <a href="${createLink(controller: 'dashboard', action: 'downloadAttachedFiles', params: [postId: post?.id])}" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                                                            </span>
                                                        </div>
                                                    </li>
                                                </ul>
                                            </g:if>
                                        </p>
                                    <div class="box-footer">
                                    <g:form controller="dashboard" action="saveComments" params="[postId : post.id]">
                                        <g:if test="${user.profile?.profilePicture}">
                                            <img src="${createLink(controller: 'profile', action: 'renderImage')}" class="img-responsive img-circle img-sm" alt="User Image">
                                        </g:if>
                                        <g:else>
                                            <img src="${resource(dir: 'images', file: 'avatar.png')}" class="img-responsive img-circle img-sm" alt="User Image">
                                        </g:else>

                                        <div class="img-push">
                                                <input class="form-control input-sm" name="comment" type="text" placeholder="Type a comment and press Enter">
                                            </div>
                                    </g:form>
                                    </div><!-- /.box-footer -->

                                    <ul class="list-inline">
                                        <li><a class="link-black text-sm btn"><i class="fa fa-comments-o margin-r-5"></i> Comments (${post.replies.size()})</a></li>
                                    </ul>

                                    <div class='box-footer box-comments'>
                                    <g:if test="${post.replies}">
                                        <g:each in="${post.replies}" var="reply">
                                            <div class='box-comment'>
                                            <!-- User image -->
                                                <g:if test="${reply.user.profile?.profilePicture}">
                                                    <img class="img-circle img-sm" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: reply.user.id])}" alt="User profile picture">
                                                </g:if>
                                                <g:else>
                                                    <img class="img-circle img-sm" src="${resource(dir: 'images', file: 'avatar.png')}" alt="user image">
                                                </g:else>
                                            <div class='comment-text'>
                                                <span class="username">
                                                    <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: reply.user] )}">${reply.user?.fullname}</a>
                                                    <span class='text-muted pull-right'>${reply.dateCreated.toLocaleString()}</span>
                                                </span><!-- /.username -->
                                                ${raw(reply?.content)}
                                            </div><!-- /.comment-text -->
                                        </div><!-- /.box-comment -->                                                                                         <!-- Post -->
                                        </g:each>
                                    </g:if>
                                 </div><!-- /.box-footer -->
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
