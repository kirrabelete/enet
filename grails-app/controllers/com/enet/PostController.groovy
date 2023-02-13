package com.enet

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class PostController {

    def userService, postService, customMailService

    def index() {}

    def addNewPost(){

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

                postService.addNewPost(user, content, attachment,attachedFileName)
                flash.message = "You have Successfully added a new post."
                redirect(controller: 'dashboard', action: 'index')
            }
            catch (Exception e){

                log.error(e.stackTrace)
                flash.error = "Your post couldn't be added please check your content" +
                        "or the size of your attachment."
                redirect(controller: 'dashboard', action: 'index')
            }


        }

    }

    def addNewRegistrarPost(){

        User user = userService.getCurrentUser()
        String department = params.department
        String year = params.year
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

                postService.addNewRegPost(user, content, attachment,attachedFileName, department, year)
                flash.message = "You have Successfully added a new post."
                redirect(controller: 'dashboard', action: 'index')
            }
            catch (Exception e){

                log.error(e.stackTrace)
                flash.error = "Your post couldn't be added please check your content" +
                        "or the size of your attachment."
                redirect(controller: 'dashboard', action: 'index')
            }


        }

    }

    def showPostForThisReply(long postId){

        Post reply = postService.findPostById(postId)
        List<Post> posts = postService.getPostForReply(reply)
        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Post> notifications = postService.getNotifications()

        render(view: 'showPost', model:[ notifications: notifications,
                                      user: user,
                                      users: users,
                                      unreadMails: unreadMails,
                                      posts: posts])

    }

    def showPost(long postId){

        Post post = postService.findPostById(postId)
        postService.markPostAsRead(post)
        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Post> notifications = postService.getNotifications()

        render(view: 'showPostDetail', model:[ notifications:       notifications,
                                               user:                user,
                                               users:       users,
                                               unreadMails: unreadMails,
                                               post:       post])

    }

    def saveComments(){

        long postId = params.postId.toLong()

        String comment = params.'comment'

        Post post = postService.findPostById(postId)

        try {

            postService.saveComments(post, comment)

            flash.message = "Your comment is added"

            redirect(action: showPost(postId))
        }

        catch(Exception e){

            e.printStackTrace()

            flash.error = "Oops something went wrong!"

            redirect(action: showPost(postId))

        }

    }

    def renderAttachedImage(long postId){

        try{

            Post post = postService.findPostById(postId)
            response.setContentLength(post.attachment.size())
            response.outputStream.write(post.attachment)

        }

        catch (Exception e){

            e.printStackTrace()

        }
    }

}
