package com.enet

import grails.converters.JSON


class ApiController {

    def userService, groupService, postService, customMailService, springSecurityService

    def profile() {

        User user = userService.getCurrentUser()
        def profile = [profile: user.profile]
        try {
            render profile as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def group() {

        List<EduGroup> groupsOfCurrentUser = groupService.groupsOfCurrentUser()
        try {
            render groupsOfCurrentUser as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def teachers() {

        List<User> teachers = userService.getAllUsersFollwedByCurrentUser()

        try {
            render teachers as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def students() {

        List<User> students = userService.getAllUsersFollwingCurrentUser()

        try {
            render students as JSON
        }

        catch (Exception e) {
            e.printStackTrace()
        }
    }

    def timeline() {

        List<Post> postsForCurrentUser = postService.postsForCurrentUser()
        def post = [post: postsForCurrentUser]
        try {

            render post as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def notifications() {

        List<Post> notifications = postService.getNotifications()
        def post = [post: notifications]
        try {

            render post as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def activity() {

        User user = userService.getCurrentUser()
        List<Post> postsByThisUser = postService.AllPostsByThisUser(user)

        try {
            render postsByThisUser as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def inbox() {

        List<Mail> inbox = customMailService.getMailsForCurrentUser()
        try {
            render inbox as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }
    }

    def sent() {

        List<Mail> sent = customMailService.getMailsSentByCurrentUser()
        try {
            render sent as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }
    }

    def userDetail() {

        def jsonData = request.JSON
        long userId = jsonData.userId.toLong()
        User user = userService.getUserById(userId)
        Profile profile = user.profile
        def userDetail = [userDetail: profile]
        try {
            render userDetail as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }
    }

    def userList() {

        List<String> listOfNames = userService.getAllUsers()*.toString()
        try {
            render listOfNames as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }
    }

    def allTeachersList() {

        List<String> teachersList = userService.getAllTeachers()*.toString()
        try {
            render teachersList as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }

    }

    def allStudentsList() {

        List<String> studentsList = userService.getAllStudents()*.toString()
        try {
            render studentsList as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }

    }

    def searchUser() {

        def name = request.JSON.name
        String username = name.substring(name.lastIndexOf("|") + 2)
        User selectedUser = userService.getUserByUsername(username) //user whose profile is to be shown
        def profile = [profile: selectedUser.profile]
        try {
            render profile as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }


    }

    def groupsList() {

        List<String> groupNames = groupService.allGroups*.name
        try {
            render groupNames as JSON
        }
        catch (Exception e) {
            e.printStackTrace()
        }

    }

    def searchGroup() {

        String name = request.JSON.name
        EduGroup group = groupService.getGroupByName(name)
        try {
            render group as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }

    }

    def register() {

        def jsonData = request.JSON
        String username = jsonData.username
        String fullname = jsonData.fullname
        String email = jsonData.email
        String password = jsonData.password
        String authority = jsonData.authority

        try {

            User user = userService.addUser(username, fullname, email, password, authority)
            def result = [success: user.id]
            render result as JSON

        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }
    }

    def confirmUser() {

        def jsonData = request.JSON
        long userId = jsonData.id.toLong()
        String code = jsonData.confirmation
        User user = userService.getUserById(userId)
        if (user.confirmitionCode != code) {
            def result = [success: false]
            render result as JSON
        } else {

            try {

                userService.activateAccount(user)
                def result = [success: true]
                render result as JSON
            }

            catch (Exception e) {

                e.printStackTrace()
                def result = [success: false]
                render result as JSON
            }

        }
    }

    def getComments() {

        def jsonData = request.JSON
        long postId = jsonData.postId.toLong()
        Post post = postService.findPostById(postId)
        def comments = post?.replies

        try {
            render comments as JSON
        }

        catch (Exception e) {

            e.printStackTrace()
        }
    }

    def addComment() {

        def jsonData = request.JSON
        String comment = jsonData.comment
        long postId = jsonData.postId.toLong()
        try {
            Post post = postService.findPostById(postId)
            postService.saveComments(post, comment)
            def result = [success: true]
            render result as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def createPost() {

        User user = userService.getCurrentUser()
        def jsonData = request.JSON
        String content = jsonData.content
        String attachedFileName = jsonData.attachedFileName
        String encodedFile = jsonData.attachment
        try {

            encodedFile.replaceAll("\r", "")
            encodedFile.replaceAll("\n", "")
            byte[] attachment = encodedFile.decodeBase64()
            postService.addNewPost(user, content, attachment, attachedFileName)
            def result = [success: true]
            render result as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def updateProfile() {


        User user = userService.getCurrentUser()
        def jsonData = request.JSON
        String department = jsonData.department
        String idNumber = jsonData.idNumber
        String year = jsonData.year
        String stream = jsonData?.stream
        String position = jsonData?.position
        String aboutMe = jsonData?.aboutMe

        try {
            userService.updateProfile(user, department, year, idNumber, stream, position, aboutMe)
            def result = [success: true]
            render result as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def changeProfilePicture() {

        User user = userService.getCurrentUser()
        def jsonData = request.JSON
        String profilePicture = jsonData.profilePicture
        try {

            profilePicture.replaceAll("\r", "")
            profilePicture.replaceAll("\n", "")
            byte[] profilePic = profilePicture.decodeBase64()
            userService.uploadProfilePicture(user, profilePic)
            def result = [success: true]
            render result as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def changePersonalDetail() {

        User user = userService.getCurrentUser()
        def jsonData = request.JSON
        String username = jsonData.username
        String fullname = jsonData.fullname

        try {
            userService.updateUser(user, username, fullname)
            def result = [success: true]
            render result as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def changePassword() {

        User user = userService.getCurrentUser()
        def jsonData = request.JSON
        String curPassword = jsonData.currentPassword
        String newPassword = jsonData.newPassword
        boolean isPasswordValid = springSecurityService.passwordEncoder.isPasswordValid(user.getPassword(), curPassword, null)

        if (!isPasswordValid) {

            def result = [success: false]
            render result as JSON
        } else {

            try {

                userService.changePassword(user, newPassword)
                def result = [success: true]
                render result as JSON
            }

            catch (Exception e) {

                e.printStackTrace()
                def result = [success: false]
                render result as JSON
            }

        }

    }

    def createGroup() {

        User creator = userService.getCurrentUser()

        def jsonData = request.JSON

        String groupName = jsonData.groupName

        String groupType = jsonData.groupType

        String[] groupMembers = jsonData.groupMembers

        List<User> addedMembers

        for (name in groupMembers) {

            String username = name.substring(name.lastIndexOf("|") + 2)
            User selectedUser = userService.getUserByUsername(username) //user whose profile is to be shown
            addedMembers += selectedUser

        }

        addedMembers += creator

        try {

            groupService.createGroup(groupName, groupType, creator, addedMembers)
            def result = [success: true]
            render result as JSON
        }

        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def composeMail() {

        User sender = userService.getCurrentUser()
        def jsonData = request.JSON
        String name = jsonData.receiver
        String subject = jsonData.subject
        String content = jsonData.content
        String username = name.substring(name.lastIndexOf("|") + 2)
        User receiver = userService?.getUserByUsername(username)
        if (!receiver) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON

        } else {

            String attachedFileName = jsonData.attachedFileName
            String encodedFile = jsonData.attachment
            String attachedFileType = "file"
            try {
                encodedFile.replaceAll("\r", "")
                encodedFile.replaceAll("\n", "")
                byte[] attachment = encodedFile.decodeBase64()
                customMailService.addNewMail(sender, receiver, subject, content, attachment, attachedFileName, attachedFileType)
                def result = [success: true]
                render result as JSON

            }

            catch (Exception e) {

                e.printStackTrace()
                def result = [success: false]
                render result as JSON
            }


        }

    }

    def createRelation() {

        User follower = userService.getCurrentUser()
        def jsonData = request.JSON
        long userId = jsonData.userId.toLong()

        try {

            User user = userService.getUserById(userId) // the user to be followed
            userService.createRelation(user, follower)
            def result = [success: true]
            render result as JSON
        }

        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def removeRelation() {

        User follower = userService.getCurrentUser()
        def jsonData = request.JSON
        long userId = jsonData.userId.toLong()

        try {

            User user = userService.getUserById(userId) // the user to be followed
            userService.removeRelation(user, follower)
            def result = [success: true]
            render result as JSON
        }

        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def createGroupPost() {

        User user = userService.getCurrentUser()
        def jsonData = request.JSON
        long groupId = jsonData.groupId.toLong()
        String content = jsonData.content
        String attachedFileName = jsonData.attachedFileName
        String encodedFile = jsonData.attachment
        try {

            encodedFile.replaceAll("\r", "")
            encodedFile.replaceAll("\n", "")
            byte[] attachment = encodedFile.decodeBase64()
            groupService.createGroupPost(groupId, user, content, attachment, attachedFileName)
            def result = [success: true]
            render result as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
            def result = [success: false]
            render result as JSON
        }

    }

    def showGroupPosts() {

        def jsonData = request.JSON
        long groupId = jsonData.groupId.toLong()
        try {
            List<Post> groupPosts = groupService.getGroupPosts(groupId)
            render groupPosts as JSON
        }
        catch (Exception e) {

            e.printStackTrace()
        }

    }

}