<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="page">

    <title>enet | Groups</title>

</head>
<body>


<div class="wrapper">

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                <i class="fa fa-group"></i> <span>Groups</span>
            </h1>
            <br>
            <g:form method="post" controller="group" action="searchGroupByName">
                <div class="input-group col-md-offset-4  col-md-4">
                    <input required type="text" autocomplete="off" name="groupName" placeholder="Search Groups..." class="form-control searchGroups">
                    <span class="input-group-btn">
                        <button class="btn btn-info btn-flat" type="submit">Search</button>
                    </span>
                </div><!-- /input-group -->
            </g:form>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Your Page Content Here -->

            <div class="box box-default">
                <div class="box-header with-border">
                    <h3 class="box-title">Create Group</h3>
                    <div class="box-tools pull-right">
                        <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                    </div>
                </div><!-- /.box-header -->
                <div class="box-body">
                 <g:form controller="group" action="createGroup">
                     <div class="row">
                         <div class="col-md-6">
                             <div class="form-group has-feedback">
                                 <label>Group Name</label>
                                 <input type="text" required name="groupName" class="form-control" placeholder="Group Name">
                                 <span class="fa fa-group form-control-feedback"></span>
                             </div><!-- /.form-group -->
                             <div class="form-group">
                                 <label>Group Type</label>
                                 <select class="form-control select2" name="groupType" data-placeholder="Select Group Type" style="width: 100%;">
                                     <option value="Study Group">Study Group</option>
                                     <option value="Assignment Group">Assignment Group</option>
                                     <option value="Project Group">Project Group</option>
                                     <option value="Other">Other</option>
                                 </select>
                             </div>
                         </div><!-- /.col -->
                         <div class="col-md-6">
                             <div class="form-group">
                                 <label>Group Members</label>
                                 <g:select from="${users}" optionKey="id"
                                           name="groupMembers" class="form-control select2" multiple="true" data-placeholder="Add Members" style="width: 100%;">
                                 </g:select>

                             </div><!-- /.form-group -->
                             <div class="col-md-4 col-md-offset-4">
                                 <br>
                                 <button type="submit" class="btn btn-lg btn-success btn-block">Create</button>
                             </div><!-- /.col -->
                         </div><!-- /.col -->
                     </div><!-- /.row -->
                 </g:form>
                </div><!-- /.box-body -->
            </div><!-- /.box -->
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-header with-border">
                            <h3 class="box-title">My Groups</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                        <g:if test="${groupsOfCurrentUser}">
                            <div class="row">
                                    <g:each in="${groupsOfCurrentUser}" var="group">
                                        <div class="col-lg-3 col-xs-6">
                                            <!-- small box -->
                                            <div class="small-box bg-aqua">
                                                <div class="inner">
                                                    <h3>${group.members.size()}</h3> <!--number of people-->
                                                    <p>${group.name}</p> <!--group name-->
                                                    <small>${group.type}</small> <!--group type-->
                                                </div>
                                                <div class="icon">
                                                    <i class="fa fa-group"></i>
                                                </div>
                                                <a href="${createLink(controller: 'group', action: 'showGroup', params: [groupId: group.id])}" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                                            </div>
                                        </div><!-- ./col -->
                                    </g:each>
                             %{--
                                <div class="col-lg-3 col-xs-6">
                                    <!-- small box -->
                                    <div class="small-box bg-green">
                                        <div class="inner">
                                            <h3>3</h3> <!--number of people-->
                                            <p>Final Project</p> <!--group name-->
                                            <small>Project Group</small> <!--group type-->
                                        </div>
                                        <div class="icon">
                                            <i class="ion ion-android-people"></i>
                                        </div>
                                        <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div><!-- ./col -->
                                <div class="col-lg-3 col-xs-6">
                                    <!-- small box -->
                                    <div class="small-box bg-yellow">
                                        <div class="inner">
                                            <h3>34</h3> <!--number of people-->
                                            <p>Fleet Management</p> <!--group name-->
                                            <small>Project Group</small> <!--group type-->
                                        </div>
                                        <div class="icon">
                                            <i class="ion ion-ios-people"></i>
                                        </div>
                                        <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div><!-- ./col -->
                                <div class="col-lg-3 col-xs-6">
                                    <!-- small box -->
                                    <div class="small-box bg-red">
                                        <div class="inner">
                                            <h3>72</h3> <!--number of people-->
                                            <p>Computer Engineers</p> <!--group name-->
                                            <small>Other</small> <!--group type-->
                                        </div>
                                        <div class="icon">
                                            <i class="ion ion-ios-people-outline"></i>
                                        </div>
                                        <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                                    </div>
                                </div><!-- ./col -->
--}%
                            </div><!-- /.row -->
                        </g:if>
                        <g:else>
                            <h1 class="text-center"><i class="fa fa-group"></i></h1>
                            <h4 class="text-center">You have not joined any groups</h4>
                        </g:else>
                        </div><!-- ./box-body -->
                        <div class="box-footer">

                        </div><!-- /.box-footer -->
                    </div><!-- /.box -->
                </div><!-- /.col -->
            </div><!-- /.row -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->

</div><!-- ./wrapper -->

<!-- Select2 -->
<script src="${resource(dir: 'plugins/select2', file: 'select2.full.min.js')}"></script>


<script>
    $(function () {
        $(".select2").select2();
    });
</script>

<script type="text/javascript">

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
