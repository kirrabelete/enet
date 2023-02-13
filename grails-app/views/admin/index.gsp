<%@ page import="com.enet.Post; com.enet.Mail" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Admin</title>

</head>
<body>
<div class="wrapper">



    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <div class="modal" id="modal-add-department" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                        <h4 class="modal-title">Add New Department</h4>
                    </div>

                    <div class="modal-body">
                        <g:form class="form-horizontal" method="post" controller="admin" action="addNewDepartment">
                            <div class="form-group">
                                <label for="id" class="col-sm-2 control-label">Name</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="id" name="department" placeholder="Department Name...">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <br>
                                <button type="submit" class="btn btn-primary">Add</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            </div>
                        </g:form>
                    </div>
                    <!-- /.modal-content -->
                </div>
            </div>
        </div>

        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <span>Admin</span>
            </h1>

        </section>
        <!-- Main content -->
        <section class="content">

            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#activity" data-toggle="tab">Manage Users</a></li>
                    <li><a href="#settings" data-toggle="tab">Departments</a></li>
                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                        <div class="box">
                            <div class="box-header">
                                <h4 class="box-title">Users</h4>
                            </div><!-- /.box-header -->
                            <div class="box-body table-responsive">
                                <table id="userTable" class="table table-bordered table-striped">
                                    <thead>
                                    <tr>
                                        <th>Full Name</th>
                                        <th>Username</th>
                                        <th>email</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${users}" var="user">
                                        <tr>
                                            <td>${user.fullname}</td>
                                            <td>${user.username}</td>
                                            <td>${user.email}</td>
                                            <td>
                                                <g:if test="${!user.accountLocked}">
                                                    <button class="btn btn-danger btn-xs" data-target="#block-user-${user.id}" data-toggle="modal">
                                                        <i class="fa fa-lock"></i> Lock Account</button>
                                                    <div class="modal" id="block-user-${user.id}" role="dialog">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                                    <h4 class="modal-title">Lock Account</h4>
                                                                </div>

                                                                <div class="modal-body">

                                                                    <p>Are you sure you want to lock ${user.fullname}'s account. if you do this he/she won't be able to access his/her account</p>

                                                                </div>
                                                                <g:form class="form-horizontal" method="post" controller="admin" action="lockUser" params="[userId: user.id]">

                                                                    <div class="modal-footer">
                                                                        <button type="submit" class="btn btn-primary ">Yes</button>
                                                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                    </div>
                                                                </g:form>
                                                            </div>
                                                            <!-- /.modal-content -->
                                                        </div>

                                                    </div>
                                                </g:if>
                                                <g:if test="${user.accountLocked}">
                                                    <a href="${createLink(controller: 'admin', action: 'unlockUser', params: [userId: user.id])}" class="btn btn-success btn-xs"
                                                       title="unblock"><i class="fa fa-unlock"></i> Unlock Account</a>
                                                </g:if>
                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->

                    </div><!-- /.tab-pane -->
                    <div class="tab-pane" id="settings">
                        <div class="box">
                            <div class="box-header">
                                <h3 class="box-title">Departments</h3>
                                <div class="box-tools pull-right">
                                    <button class="btn btn-default" data-toggle="modal" data-target="#modal-add-department"><i class="fa fa-plus"></i> Add New Department</button>
                                </div>
                            </div><!-- /.box-header -->
                            <div class="box-body no-padding table-responsive">
                                <table class="table table-hover">
                                    <tr>
                                        <th>Name</th>
                                        <th>Actions</th>
                                        <th></th>
                                    </tr>
                                    <g:each in="${departments}" var="d">
                                        <tr>
                                            <td>${d.department}</td>
                                            <td>
                                                <button class="btn btn-sm btn-info" data-toggle="modal" data-target="#modal-edit-department-${d.id}"><i class="fa fa-edit"></i> Update Department</button
                                            </td>
                                            <td>
                                                <button class="btn btn-sm btn-danger" data-toggle="modal" data-target="#modal-delete-department-${d.id}"><i class="fa fa-trash"></i>  Delete Department</button>
                                            </td>
                                            <div class="modal" id="modal-edit-department-${d.id}" role="dialog">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">Edit Department</h4>
                                                        </div>

                                                        <div class="modal-body">
                                                            <g:form class="form-horizontal" method="post" controller="admin" action="editDepartment" params="[itemId: d.id]">
                                                                <div class="form-group">
                                                                    <label for="id-no" class="col-sm-2 control-label">Name</label>
                                                                    <div class="col-sm-10">
                                                                        <input type="text" class="form-control" id="id-no" name="department" value="${d.department}">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <br>
                                                                    <button type="submit" class="btn btn-primary">Update</button>
                                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                                                </div>
                                                            </g:form>
                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="modal" id="modal-delete-department-${d.id}" role="dialog">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                            <h4 class="modal-title">Delete Department</h4>
                                                        </div>

                                                        <div class="modal-body">

                                                            <p>Are you sure you want to delete department ${d.department}.</p>

                                                        </div>
                                                        <g:form class="form-horizontal" method="post" controller="admin" action="deleteDepartment" params="[itemId: d.id]">

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
                                </table>
                            </div><!-- /.box-body -->
                        </div><!-- /.box -->


                    </div><!-- /.tab-pane -->
                </div><!-- /.tab-content -->
            </div><!-- /.nav-tabs-custom -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<!-- REQUIRED JS for this page -->

<!-- DataTables -->

<script src="${resource(dir: 'plugins/datatables',file:'jquery.dataTables.min.js')}"></script>
<script src="${resource(dir: 'plugins/datatables',file:'dataTables.bootstrap.min.js')}"></script>

<script>
    $(function () {
        $("#userTable").DataTable();
    });
</script>

</body>
</html>
