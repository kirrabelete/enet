package com.enet

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class GroupController {

    def userService, customMailService, groupService, postService

    def index() {

        User user = userService.getCurrentUser()

        List<EduGroup> allGroups  = groupService.getAllGroups()

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<User> users = userService.getAllUsers()

        List<EduGroup> groupsOfCurrentUser  = groupService.groupsOfCurrentUser()

        List<Post> notifications = postService.getNotifications()

        render(view: 'index', model:[ notifications:       notifications,
                                      user:                user,
                                      users:               users,
                                      unreadMails:         unreadMails,
                                      allGroups:           allGroups,
                                      groupsOfCurrentUser: groupsOfCurrentUser])

    }

    def searchGroupByName(){

        String groupName = params.groupName

        EduGroup group = groupService.getGroupByName(groupName)

        if(!group){

            flash.error = "The group you searched for does not exist"
            redirect(action: index())
        }
        else{
            redirect(action: 'showGroup', params: [groupId: group.id])
        }
    }

    def showGroup(long groupId){

        User user = userService.getCurrentUser()

        List<EduGroup> allGroups  = groupService.getAllGroups()

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<User> users = userService.getAllUsers()

        EduGroup selectedGroup = groupService.getGroupById(groupId)

        List<Post> notifications = postService.getNotifications()

        render(view: 'showGroup', model:[ notifications:       notifications,
                                          user:                user,
                                          users:               users,
                                          unreadMails:         unreadMails,
                                          allGroups:           allGroups,
                                          selectedGroup:       selectedGroup])
    }

    def createGroup(){

        User creator = userService.getCurrentUser()

        String groupName = params.groupName

        String groupType = params.groupType

        List<User> groupMembers = User.getAll(params.list('groupMembers'))

        try {

            groupService.createGroup(groupName, groupType, creator, groupMembers)
            flash.message = "You have successfully created a group ${groupName}"
            redirect(controller: 'group', action: 'index')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong, Please make sure the group name is unique and try again."
            redirect(controller: 'group', action: 'index')
        }
    }

    def updateGroupMembers(long groupId){

        List<User> groupMembers = User.getAll(params.list('groupMembers'))

        try {

            groupService.updateGroupMembers(groupId, groupMembers)
            flash.message = "You have successfully Update group members"
            redirect(controller: 'group', action: 'showGroup', params: [groupId: groupId])
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong, Please make sure the group member nemes are correct."
            redirect(controller: 'group', action: 'showGroup', params: [groupId: groupId])
        }

    }

    def deleteGroup(long groupId){

        try {

            groupService.deleteGroup(groupId)
            flash.message = "You have deleted a group"
            redirect(controller: 'group', action: 'index', params: [groupId: groupId])
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong. group can't be deleted"
            redirect(controller: 'group', action: 'index')

        }
    }

    def joinGroup(long groupId){

        try {

            groupService.joinGroup(groupId)
            flash.message = "You have joined a new group"
            redirect(controller: 'group', action: 'showGroup', params: [groupId: groupId])
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong. Operation not successful."
            redirect(controller: 'group', action: 'index')

        }

    }

    def leaveGroup(long groupId){

        try {

            groupService.leaveGroup(groupId)
            flash.message = "You have left a group"
            redirect(controller: 'group', action: 'index')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong. Operation not successful."
            redirect(controller: 'group', action: 'showGroup', params: [groupId: groupId])

        }

    }

    def createGroupPost(long groupId){

        User user = userService.getCurrentUser()
        String content = params.'content'
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request
        CommonsMultipartFile file = (CommonsMultipartFile) multipartHttpServletRequest.getFile('attachment')

        if(file.size > (15 * 1024 * 1024)){

            flash.error = "Your post couldn't be added, Because The attached file is too large"
            redirect(controller: 'dashboard', action: 'index')
        }

        else{

            byte[] attachment = file.getBytes()
            String attachedFileName = file.getOriginalFilename()

            try {

                groupService.createGroupPost(groupId, user, content, attachment,attachedFileName)
                flash.message = "You have Successfully added a new post."
                redirect(controller: 'group', action: 'showGroupPosts', params: [groupId: groupId])
            }
            catch (Exception e){

                log.error(e.stackTrace)
                flash.error = "Your post couldn't be added please check your content" +
                              "or the size of your attachment."
                redirect(controller: 'group', action: 'showGroup', params: [groupId: groupId])
            }
        }
    }

    def addGroupComment(long groupId, long postId){

        String comment = params.'comment'

        Post post = postService.findPostById(postId)

        try {

            groupService.AddGroupComment(groupId, post, comment)

            flash.message = "Your comment is added"

            redirect(action: showGroupPosts(groupId))
        }

        catch(Exception e){

            e.printStackTrace()

            flash.error = "Oops something went wrong!"

            redirect(action: index())
        }

    }

    def showGroupPosts(long groupId){

        User user = userService.getCurrentUser()

        EduGroup selectedGroup = groupService.getGroupById(groupId)

        if (!selectedGroup.members.contains(user))
        {

            flash.error = "You are not authorized to view the pasts."
            redirect(controller: 'group', action: 'index')

        }

        List<Post> groupPosts = groupService.getGroupPosts(groupId)

        List<EduGroup> allGroups  = groupService.getAllGroups()

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<User> users = userService.getAllUsers()

        List<Post> notifications = postService.getNotifications()

        render(view: 'groupPost', model:[ notifications:       notifications,
                                          user:                user,
                                          users:               users,
                                          unreadMails:         unreadMails,
                                          allGroups:           allGroups,
                                          selectedGroup:       selectedGroup,
                                          groupPosts:          groupPosts])

    }

}



