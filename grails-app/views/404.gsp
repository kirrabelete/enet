<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>enet | 404 Error</title>
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
<body class="hold-transition skin-blue layout-boxed">
<div class="wrapper">


        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <b>e</b>net : 404 Error Page
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="error-page">
                <h2 class="headline text-yellow"> 404</h2>
                <div class="error-content">
                    <h3><i class="fa fa-warning text-yellow"></i> Oops! Page not found.</h3>
                    <p>
                        We could not find the page you were looking for.<br>
                        The page is either removed or it didn't exist in the place.
                        Meanwhile, you may  <a href="${createLink(controller: 'dashboard')}"><b>return to dashboard</b></a>
                    </p>
                </div>
            </div><!-- /.error-page -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->


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
