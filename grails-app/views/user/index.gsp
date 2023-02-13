<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>enet | Activate Account</title>
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
<body class="hold-transition register-page">
<div class="register-box">
    <div class="register-logo">
        <a href="${createLink(controller: 'login', action: 'auth')}"><b><i>e</i></b>net</a>
    </div>

<div class="register-box-body">
    <p class="login-box-msg">a confirmation code has been sent to your email address <b>${user.email}</b>. please check your email and input the code you received below.</p>
    <g:form controller="user" action="activateAccount" method="post" params="[userId: user.id]">
        <div class="form-group has-feedback">
            <input type="text" name="confirmationCode" autofocus="true" class="form-control password" placeholder="Enter your code here." required>
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="row">
            <div class="col-sm-12" >
                <button type="submit" id="submit" class="btn btn-primary btn-block btn-flat">Submit</button>
            </div><!-- /.col -->
        </div>
    </g:form>
    <g:form action="resendConfirmationCode" controller="registration" params="[userId: user.id]">
        <div class="row">
            <br><p class="text-center">Didn't receive your code?<button type="submit" class="btn-link">resend code</button>
        </p>
        </div>
    </g:form>
 </div>
</div><!-- /.form-box -->
</div><!-- /.register-box -->

<!-- jQuery 2.1.4 -->
<script src="${resource(dir: 'plugins/jQuery', file: 'jQuery-2.1.4.min.js')}"></script>
<!-- Bootstrap 3.3.5 -->
<script src="${resource(dir: 'js', file: 'bootstrap.min.js')}"></script>
<!-- iCheck -->
<script src="${resource(dir: 'plugins/iCheck', file: 'icheck.min.js')}"></script>

<g:javascript src="noty/jquery.noty.packaged.min.js"/>
<g:javascript src="noty/themes/gmail-like-theme.js"/>
<g:javascript>
        $(document).ready(function() {
            <g:if test="${flash.message}">
    noty({ text: "${flash.message.replaceAll('\n', '<br/>')}", type:  "success", theme: "gmailTheme", layout: "topRight", timeout: 5000});
</g:if>
    <g:if test="${flash.error}">
        noty({ text: "${flash.error.replaceAll('\n', '<br/>')}", type:  "error", theme: "gmailTheme", layout: "topRight", timeout: 5000});
    </g:if>
    });
</g:javascript>


</body>
</html>
