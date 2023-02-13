<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Sent</title>

</head>
<body>

<div class="wrapper">

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
                                <li class="active"><a href="${createLink(controller: 'mail', action: 'sent')}"><i class="fa fa-envelope-o"></i> Sent</a></li>
                                <li><a href="${createLink(controller: 'mail', action: 'trash')}"><i class="fa fa-trash-o"></i> Trash</a></li>
                            </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /. box -->
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">Sent Mail</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body no-padding">
                        <g:if test="${!mailsSentByCurrentUser}">
                            <h1 class="text-center"><i class="fa fa-envelope-o"></i></h1>
                            <h4 class="text-center">You haven't sent a mail yet.</h4><br><br>
                        </g:if>
                        <g:else>
                            <div class="mailbox-controls">
                                <!-- Check all button -->
                                <a href="${createLink(controller: 'mail', action: 'sent')}" class="btn btn-default btn-sm"  data-toggle="tooltip" title="Refresh"><i class="fa fa-refresh"></i> Refresh</a>
                            </div>
                            <div class="table-responsive mailbox-messages">
                                <table class="table table-hover">
                                    <tbody>
                                    <g:each in="${mailsSentByCurrentUser}" var="mail">
                                        <tr>
                                            <td>
                                                <a href="${createLink(controller: 'profile', action: 'showProfile', params: [selectedName: mail.receiver])}" class="btn btn-default btn-sm" data-toggle="tooltip" title="Show receiver profile"><i class="glyphicon glyphicon-user" ></i></a>
                                            </td>
                                            <td class="mailbox-name"><a href="${createLink(controller: 'mail', action: 'readMail', params: [mailId: mail.id])}">To: <b>${mail.receiver.fullname}</b></a> </td>
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
                                                <a href="${createLink(controller: 'mail', action: 'moveFromSentToTrash', params: [mailId: mail.id])}" class="btn btn-default btn-sm" data-toggle="tooltip" title="Send to Trash"><i class="fa fa-trash-o" ></i></a>
                                            </td>
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

