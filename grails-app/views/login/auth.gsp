<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>enet | Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${resource(dir: 'plugins/font-awesome-4.4.0/css', file: 'font-awesome.min.css')}">
    <!-- Theme style -->
    <link rel="stylesheet" href="${resource(dir: 'plugins/dist/css', file: 'AdminLTE.min.css')}">
    <!-- iCheck -->
    <link rel="stylesheet" href="${resource(dir: 'plugins/iCheck/square', file: 'blue.css')}">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href=""><b><i>e</i></b>net</a>
    </div><!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">Sign in to start your session</p>
        <g:if test='${flash.message}'>
            <div class='login_message'><p style="color: red;">${flash.message}</p></div>
        </g:if>
         <form action='${postUrl}' method="post" autocomplete="off">
        <div class="form-group has-feedback">
            <input type="text" class="form-control" name="j_username" autofocus="true" placeholder="Username" required>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-feedback">
            <input type="password" class="form-control" name="j_password" placeholder="Password" required>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-xs-8">
                <div class="checkbox icheck">
                    <label>
                        <input type="checkbox" name="${rememberMeParameter}" <g:if test='${hasCookie}'>checked='checked'</g:if> />
                        Remember Me
                    </label>
                </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
                <button type="submit" class="btn btn-primary btn-block btn-flat">Login</button>
            </div><!-- /.col -->
        </div>
    </form>

        <div class="social-auth-links text-center">
            <p>- OR -</p>
            <a href="${createLink(controller: 'registration', action: 'index')}" class="btn btn-block btn-social btn-success btn-flat"><i class="fa fa-user-plus"></i> Register a new Membership</a>
        </div><!-- /.social-auth-links -->

        <a href="${createLink(controller: 'user', action: 'checkUser')}" class="text-center">Activate my account</a><br>
        <a href="${createLink(controller: 'user', action: 'forgotPassword')}">I forgot my password</a>

    </div><!-- /.login-box-body -->
    <br>
</div><!-- /.login-box -->


<!-- jQuery 2.1.4 -->
<script src="${resource(dir: 'plugins/jQuery', file: 'jQuery-2.1.4.min.js')}"></script>
<!-- Bootstrap 3.3.5 -->
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<!-- iCheck -->
<script src="${resource(dir: 'plugins/iCheck', file: 'icheck.min.js')}"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>
<g:javascript src="noty/jquery.noty.packaged.min.js"/>
<g:javascript src="noty/themes/gmail-like-theme.js"/>
<g:javascript>
  $(document).ready(function() {
    <g:if test="${flash.error}">
        noty({ text: "${flash.error.replaceAll('\n', '<br/>')}", type:  "error", theme: "gmailTheme", layout: "topRight", timeout: 5000});
    </g:if>
    });
</g:javascript>

</body>
</html>
