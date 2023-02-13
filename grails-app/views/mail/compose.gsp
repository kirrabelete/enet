<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Compose</title>

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
                    <a href="${createLink(controller: 'mail', action: 'inbox')}" class="btn btn-primary btn-block margin-bottom">Back to Inbox</a>
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
                            <h3 class="box-title">Compose New Mail</h3>
                        </div><!-- /.box-header -->
                        <g:form method="post" controller="mail" action="addNewMail" enctype="multipart/form-data">
                            <div class="box-body">
                                <div class="form-group">
                                    <input required type="text" autocomplete="off" class="form-control searchUsers" name="receiver" placeholder="To:">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" name="subject" placeholder="Subject:">
                                </div>
                                <div class="form-group">
                                    <textarea required name="content" id="compose-textarea" placeholder="Write Your Message here..." class="form-control" style="height: 200px">
                                    </textarea>
                                </div>
                                <div class="form-group">
                                    <div class="btn btn-default btn-file">
                                        <i class="fa fa-paperclip"></i> Attachment
                                        <input type="file" name="attachment">
                                    </div>
                                    <p class="help-block">Max. 15MB</p>
                                </div>
                            </div><!-- /.box-body -->
                            <div class="box-footer">
                                <div class="pull-right">
                                    <a href="${createLink(controller: 'mail', action: 'compose')}" class="btn btn-default"><i class="fa fa-times"></i> Cancel</a>
                                    <button type="submit" class="btn btn-primary"><i class="fa fa-envelope-o"></i> Send</button>
                                </div>
                            </div><!-- /.box-footer -->
                        </g:form>
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
        $("#compose-textarea").wysihtml5();
    });
</script>

</body>
</html>


