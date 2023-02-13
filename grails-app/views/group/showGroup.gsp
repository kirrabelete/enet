<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Groups</title>

</head>
<body>


<div class="wrapper">

    <div class="modal" id="modal-group-post" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Create New Group Post</h4>
                </div>
                <g:form method="post" controller="group" action="createGroupPost" params="[groupId: selectedGroup.id]" enctype="multipart/form-data">
                    <div class="modal-body">
                        <!-- Title input-->
                        <div class="form-group">
                            <textarea id="compose-textarea" name="content" placeholder="Write Your post here..."
                                      class="form-control col-md-8" style="height: 150px" required>
                            </textarea>
                        </div>
                        <div class="form-group">
                            <div class="btn btn-default btn-file">
                                <i class="fa fa-paperclip"></i> Attachment
                                <input type="file" name="attachment">
                            </div>
                            <p class="help-block">Max. Size 15MB</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="pull-right">
                            <button type="submit" class="btn btn-primary">Post</button>
                            <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div><!-- /.modal-footer -->
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal" id="modal-update-members" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Update Group Members</h4>
                </div>
                <g:form method="post" controller="group" action="updateGroupMembers" params="[groupId: selectedGroup.id]">
                    <div class="modal-body">
                        <!-- Title input-->
                        <div class="form-group">
                            <g:select from="${users}" optionKey="id" value="${selectedGroup.members}"
                                      name="groupMembers" class="form-control select2" multiple="true" data-placeholder="Add Members" style="width: 100%;">
                            </g:select>

                        </div><!-- /.form-group -->
                    </div>
                    <div class="modal-footer">
                        <div class="pull-right">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div><!-- /.modal-footer -->
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <div class="modal" id="modal-delete-group" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Delete Group Permanently</h4>
                </div>

                <div class="modal-body">

                    <p>Are you sure you want to delete this group permanently? if you do this, you won't be able to access your group conversations anymore. </p>

                </div>
                <g:form class="form-horizontal" method="post" controller="group" action="deleteGroup" params="[groupId: selectedGroup.id]">
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger ">Delete</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>

    </div>

    <div class="modal" id="modal-leave-group" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title">Leave Group</h4>
                </div>

                <div class="modal-body">

                    <p>Are you sure you want to leave this group.</p>

                </div>
                <g:form class="form-horizontal" method="post" controller="group" action="leaveGroup" params="[groupId: selectedGroup.id]">
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger ">Leave</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    </div>
                </g:form>
            </div>
            <!-- /.modal-content -->
        </div>

    </div>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <i class="fa fa-group"></i> <span>Show Group</span>
            </h1>
            <br>
         <g:form method="post" controller="group" action="searchGroupByName">
             <div class="input-group col-md-offset-4  col-md-4">
                 <input type="text" name="groupName" autocomplete="off" placeholder="Search Groups ..." class="form-control searchGroups">
                 <span class="input-group-btn">
                     <button class="btn btn-info btn-flat" type="submit">Search</button>
                 </span>
             </div><!-- /input-group -->
         </g:form>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

            <div class="box box-apua">
                <div class="box-header with-border">
                    <h3 class="box-title">${selectedGroup.name}
                    <g:if test="${selectedGroup.type != "Other"}">
                        <span class="small">${selectedGroup.type}</span>
                    </g:if>
                    </h3>
                  <g:if test="${selectedGroup.members.contains(user)}">
                    <div class="box-tools pull-right">
                        <button class="btn btn-default" data-toggle="modal" data-target="#modal-group-post"><i class="fa fa-edit"></i> Write Group Post</button>
                    </div>
                  </g:if>
                </div><!-- /.box-header -->
                <div class="box-body">
                        <div class="row">
                            <div class="col-md-4">
                                    <div class="box box-widget widget-user-2">
                                        <!-- Add the bg color to the header using any of the bg-* classes -->
                                        <div class="widget-user-header">
                                            <div class="widget-user-image">
                                            <g:if test="${selectedGroup.creator.profile?.profilePicture}">
                                                <img class="img-circle" src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: selectedGroup.creator.id])}" alt="User Avatar">
                                            </g:if>
                                            <g:else>
                                                <img class="img-circle"  src="${resource(dir: 'images', file: 'avatar.png')}" alt="User profile picture">
                                            </g:else>
                                            </div><!-- /.widget-user-image -->
                                            <h3 class="widget-user-username">${selectedGroup.creator.fullname}</h3>
                                       <g:if test="${selectedGroup.creator.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                            <h5 class="widget-user-desc">Student</h5>
                                       </g:if>
                                        <g:if test="${selectedGroup.creator.getAuthorities().authority.contains("ROLE_TEACHER")}">
                                            <h5 class="widget-user-desc">Teacher</h5>
                                        </g:if>
                                        <g:if test="${selectedGroup.creator.getAuthorities().authority.contains("ROLE_OFFICE_EMPLOYEE")}">
                                            <h5 class="widget-user-desc">Office Employee</h5>
                                        </g:if>
                                        </div>
                                        <div class="box-footer no-padding">
                                            <ul class="nav">
                                                <li><a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: selectedGroup.creator] )}">Group Creator</a></li>
                                            </ul>
                                        </div>
                                    </div><!-- /.widget-user -->
                        <g:if test="${user == selectedGroup.creator}">
                            <button class="btn  btn-info btn-social col-md-12" data-toggle="modal" data-target="#modal-update-members"><i class="fa fa-group"></i> Manage Group Members</button>
                            <g:form controller="group" action="showGroupPosts" params="[groupId: selectedGroup.id]">
                                <button type="submit" class="btn  btn-default btn-social col-md-12"><i class="fa fa-feed"></i> View Group Posts</button>
                            </g:form>
                            <button class="btn  btn-danger btn-social col-md-12" data-toggle="modal" data-target="#modal-delete-group"><i class="fa fa-trash"></i> Delete This Group</button>
                        </g:if>
                        <g:if test="${selectedGroup.members.contains(user) && user != selectedGroup.creator}">
                            <g:form controller="group" action="showGroupPosts" params="[groupId: selectedGroup.id]">
                                <button type="submit" class="btn  btn-info btn-social col-md-12"><i class="fa fa-feed"></i> View Group Posts</button>
                            </g:form>
                            <button class="btn  btn-danger btn-social col-md-12" data-toggle="modal" data-target="#modal-leave-group"><i class="fa fa-user-times"></i> Leave This Group</button>
                        </g:if>
                        <g:if test="${!selectedGroup.members.contains(user)}">
                            <a href="${createLink(controller: 'group', action: 'joinGroup', params: [groupId: selectedGroup.id])}" class="btn  btn-success btn-social col-md-12"><i class="fa fa-user-plus"></i> Join This Group</a>
                        </g:if>

                        </div><!-- /.col -->
                            <div class="col-md-8">
                                <div class="box box-default">
                                    <div class="box-header with-border">
                                        <h3 class="box-title">Group Members</h3>
                                        <div class="box-tools pull-right">
                                            <span class="label label-primary">${selectedGroup.members.size()}</span>
                                        </div>
                                    </div><!-- /.box-header -->
                                    <div class="box-body no-padding">
                                        <ul class="users-list clearfix">
                                            <g:each in="${selectedGroup.members}" var="member">
                                            <li>
                                                <g:if test="${member.profile?.profilePicture}">
                                                    <img src="${createLink(controller: 'profile', action: 'renderImageForSelectedUser', params: [selectedUserId: member.id])}" alt="User Image">
                                                </g:if>
                                                <g:else>
                                                    <img  src="${resource(dir: 'images', file: 'avatar.png')}" alt="User profile picture">
                                                </g:else>
                                                <a href="${createLink(controller: 'profile', action: 'showProfile', params:[selectedName: member] )}">${member.fullname}</a>
                                                <g:if test="${member.getAuthorities().authority.contains("ROLE_STUDENT")}">
                                                <span class="users-list-date">Student</span>
                                                </g:if>
                                                <g:if test="${member.getAuthorities().authority.contains("ROLE_TEACHER")}">
                                                    <span class="users-list-date">Teacher</span>
                                                </g:if>
                                                <g:if test="${member.getAuthorities().authority.contains("ROLE_OFFICE_EMPLOYEE")}">
                                                    <span class="users-list-date">Office Employee</span>
                                                </g:if>
                                            </li>
                                            </g:each>
                                        </ul><!-- /.users-list -->
                                    </div><!-- /.box-body -->
                                </div><!--/.box -->
                        </div><!-- /.row -->
                </div><!-- /.box-body -->
            </div><!-- /.box -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->

<!-- Select2 -->
<script src="${resource(dir: 'plugins/select2', file: 'select2.full.min.js')}"></script>

<!-- Bootstrap WYSIHTML5 -->
<script src="${resource(dir: 'plugins/bootstrap-wysihtml5', file: 'bootstrap3-wysihtml5.all.min.js')}"></script>

<!-- Page Script -->
<script>
    $(function () {
        //Add text editor
        $("#compose-textarea").wysihtml5();

        $(".select2").select2();
    });

    $(document).ready(function(){
        var allGroups = [

            <g:each in='${allGroups}' var='group'>
            '${group.name}',
            </g:each>

        ];
        $(".searchGroups").typeahead({
            source: allGroups
        });

    });
</script>


</body>
</html>
