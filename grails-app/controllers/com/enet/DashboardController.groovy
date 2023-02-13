package com.enet

class DashboardController {

    def userService, postService, customMailService

    def index() {


        User user = userService.getCurrentUser()

        List<User> users = userService.getAllUsers()

        List<Post> postsForCurrentUser = postService.postsForCurrentUser()

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<AdminItem> departments = AdminItem.findAllByDeleted(false)

        List<Post> notifications = postService.getNotifications()

        render(view: 'index', model:[ notifications:       notifications,
                                      user:                user,
                                      users:               users,
                                      postsForCurrentUser: postsForCurrentUser,
                                      departments:         departments,
                                      unreadMails:         unreadMails])
    }

    def saveComments(){

        long postId = params.postId.toLong()

        String comment = params.'comment'

        Post post = postService.findPostById(postId)

        try {

            postService.saveComments(post, comment)

            flash.message = "Your comment is added"

            redirect(action: index())
        }

       catch(Exception e){

           e.printStackTrace()

           flash.error = "Oops something went wrong!"

           redirect(action: index())
       }

    }

    def downloadAttachedFiles(long postId){

        Post post = postService.findPostById(postId)

        try {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${post.attachedFileName}\"")
            def outputStream = response.getOutputStream()
            outputStream << post.attachment
            outputStream.flush()
            outputStream.close()
        }

        catch (Exception e){

            e.printStackTrace()
        }
    }



}
