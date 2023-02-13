<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | My Teachers</title>

</head>
<body>


<div class="wrapper">

    <div class="modal" id="modal-search" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Search Teachers</h4>
                </div>
                <div class="modal-body">
                    <form action="${createLink(controller: 'profile', action: 'showProfile')}">
                        <div class="input-group col-md-offset-2  col-md-8">
                            <input type="text" name="selectedName" autocomplete="off" placeholder="Search Teachers..." class="form-control searchTeachers">
                            <span class="input-group-btn">
                                <button class="btn btn-info btn-flat" type="submit">Search</button>
                            </span>
                        </div><!-- /input-group -->
                    </form>
                </div>
                <div class="modal-footer">
                    <div class="pull-right">
                        <button class="btn btn-default hidden" data-dismiss="modal">Cancel</button>
                    </div>
                </div><!-- /.modal-footer -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <i class="fa fa-user"></i> <span>My Teachers</span>
            </h1>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

       <div class="row">
        <div class="col-md-12">
            <!-- TEACHERS LIST -->
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Followed Teachers</h3>
                    <g:if test="${user.following}">
                        <div class="box-tools pull-right">
                            <span class="label label-danger">${user.following.size()} Teachers</span>
                        </div>
                    </g:if>
                </div><!-- /.box-header -->
                <div class="box-body no-padding">
                   <g:if test="${user?.following}">
                    <ul class="users-list clearfix">
                    <g:each in="${user?.following}" var="member">
                        <li>
                            <g:if test="${member.profile?.profilePicture}">
                                <img src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: member.id])}" alt="User Image">
                            </g:if>
                            <g:else>
                                <img src="${resource(dir: 'images', file: 'avatar.png')}" alt="User profile picture">
                            </g:else>
                            <a class="users-list-name" href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: member] )}">${member.fullname}</a>
                                <span class="users-list-date">Teacher</span>
                        </li>
                    </g:each>
                    </ul><!-- /.users-list -->
                   </g:if>
                <g:else>
                    <h1 class="text-center"><i class="fa fa-user-secret"></i></h1>
                    <h4 class="text-center">You are not following any teachers Yet</h4>
                </g:else>
                </div><!-- /.box-body -->
                <div class="box-footer text-center">
                    <a href="#" data-target="#modal-search" data-toggle="modal" class="uppercase">Search All Teachers</a>
                </div><!-- /.box-footer -->
            </div><!--/.box -->

        </div><!-- /.col -->
    </div><!-- /.row -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->
<script type="text/javascript">

    $(document).ready(function(){
        var teachers = [

            <g:each in='${teachersList}' var='u'>
            '${u}',
            </g:each>

        ];
        $(".searchTeachers").typeahead({
            source: teachers
        });

    });
</script>

</body>
</html>
