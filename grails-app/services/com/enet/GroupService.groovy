package com.enet

import grails.transaction.Transactional

@Transactional
class GroupService {

    def userService, postService

    List<EduGroup> getAllGroups(){

        return EduGroup.findAllByDeleted(false)
    }

    EduGroup getGroupById(long groupId){

       return EduGroup.findById(groupId)
    }

    EduGroup getGroupByName(String groupName){

        return EduGroup.findByName(groupName)
    }

    EduGroup createGroup(String groupName, String groupType, User creator, List<User> members){

        List<User> groupMembers = members + creator
        EduGroup group = new EduGroup()
        group.creator = creator
        group.name = groupName
        group.type = groupType
        for (member in groupMembers){

            group.addToMembers(member)
        }

        group.save(flush: true)

        return group
    }

    List<EduGroup> groupsOfCurrentUser(){

        User currentUser = userService.getCurrentUser()
        List<EduGroup> groupsOfCurrentUser = EduGroup.withCriteria {

            members{
                idEq(currentUser.id)
            }
            eq('deleted', false)
        }

        return groupsOfCurrentUser

    }

    EduGroup updateGroupMembers(long groupId, List<User> members){

        EduGroup group = getGroupById(groupId)
        User groupCreator = group.creator
        List<User> groupMembers = members + groupCreator
        group.members.clear()
        for (member in groupMembers){

            group.addToMembers(member)
        }

        group.save(flush: true)
        return group
    }

    EduGroup joinGroup(long groupId){

        User user = userService.getCurrentUser()
        EduGroup group = getGroupById(groupId)
        group.addToMembers(user)
        group.save(flush: true)

        return group
    }

    EduGroup leaveGroup(long groupId){

        User user = userService.getCurrentUser()
        EduGroup group = getGroupById(groupId)
        group.removeFromMembers(user)
        group.save(flush: true)

        return group
    }

    EduGroup deleteGroup(long groupId){

        EduGroup group = getGroupById(groupId)
        group.deleted = true
        group.save(flush: true)

        return group
    }

    EduGroup createGroupPost(long groupId, User user, String content, byte[] attachment, String attachedFileName){

        Post post = new Post()
        post.user = user
        post.content = content
        post.attachment = attachment
        post.attachedFileName = attachedFileName
        post.isGroupPost = true
        post.save(flush: true)
        EduGroup group = getGroupById(groupId)
        group.addToPosts(post)
        group.save(flush: true)

        return group

    }

    EduGroup AddGroupComment(long groupId, Post post, String comment){

        Post reply = new Post()
        reply.user = userService.getCurrentUser() //user who wrote the comment
        reply.content = comment
        reply.isComment = true
        post.isGroupPost = true
        reply.save(flush: true)
        EduGroup group = getGroupById(groupId)
        post.addToReplies(reply)
        group.addToPosts(reply)
        post.save(flush: true)
        group.save(flush: true)

        return group

    }

    List<Post> getGroupPosts(long groupId){

        EduGroup group = getGroupById(groupId)

        List<Post> groupPosts = []

        for (post in group.posts){

            if (!post.deleted && !post.isComment){

                groupPosts += post
            }
        }

        groupPosts.sort{a,b -> b.dateCreated <=> a.dateCreated}

        return groupPosts
    }


}
