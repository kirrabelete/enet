<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Trash</title>

</head>
<body>

<div class="wrapper">

    <div class="modal" id="modal-empty-trash" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Empty Trash</h4>
                </div>

                <div class="modal-body">

                    <p>Are you sure you want to delete all the mails in the trash? once you delete them, You can't access them afterwards.</p>

                </div>
                <g:form class="form-horizontal" method="post" controller="mail" action="emptyTrash">

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
                <g:if test="${numOfUnreadMails > 0}">
                    <small>${numOfUnreadMails} unread messages</small>
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
                                    <g:if test="${numOfUnreadMails > 0}">
                                        <span class="label label-primary pull-right">${numOfUnreadMails}</span>
                                    </g:if>
                                </a>
                                </li>
                                <li><a href="${createLink(controller: 'mail', action: 'sent')}"><i class="fa fa-envelope-o"></i> Sent</a></li>
                                <li class="active"><a href="${createLink(controller: 'mail', action: 'trash')}"><i class="fa fa-trash-o"></i> Trash</a></li>
                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /. box -->
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">Trash</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body no-padding">
                            <g:if test="${!mailsInTrash}">
                                <h1 class="text-center"><i class="fa fa-trash-o"></i></h1>
                                <h4 class="text-center">You have no mail in your Trash</h4><br><br>
                            </g:if>
                            <g:else>
                                <div class="mailbox-controls">
                                    <!-- Check all button -->
                                    <div class="btn-group">
                                        <button class="btn btn-default btn-sm" data-toggle="modal" data-target="#modal-empty-trash" title="Empty Trash"><i class="fa fa-trash-o" ></i></button>
                                    </div><!-- /.btn-group -->
                                    <a href="${createLink(controller: 'mail', action: 'trash')}" class="btn btn-default btn-sm"  data-toggle="tooltip" title="Refresh"><i class="fa fa-refresh"></i></a>
                                </div>
                                <div class="table-responsive mailbox-messages">
                                    <table class="table table-hover">
                                        <tbody>
                                        <g:each in="${mailsInTrash}" var="mail">
                                            <tr>
                                                <td>
                                                    <a class="btn btn-default btn-sm" href="${createLink(controller: 'mail', action: 'restoreFromTrash', params: [mailId: mail.id])}" data-toggle="tooltip" title="Restore">
                                                        <i class="fa fa-recycle"></i></a>
                                                </td>
                                                <td class="mailbox-name"><a href="${createLink(controller: 'mail', action: 'readMail', params: [mailId: mail.id])}"><b>${mail.sender.fullname}</b></a> </td>
                                                <td class="mailbox-subject">
                                                    <g:if test="${mail?.subject}">
                                                        <b>${mail.subject} </b>
                                                    </g:if>
                                                    <g:else>
                                                        <b>(no-subject) </b>
                                                    </g:else>
                                                %{--
                                                                                                - ${raw(mail.content.subSequence(3,10).minus("</p><p>"))}</td>
                                                --}%
                                                <td class="mailbox-attachment">
                                                    <g:if test="${mail?.attachment}">
                                                        <i class="fa fa-paperclip"></i>
                                                    </g:if>
                                                </td>
                                                <td class="mailbox-date">${mail.dateCreated.toLocaleString()}</td>
                                                <td>
                                                    <button class="btn btn-default btn-sm" data-toggle="modal" title="Delete" data-target="#modal-delete-mail-${mail.id}"
                                                    data-mailId="${mail.id}"><i class="fa fa-trash-o" ></i></button>
                                                </td>
                                                <div class="modal" id="modal-delete-mail-${mail.id}" role="dialog">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                <h4 class="modal-title">Delete Mail Permanently</h4>
                                                            </div>

                                                            <div class="modal-body">

                                                                <p>Are you sure you want to delete this mail permanently?</p>

                                                            </div>
                                                            <g:form class="form-horizontal" method="post" controller="mail" action="deleteMailPermanently" params="[mailId: mail.id]">

                                                                <div class="modal-footer">
                                                                    <button type="submit" class="btn btn-primary ">Yes</button>
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                </div>
                                                            </g:form>
                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>

                                                </div>
                                            </tr>
                                        </g:each>
                                        </tbody>

                                    </table><!-- /.table -->
                                </div><!-- /.mail-box-messages -->
                            </g:else>
                        </div><!-- /.box-body -->
                    </div><!-- /. box -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->

<!-- Bootstrap WYSIHTML5 -->
<script src="${resource(dir: 'plugins/bootstrap-wysihtml5', file: 'bootstrap3-wysihtml5.all.min.js')}"></script>

</body>
</html>

