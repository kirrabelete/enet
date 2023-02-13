<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Storage</title>

</head>
<body>
<div class="wrapper">

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <span><i class="fa fa-database"></i> Storage</span>
            </h1>

        </section>
        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-md-3">

                    <!-- Profile Image -->
                    <div class="box box-primary">
                        <div class="box-body box-profile">
                            <h3 class="profile-username text-center">${user.fullname}</h3>
                        <!-- Role -->
                            <sec:ifAllGranted roles="ROLE_STUDENT">
                                <p class="text-muted text-center">Studnet</p>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <p class="text-muted text-center">Admin</p>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_TEACHER">
                                <p class="text-muted text-center">Teacher</p>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_OFFICE_EMPLOYEE">
                                <p class="text-muted text-center">Office Employee</p>
                            </sec:ifAllGranted>

                            <ul class="list-group list-group-unbordered">
                            <li class="list-group-item">
                                Public Documents <a class="pull-right">${allPublicDocuments.size()}</a>
                            </li>
                            <li class="list-group-item">
                                Private Documents <a class="pull-right">${allPrivateDocuments.size()}</a>
                            </li>
                            <li class="list-group-item">
                                Free Space <a class="pull-right">
                                <g:if test="${freeSpace <= 0}">
                                    0 MB
                                </g:if>
                                <g:if test="${freeSpace > 0}">
                                    ${freeSpace.round(1)} MB
                                </g:if>
                                </a>
                            </li>
                        </ul>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->

                        <div class="box box-danger">
                            <div class="box-header with-border">
                                <h3 class="box-title text-center">
                                    <i class="fa fa-bar-chart margin-r-5"></i>  Data Usage Chart (%)
                                </h3>
                            </div><!-- /.box-header -->
                            <div class="box-body">
                        <canvas id="pieChart" style="height:250px"></canvas>

                    </div><!-- /.box-body -->
                        </div><!-- /.box -->
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#activity" data-toggle="tab">Public Documents</a></li>
                            <li><a href="#settings" data-toggle="tab">Private Documents</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="active tab-pane" id="activity">
                                <g:form controller="storage" action="uploadPublicFiles" method="post" enctype="multipart/form-data" class="form-horizontal">
                                    <div class="form-group">
                                        <label for="file-public" class="col-sm-2 control-label">Upload Files</label>
                                        <div class="col-sm-9">
                                            <input id="file-public"  class="file file-upload" name="files" type="file" multiple data-min-file-count="1">
                                        </div>
                                    </div>
                                    <br>
                                </g:form>
                            </div><!-- /.tab-pane -->
                            <div class="tab-pane" id="settings">
                            <g:form controller="storage" action="uploadPrivateFiles" method="post" enctype="multipart/form-data" class="form-horizontal">
                                <div class="form-group">
                                    <label for="file-private" class="col-sm-2 control-label">Upload Files</label>
                                    <div class="col-sm-9">
                                        <input id="file-private"  class="file file-upload" name="files" type="file" multiple data-min-file-count="1">
                                    </div>
                                </div>
                                <br>
                            </g:form>
                            </div><!-- /.tab-pane -->
                        </div><!-- /.tab-content -->
                    </div><!-- /.nav-tabs-custom -->
                </div><!-- /.col -->
                <div class="col-md-9">
                    <div class="box box-primary">
                    <div class="box-header">
                        <h3 class="box-title"> My Documents</h3>
                    </div><!-- /.box-header -->
                    <div class="box-body table-responsive">
                        <table id="example1" class="table table-bordered table-hover table-striped">
                            <thead>
                            <tr>
                                <th>File Name</th>
                                <th>Size</th>
                                <th>Type</th>
                                <th>Date Uploaded</th>
                                <th>Action</th>
                                <th>Privacy</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${allDocuments}" var="file">
                                <tr>
                                    <td>
                                        <a href="${createLink(controller: 'storage', action: 'downloadFile', params: [fileId: file?.id])}">${file.fileName}</a>
                                    </td>
                                    <td>${(file.fileSize / 1048576).round(2)} MB</td>
                                    <g:if test="${file.isPublic}">
                                        <td>Public</td>
                                    </g:if>
                                    <g:else>
                                        <td>Private</td>
                                    </g:else>
                                    <td>${new java.text.DateFormatSymbols().months[file.dateCreated.month]} ${file.dateCreated.getDate()}, ${file.dateCreated.getYear() + 1900}</td>
                                    <td>
                                            <button class="btn btn-danger btn-sm" data-target="#delete-file-${file.id}" data-toggle="modal">
                                                <i class="fa fa-trash"></i></button>
                                            <div class="modal" id="delete-file-${file.id}" role="dialog">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">Delete File</h4>
                                                        </div>

                                                        <div class="modal-body">
                                                            Are you sure you want to delete this file permanently? Once you do this you won't be able to undo it.
                                                        </div>
                                                        <g:form class="form-horizontal" method="post" controller="storage" action="deleteFile" params="[fileId: file.id]">
                                                            <div class="modal-footer">
                                                                <button type="submit" class="btn btn-danger ">Delete</button>
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                            </div>
                                                        </g:form>
                                                    </div>
                                                    <!-- /.modal-content -->
                                                </div>
                                            </div>
                                    </td>
                                    <g:if test="${!file.isPublic}">
                                    <td>
                                        <a href="${createLink(controller: 'storage', action: 'makePublic', params: [fileId: file.id])}" class="btn btn-primary btn-xs"
                                           title="make public"><i class="fa fa-file"></i> Make Public</a>
                                    </td>
                                    </g:if>
                                    <g:else>
                                        <td>
                                            <a href="${createLink(controller: 'storage', action: 'makePrivate', params: [fileId: file.id])}" class="btn btn-default btn-xs"
                                               title="make private"><i class="fa fa-file-zip-o"></i> Make Private</a>
                                        </td>
                                    </g:else>
                                </tr>
                            </g:each>
                          </tbody>
                        </table>
                    </div>
                </div>
                </div>
            </div><!-- /.row -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<!-- REQUIRED JS for this page -->
<!-- For file upload purposes -->
<script src="${resource(dir: 'plugins/file-upload-previewer/js', file: 'fileinput.min.js')}" type="text/javascript"></script>
<!-- ChartJS 1.0.1 -->
<script src="${resource(dir: 'plugins/chartjs/', file: 'Chart.min.js')}" type="text/javascript"></script>

<script type="text/javascript">
    $(".file-upload").fileinput({
        'allowedFileExtensions' : ['jpg', 'png','gif', 'docx', 'doc', 'pdf', 'html','mp4','flv','mp4','avi','zip','rar','pptx','ppt','cpp','c','txt','java','xml','py','css','js','file','jar'],
    });
</script>

<!-- page script -->
<script>
    $(function () {
        /* ChartJS
         * -------
         * Here we will create a few charts using ChartJS
         */

        //-------------
        //- PIE CHART -
        //-------------
        // Get context with jQuery - using jQuery's .get() method.
        var pieChartCanvas = $("#pieChart").get(0).getContext("2d");
        var pieChart = new Chart(pieChartCanvas);
        var freeSpace = 0;
        if(${freeSpace.round(1) > 0}){
            freeSpace = ${freeSpace.round(1)};
        }


            var PieData = [
            {
                value: ${privateFileSize.round(1)},
                color: "#f56954",
                highlight: "#f56954",
                label: "Private Documents %"
            },
            {
                value: ${publicFileSize.round(1)},
                color: "#3c8dbc",
                highlight: "#3c8dbc",
                label: "Public Documents %"
            },
            {
                value: freeSpace,
                color: "#00c0ef",
                highlight: "#00c0ef",
                label: "Free Space %"
            }
        ];
        var pieOptions = {
            //Boolean - Whether we should show a stroke on each segment
            segmentShowStroke: true,
            //String - The colour of each segment stroke
            segmentStrokeColor: "#fff",
            //Number - The width of each segment stroke
            segmentStrokeWidth: 2,
            //Number - The percentage of the chart that we cut out of the middle
            percentageInnerCutout: 50, // This is 0 for Pie charts
            //Number - Amount of animation steps
            animationSteps: 100,
            //String - Animation easing effect
            animationEasing: "easeOutBounce",
            //Boolean - Whether we animate the rotation of the Doughnut
            animateRotate: true,
            //Boolean - Whether we animate scaling the Doughnut from the centre
            animateScale: false,
            //Boolean - whether to make the chart responsive to window resizing
            responsive: true,
            // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
            maintainAspectRatio: true
        };
        //Create pie or douhnut chart
        // You can switch between pie and douhnut using the method below.
        pieChart.Doughnut(PieData, pieOptions);

    });
</script>

</body>
</html>





