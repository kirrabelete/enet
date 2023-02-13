package com.enet

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class ProfileController {

    def userService, postService, customMailService, springSecurityService, storageService

    def index() {

        User user = userService.getCurrentUser()

        List<User> users = userService.getAllUsers()

        List<AdminItem> departments = AdminItem.findAllByDeleted(false)

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<Post> postsByThisUser = postService.AllPostsByThisUser(user)

        List<Post> notifications = postService.getNotifications()

        render(view: 'index', model:[ notifications:   notifications,
                                      user:            user,
                                      users:           users,
                                      departments:     departments,
                                      postsByThisUser: postsByThisUser,
                                      unreadMails:     unreadMails])

    }

    def showProfile(){

        User user = userService.getCurrentUser() //current user

        String name = params.'selectedName'

        if (name == ""){

            flash.error = "The user you've searched doesn't exist. please enter the correct name."
            redirect(controller: 'dashboard', action: 'index')
        }

        else{

            String username = name.substring(name.lastIndexOf("|") + 2)

            User selectedUser = userService.getUserByUsername(username) //user whose profile is to be shown

            List<Mail> unreadMails = customMailService.getUnreadMails()

            if (!selectedUser){

                flash.error = "The user you've searched doesn't exist. please enter the correct name."
                redirect(controller: 'dashboard', action: 'index')
            }

            if(user == selectedUser){

                redirect(action: index())
            }

            List<Post> postsBySelectedUser = postService.postsByThisUser(selectedUser)

            List<User> users = userService.getAllUsers()

            List<Post> notifications = postService.getNotifications()

            List<Storage> sharedDocuments = storageService.getAllPublicDocumentsOfUser(selectedUser)

            render(view: 'showProfile', model:[ notifications:       notifications,
                                                user:                user,
                                                selectedUser:        selectedUser,
                                                users:               users,
                                                unreadMails:         unreadMails,
                                                sharedDocuments:     sharedDocuments,
                                                postsBySelectedUser: postsBySelectedUser])

        }

    }

    def updateProfile(){

        User user = userService.getCurrentUser()
        String department = params.department
        String idNumber = params.idNumber
        String year = params.year
        String stream = params?.stream
        String position = params?.position
        String aboutMe = params?.aboutMe

        try {

            userService.updateProfile(user, department, year, idNumber, stream, position, aboutMe)
            flash.message = "You've successfully updated your profile"
            redirect(action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Error while updating Profile, please check your inputs."
            redirect(action: index())
        }

    }

    def updateUser(){

        User user = userService.getCurrentUser()
        String username = params.username
        String fullname = params.fullname

        try {

            userService.updateUser(user, username, fullname)
            flash.message = "You've successfully updated your profile"
            redirect(action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Error while updating Profile, please check your inputs."
            redirect(action: index())
        }

    }

    def changePassword(){

        User user = userService.getCurrentUser()
        String curPassword = params.curPassword
        String newPassword = params.newPassword
        boolean isPasswordValid = springSecurityService.passwordEncoder.isPasswordValid(user.getPassword(), curPassword, null)

        if(!isPasswordValid){

            flash.error = "Incorrect current password, please check your inputs."
            redirect(action: index())
        }

        else{

            try {

                userService.changePassword(user, newPassword)
                flash.message = "You've successfully changed your password"
                redirect(action: index())
            }

            catch (Exception e){

                e.printStackTrace()
                flash.error = "Error while changing password, please check your inputs."
                redirect(action: index())
            }

        }


    }

    def uploadProfilePic(){

        User user = userService.getCurrentUser()
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request
        CommonsMultipartFile file = (CommonsMultipartFile) multipartHttpServletRequest.getFile('profilePic')
        byte[] profilePic = file.getBytes()


        try {
            userService.uploadProfilePicture(user, profilePic)
            flash.message = "successfully uploaded your profile picture"
            redirect(action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error= "Picture Upload failed."
            redirect(action: index())
        }

    }

    def renderImage(){

        try{

            User user = userService.getCurrentUser()
            response.setContentLength(user.profile.profilePicture.size())
            response.outputStream.write(user.profile.profilePicture)

        }

        catch (Exception e){

            e.printStackTrace()

        }
    }

    def renderImageForSelectedUser(){

        try{

            long id = params.selectedUserId.toLong()
            User user = userService.getUserById(id)
            response.setContentLength(user.profile.profilePicture.size())
            response.outputStream.write(user.profile.profilePicture)

        }

        catch (Exception e){

            e.printStackTrace()

        }
    }

    def createRelation(){

        User follower = userService.getCurrentUser()
        long userId = params.userId.toLong()// the id of the user to be followed
        User user = userService.getUserById(userId) // the user to be followed
        String selectedName = user.fullname + " | " + user.username

        try {

            userService.createRelation(user, follower)
            flash.message = "You have followed ${selectedName}"
            redirect(action: 'showProfile', params: [selectedName: selectedName])
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Operation not Successful."
            redirect(action: 'showProfile', params: [selectedName: selectedName])

        }

    }

    def removeRelation(){

        User follower = userService.getCurrentUser()
        long userId = params.userId.toLong()// the id of the user to be followed
        User user = userService.getUserById(userId) // the user to be followed
        String selectedName = user.fullname + " | " + user.username

        try {

            userService.removeRelation(user, follower)
            flash.message = "You stopped following ${selectedName}"
            redirect(action: 'showProfile', params: [selectedName: selectedName])
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Operation not Successful."
            redirect(action: 'showProfile', params: [selectedName: selectedName])

        }

    }

    def deletePost(long postId){

        Post post = postService.findPostById(postId)

        try {

            postService.deletePost(post)
            flash.message = "you've deleted a post."
            redirect(action: index())

        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong"
            redirect(action: index())
        }
    }

    def myTeachers(){

        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<String> teachersList = userService.getAllTeachers()*.toString()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Post> notifications = postService.getNotifications()

        render(view: 'myTeachers', model:[ notifications:       notifications,
                                           user:                user,
                                           users:               users,
                                           teachersList:        teachersList,
                                           unreadMails:         unreadMails])
    }

    def myStudents(){

        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Post> notifications = postService.getNotifications()
        List<String> studentsList = userService.getAllStudents()*.toString()

        render(view: 'myStudents', model:[ notifications:       notifications,
                                           user:                user,
                                           users:               users,
                                           studentsList:        studentsList,
                                           unreadMails:         unreadMails])
    }

}


