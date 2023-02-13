<!Doctype html>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <title><g:layoutTitle default="enet"/></title>

<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- Bootstrap 3.3.5 -->
<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" />
<!-- Font Awesome -->
<link rel="stylesheet" href="${resource(dir: 'plugins/font-awesome-4.4.0/css', file: 'font-awesome.min.css')}" />
<!-- Ionicons -->
<link rel="stylesheet" href="${resource(dir: 'plugins/ionicons-2.0.1/css', file: 'ionicons.min.css')}" />

<link rel="stylesheet" href="${resource(dir: 'plugins/select2',file: 'select2.min.css')}">
<!-- Theme style -->
<link rel="stylesheet" href="${resource(dir: 'plugins/dist/css', file: 'AdminLTE.css')}">

<link rel="stylesheet" href="${resource(dir: 'plugins/dist/css/skins', file: 'skin-blue-light.min.css')}">

<link rel="stylesheet" type="text/css" href="${resource(dir: 'plugins/file-upload-previewer/css', file: 'fileinput.min.css')}" media="all"/>

<link rel="stylesheet" href="${resource(dir: 'plugins/bootstrap-wysihtml5',file: 'bootstrap3-wysihtml5.min.css')}">


<!-- REQUIRED JS SCRIPTS -->


<!-- jQuery 2.1.4 -->
<script src="${resource(dir: 'plugins/jQuery', file: 'jQuery-2.1.4.min.js')}"></script>
<!-- Bootstrap 3.3.5 -->
<script src="${resource(dir: 'js', file:'bootstrap.min.js')}"></script>
<!-- SlimScroll 1.3.0 -->
<script src="${resource(dir: 'plugins/slimScroll', file: 'jquery.slimscroll.min.js')}"></script>
<!-- AdminLTE App -->
<script src="${resource(dir: 'plugins/dist/js',file:'app.min.js')}"></script>
<!-- bootstrap typeahead -->
<script src="${resource(dir: 'plugins/boostrap-typeahead', file: 'bootstrap3-typeahead.min.js')}"></script>

<script type="text/javascript">

    $(document).ready(function(){
        var users = [

          <g:each in='${users}' var='u'>
                '${u}',
          </g:each>

        ];
        $(".searchUsers").typeahead({
            source: users
        });

    });
</script>


%{--script for confirmation and error message themes--}%

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



<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body class="hold-transition skin-blue-light sidebar-mini">

<div class="wrapper">

    <!--- Header Navigation pane-->
    <g:render template="/header"/>

    <!--- Sidebar Navigation pane-->
    <g:render template="/sidebar"/>

    <!-- page content-->

    <g:layoutBody/>

    <r:layoutResources />

    <g:render template="/footer"/>

</div>
<!-- end of page wrapper-->

</body>
</html>