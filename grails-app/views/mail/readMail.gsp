<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Mail</title>

</head>
<body>

<div class="wrapper">

    <div class="modal" id="modal-reply" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Write Reply</h4>
                </div>
                <g:form method="post" controller="mail" action="writeReply" enctype="multipart/form-data" params="[mailId: mailToRead.id]">
                    <div class="modal-body">
                        <!-- Title input-->
                        <div class="form-group">
                            <input class="form-control"
                            <g:if test="${mailToRead.sender == user}">
                                value="To: ${mailToRead.receiver.fullname}"
                            </g:if>
                            <g:if test="${mailToRead.receiver == user}">
                                value="To: ${mailToRead.sender.fullname}"
                            </g:if>
                             type="text" name="receiver" disabled>
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="subject" value="<g:if test="${!mailWithThisReply}">Re: </g:if>${mailToRead?.subject}" disabled>
                        </div>
                        <div class="form-group">
                            <textarea  name="content" placeholder="Write Your reply here..."
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
                            <button type="submit" class="btn btn-primary">Send</button>
                            <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div><!-- /.modal-footer -->
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal" id="modal-forward" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Forward Mail</h4>
                </div>
                <g:form method="post" controller="mail" action="forwardMail" enctype="multipart/form-data" params="[mailId: mailToRead.id]">
                    <div class="modal-body">
                        <!-- Title input-->
                        <div class="form-group">
                            <input required type="text" autocomplete="off" class="form-control searchUsers" name="receiver" placeholder="To:">
                        </div>
                        <div class="form-group">
                            <input class="form-control" name="subject" value="Fwd: ${mailToRead.subject}">
                        </div>
                        <div class="form-group">
                            <textarea name="content"
                                      class="form-control compose-textarea col-md-8" style="height: 150px" required>
                            ${raw(mailToRead.content)}
                            </textarea>
                        </div>
                        <g:if test="${mailToRead?.attachment}">
                            <g:each in="${mailToRead}" var="mail">
                            <div class="box-footer"><br>
                                <ul class="mailbox-attachments clearfix">
                                    <li>
                                        <g:if test="${mail.attachedFileName.endsWith(".pdf")}">
                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-pdf-o"></i></span>
                                        </g:if>
                                        <g:if test="${mail.attachedFileName.endsWith(".docx") || mail.attachedFileName.endsWith(".doc")}">
                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-word-o"></i></span>
                                        </g:if>
                                        <g:if test="${mail.attachedFileName.endsWith(".pptx") || mail.attachedFileName.endsWith(".ppt")}">
                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-powerpoint-o"></i></span>
                                        </g:if>
                                        <g:if test="${mail.attachedFileName.endsWith(".txt")}">
                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-text-o"></i></span>
                                        </g:if>
                                        <g:if test="${mail.attachedFileName.endsWith(".html") || mail.attachedFileName.endsWith(".css") || mail.attachedFileName.endsWith(".js")}">
                                            <span class="mailbox-attachment-icon"><i class="fa fa-firefox"></i></span>
                                        </g:if>
                                        <g:if test="${mail.attachedFileName.endsWith(".png") || mail.attachedFileName.endsWith(".jpeg") || mail.attachedFileName.endsWith(".jpg") || mail.attachedFileName.endsWith(".gif")}">
                                            <span class="mailbox-attachment-icon has-img"><img src="${createLink(controller: 'mail', action: 'renderAttachedImage', params: [mailId: mail.id])}" alt=" "></span>
                                        </g:if>
                                        <g:if test="${mail.attachedFileName.endsWith(".zip") || mail.attachedFileName.endsWith(".rar") || mail.attachedFileName.endsWith(".rars")}">
                                            <span class="mailbox-attachment-icon"><i class="fa fa-file-zip-o"></i></span>
                                        </g:if>
                                        <div class="mailbox-attachment-info">
                                            <a href="${createLink(controller: 'mail', action: 'downloadAttachedFiles', params: [mailId: mail.id])}" class="mailbox-attachment-name"><i class="
                                            <g:if test="${mail.attachedFileName.endsWith(".png") || mail.attachedFileName.endsWith(".jpeg") || mail.attachedFileName.endsWith(".jpg") || mail.attachedFileName.endsWith(".gif")}">
                                                fa-fa-camera
                                            </g:if>
                                            <g:else>
                                                fa fa-paperclip
                                            </g:else>
                                            ">
                                            </i> ${mail.attachedFileName}</a>
                                            <span class="mailbox-attachment-size">
                                                ${(mail.attachment.size().toDouble()/1024).round(1)} KB
                                                <a href="${createLink(controller: 'mail', action: 'downloadAttachedFiles', params: [mailId: mail.id])}" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                                            </span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                          </g:each>
                        </g:if>
                    </div>
                    <div class="modal-footer">
                        <div class="pull-right">
                            <br>
                            <button type="submit" class="btn btn-primary">Forward</button>
                            <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div><!-- /.modal-footer -->
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal" id="modal-delete-mail" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Delete Mail Permanently</h4>
                </div>

                <div class="modal-body">

                    <p>Are you sure you want to delete this mail permanently?</p>

                </div>
                <g:form class="form-horizontal" method="post" controller="mail" action="deleteMailPermanently" params="[mailId: mailToRead.id]">

                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary ">Yes</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>

    </div>


    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Mail
                <g:if test="${unreadMails}">
                    <small>${unreadMails.size()} unread messages</small>
                </g:if>
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-md-3">
                    <a href="${createLink(controller: 'mail', action: 'compose')}" class="btn btn-primary btn-block margin-bottom">Compose</a>
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">Folders</h3>
                            <div class="box-tools">
                                <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                            </div>
                        </div>
                        <div class="box-body no-padding">
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="${createLink(controller: 'mail', action: 'inbox')}"><i class="fa fa-inbox"></i> Inbox
                                    <g:if test="${unreadMails}">
                                        <span class="label label-primary pull-right">${unreadMails.size()}</span>
                                    </g:if>
                                </a>
                                </li>
                                <li><a href="${createLink(controller: 'mail', action: 'sent')}"><i class="fa fa-envelope-o"></i> Sent</a></li>
                                <li><a href="${createLink(controller: 'mail', action: 'trash')}"><i class="fa fa-trash-o"></i> Trash</a></li>
                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /. box -->
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">Read Mail</h3>
                        </div><!-- /.box-header -->
                      <g:each in="${mailToRead}" var="mail">
                        <div class="box-body no-padding">
                            <div class="mailbox-read-info">
                                <g:if test="${mail?.subject}">
                                    <h4>${mail.subject} </h4>
                                </g:if>
                                <g:else>
                                    <h4>(no-subject) </h4>
                                </g:else>
                                <g:if test="${mail.sender == user}">
                                    <h5>To: ${mail.receiver.fullname}<span class="mailbox-read-time pull-right">${mail.dateCreated.toLocaleString()}</span></h5>
                                </g:if>
                                <g:else>
                                    <h5>From: ${mail.sender.fullname}<span class="mailbox-read-time pull-right">${mail.dateCreated.toLocaleString()}</span></h5>
                                </g:else>
                            </div><!-- /.mailbox-read-info -->
                            <div class="mailbox-controls with-border text-center">
                                <div class="btn-group">
                                    <a href="${createLink(controller: 'mail', action: 'moveFromInboxToTrash', params: [mailId: mail.id])}" class="btn btn-default btn-sm" data-toggle="tooltip" title="Send to Trash"><i class="fa fa-trash-o" ></i></a>
                                    <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#modal-reply" title="Reply"><i class="fa fa-reply"></i></button>
                                </div><!-- /.btn-group -->
                                <button class="btn btn-default btn-sm" data-toggle="tooltip" title="Print" onclick="window.print();"><i class="fa fa-print"></i></button>
                                <button class="btn btn-default btn-sm" data-toggle="tooltip" title="Refresh" onclick="window.location.reload();"><i class="fa fa-refresh"></i></button>
                            </div><!-- /.mailbox-controls -->
                            <div class="mailbox-read-message">
                              ${raw(mail.content)}
                            </div><!-- /.mailbox-read-message -->
                        </div><!-- /.box-body -->
                        <g:if test="${mail?.attachment}">
                            <div class="box-footer">
                                <ul class="mailbox-attachments clearfix">
                                        <li>
                                            <g:if test="${mail.attachedFileName.endsWith(".pdf")}">
                                                <span class="mailbox-attachment-icon"><i class="fa fa-file-pdf-o"></i></span>
                                            </g:if>
                                            <g:if test="${mail.attachedFileName.endsWith(".docx") || mail.attachedFileName.endsWith(".doc")}">
                                                <span class="mailbox-attachment-icon"><i class="fa fa-file-word-o"></i></span>
                                            </g:if>
                                            <g:if test="${mail.attachedFileName.endsWith(".pptx") || mail.attachedFileName.endsWith(".ppt")}">
                                                <span class="mailbox-attachment-icon"><i class="fa fa-file-powerpoint-o"></i></span>
                                            </g:if>
                                            <g:if test="${mail.attachedFileName.endsWith(".txt")}">
                                                <span class="mailbox-attachment-icon"><i class="fa fa-file-text-o"></i></span>
                                            </g:if>
                                            <g:if test="${mail.attachedFileName.endsWith(".html") || mail.attachedFileName.endsWith(".css") || mail.attachedFileName.endsWith(".js")}">
                                                <span class="mailbox-attachment-icon"><i class="fa fa-firefox"></i></span>
                                            </g:if>
                                            <g:if test="${mail.attachedFileName.endsWith(".png") || mail.attachedFileName.endsWith(".jpeg") || mail.attachedFileName.endsWith(".jpg") || mail.attachedFileName.endsWith(".gif")}">
                                                <span class="mailbox-attachment-icon has-img"><img src="${createLink(controller: 'mail', action: 'renderAttachedImage', params: [mailId: mail.id])}" alt=" "></span>
                                            </g:if>
                                            <g:if test="${mail.attachedFileName.endsWith(".zip") || mail.attachedFileName.endsWith(".rar") || mail.attachedFileName.endsWith(".rars")}">
                                                <span class="mailbox-attachment-icon"><i class="fa fa-file-zip-o"></i></span>
                                            </g:if>
                                            <div class="mailbox-attachment-info">
                                                <a href="${createLink(controller: 'mail', action: 'downloadAttachedFiles', params: [mailId: mail.id])}" class="mailbox-attachment-name"><i class="
                                           <g:if test="${mail.attachedFileName.endsWith(".png") || mail.attachedFileName.endsWith(".jpeg") || mail.attachedFileName.endsWith(".jpg") || mail.attachedFileName.endsWith(".gif")}">
                                                fa-fa-camera
                                           </g:if>
                                           <g:else>
                                               fa fa-paperclip
                                           </g:else>
                                                ">
                                                </i> ${mail.attachedFileName}</a>
                                                <span class="mailbox-attachment-size">
                                                    ${(mail.attachment.size().toDouble()/1048576).round(2)} MB
                                                    <a href="${createLink(controller: 'mail', action: 'downloadAttachedFiles', params: [mailId: mail.id])}" class="btn btn-default btn-xs pull-right"><i class="fa fa-cloud-download"></i></a>
                                                </span>
                                            </div>
                                        </li>
                                </ul>
                            </div><!-- /.box-footer -->
                        </g:if>
                          <g:if test="${mailWithThisReply}">
                              <div class="box-footer">
                               <div class="mailbox-read-message">
                              <g:each in="${mailWithThisReply}" var="mails">
                              On: ${mails.dateCreated.toLocaleString()}
                              <a href="${createLink(controller: 'profile', action: 'showProfile', params: [selectedName: mails.sender.fullname + " | " + mails.sender.username])}">${mails.sender.fullname}</a> Wrote:
                               </div>
                              <div class="mailbox-read-message">
                                  ${raw(mails.content)}
                              </div><!-- /.mailbox-read-message -->
                             </g:each>
                          </g:if>

                          <div class="box-footer">
                            <div class="pull-right">
                                <button class="btn btn-default" data-toggle="modal" data-target="#modal-reply"><i class="fa fa-reply"></i> Reply</button>
                                <button class="btn btn-default"data-toggle="modal" data-target="#modal-forward"><i class="fa fa-share"></i> Forward</button>
                            </div>
                            <button class="btn btn-default" data-toggle="modal" data-target="#modal-delete-mail"><i class="fa fa-trash-o"></i> Delete</button>
                        </div><!-- /.box-footer -->
                        </g:each>
                    </div><!-- /. box -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->

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

