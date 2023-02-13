<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>enet | Register</title>
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
<div class="modal" id="modal-terms" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Terms of registration</h4>
            </div>

            <div class="modal-body">

                <p>While registering to <b>enet</b> you agree to not give a falsified information to other users.<br>
                   you must not use an incorrect identity or mislead others about your role in the institution.<br>
                   If you fail to conduct yourself according to the above regulations, you will receive the appropriate punishment from
                   the schools' governing body.
                </p>

            </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Got it</button>
                </div>
        </div>
        <!-- /.modal-content -->
    </div>

</div>
<div class="register-box">
    <div class="register-logo">
        <a href="${createLink(controller: 'login', action: 'auth')}"><b><i>e</i></b>net</a>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg"><b>Register</b> a new membership</p>
        <g:form controller="registration" action="addUser" method="post">
            <div class="form-group has-feedback">
                <input type="text" name="username" class="form-control" placeholder="Username" autofocus="true" required>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>

            <div class="form-group has-feedback">
                <input type="text" name="fullname" class="form-control" placeholder="Full name" required>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="email" name="email" class="form-control" placeholder="Email">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" name="password" id="password" class="form-control password" placeholder="Password" required>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" id="confpass" name="password_again" class="form-control" placeholder="Confirm password" required>
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
            </div>
            <div class="form-group">
                <select class="form-control" id="role" name="authority" required="required">
                    <option value="" selected hidden>Role</option>
                    <option value="ROLE_STUDENT">Student</option>
                    <option value="ROLE_TEACHER">Teacher</option>
                    <option value="ROLE_OFFICE_EMPLOYEE">Registrar or other Office Employee</option>
                </select>
            </div>

            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox" required> I agree to the <a href="#" data-toggle="modal" data-target="#modal-terms">terms</a>
                        </label>
                    </div>
                </div><!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" id="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                </div><!-- /.col -->
            </div>
        </g:form>
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

<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>

%{-- script for conformation of password equals repeated password --}%

<script>
    $(document).ready(function(){

        $('#submit').click(function(event){

            if($('#password').val() != $('#confpass').val()) {

                noty({ text: "Password and Confirm password don't match, Please correct your inputs", type:  "error", theme: "gmailTheme", layout: "topRight", timeout: 5000});

                event.preventDefault();
            }


        });
    });
</script>

</body>
</html>
