package com.enet

import grails.transaction.Transactional

@Transactional
class PostService {

    def userService, groupService

    Post findPostById(long id){

        Post post = Post.findById(id)

        return post
    }

    Post addNewPost(User user, String content, byte[] attachment, String attachedFileName) {

        Post post = new Post()
        post.user = user
        post.content = content
        post.attachment = attachment
        post.attachedFileName = attachedFileName

        post.save(flush: true)

        return post

    }

    Post addNewRegPost(User user, String content, byte[] attachment, String attachedFileName, department, year) {

        Post post = new Post()
        post.user = user
        post.content = content
        post.attachment = attachment
        post.attachedFileName = attachedFileName
        post.isReg = true
        post.department = department
        post.year = year

        post.save(flush: true)

        return post

    }

    List<Post> getCommentsForPost(Post post){

        List<Post> comments = post.replies

        return comments

    }

    int getCountsOfCommentsForPost(Post post){

        int numOfCommnets = post.replies.size()

        return numOfCommnets
    }

    List<Post> postsByThisUser(User user){

        List<Post> postsByThisUser = Post.findAllByUserAndDeletedAndIsGroupPost(user, false, false)

        return postsByThisUser

    }

    List<Post> AllPostsByThisUser(User user){

        List<Post> allPostsByThisUser = Post.findAllByUserAndDeleted(user, false)

        return allPostsByThisUser

    }

    List<Post> getImportantPostsByThisUser(User user){

        List<Post> allPostsByThisUser = Post.findAllByUserAndDeletedAndIsComment(user, false, false)

        return allPostsByThisUser

    }

    List<Post> getDepartmentandRegistrarPosts(User user){

        List<Post> regPostsForCurrentUser = Post.findAllByDepartmentAndYearAndIsReg("all", "0", true) + Post.findAllByDepartmentAndYearAndIsReg(user.profile?.department,"0", true) +
                Post.findAllByDepartmentAndYearAndIsReg("all", user.profile?.year, true) + Post.findAllByDepartmentAndYearAndIsReg(user.profile?.department, user.profile?.year, true)

        return regPostsForCurrentUser
    }

    List<Post> getUnreadDepartmentandRegistrarPosts(User user){

        List<Post> regPostsForCurrentUser = Post.findAllByDepartmentAndYearAndIsRegAndIsRead("all", "0", true, false) + Post.findAllByDepartmentAndYearAndIsRegAndIsRead(user.profile?.department,"0", true, false) +
                Post.findAllByDepartmentAndYearAndIsRegAndIsRead("all", user.profile?.year, true, false) + Post.findAllByDepartmentAndYearAndIsRegAndIsRead(user.profile?.department, user.profile?.year, true, false)

        return regPostsForCurrentUser
    }

    List<Post> postsForCurrentUser(){


        List<User> usersFollowedByCurrentUser = userService.getAllUsersFollwedByCurrentUser()

        List<Post> postsForCurrentUser = []

        for (user in usersFollowedByCurrentUser){

            postsForCurrentUser += Post.findAllByUserAndDeletedAndIsCommentAndIsGroupPost(user, false, false, false)
        }

        postsForCurrentUser += getImportantPostsByThisUser(userService.getCurrentUser())

        if(userService.getCurrentUser().getAuthorities().authority.contains("ROLE_STUDENT")){

            postsForCurrentUser += getDepartmentandRegistrarPosts(userService.getCurrentUser())
        }
        postsForCurrentUser.sort{a,b -> b.dateCreated <=> a.dateCreated}

        return postsForCurrentUser
    }

    List<Post> getNotifications(){

        List<User> usersFollowedByCurrentUser = userService.getAllUsersFollwedByCurrentUser()

        List<Post> notificationsForCurrentUser = []

        for (user in usersFollowedByCurrentUser){

            notificationsForCurrentUser += Post.findAllByUserAndDeletedAndIsCommentAndIsGroupPostAndIsRead(user, false, false, false, false)
        }

        if(userService.getCurrentUser().getAuthorities().authority.contains("ROLE_STUDENT")){

            notificationsForCurrentUser += getUnreadDepartmentandRegistrarPosts(userService.getCurrentUser())
        }

        notificationsForCurrentUser.sort{a,b -> b.dateCreated <=> a.dateCreated}

        return notificationsForCurrentUser

    }

    Post saveComments(Post post, String comment){

        Post reply = new Post()

        reply.user = userService.getCurrentUser() //user who wrote the comment
        reply.content = comment
        reply.isComment = true
        post.save(flush: true)
        post.addToReplies(reply)

        return post

    }

    List<Post> getPostForReply(Post reply){

        List<Post> post = Post.withCriteria {

            replies{

                idEq(reply.id)
            }

            eq('deleted', false)
        }

        return post
    }

    Post deletePost(Post post){

        post.deleted = true
        post.save(flush: true)

        return post
    }

    Post markPostAsRead(Post post){

        post.isRead = true
        post.save(flush: true)
        return post
    }

}




