package com.enet

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class MailController {

    def userService, customMailService, postService

    def inbox() {

        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Mail> mailsForCCurrentUser = customMailService.getMailsForCurrentUser()
        List<Post> notifications = postService.getNotifications()

        render(view: 'inbox', model:[ notifications:       notifications,
                                      user:                user,
                                      users: users,
                                      mailSForCurrentUser: mailsForCCurrentUser,
                                      unreadMails: unreadMails])

    }

    def compose(){

        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Post> notifications = postService.getNotifications()

        render(view: 'compose', model:[ notifications: notifications,
                                      user:          user,
                                      users:         users,
                                      unreadMails:   unreadMails])

    }

    def addNewMail(){

        User sender = userService.getCurrentUser()
        String name = params.'receiver'
        String username = name.substring(name.lastIndexOf("|") + 2)
        User receiver = userService?.getUserByUsername(username)
        if (!receiver){

            flash.error = "The User Your sent the email to doesn't exist. please enter the correct name"
            redirect(controller: 'mail', action: 'compose')
        }

        else{
            String subject = params.'subject'
            String content = params.'content'

            MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request
            CommonsMultipartFile file = (CommonsMultipartFile) multipartHttpServletRequest.getFile('attachment')
            String attachedFileName = file.getOriginalFilename()

            if((file.size > (15 * 1024 * 1024)) || attachedFileName.endsWith(".jar") || attachedFileName.endsWith(".exe") || attachedFileName.endsWith(".dll") || attachedFileName.endsWith(".exe")){

                flash.error = "Your Mail couldn't be sent, Because The attached file is either too large or not supported."
                redirect(controller: 'mail', action: 'compose')
            }

            else {

                byte[] attachment = file.getBytes()
                String attachedFileType = file.contentType

                try {

                    customMailService.addNewMail(sender, receiver, subject, content, attachment, attachedFileName, attachedFileType)
                    flash.message =  "Your mail has been sent successfully."
                    redirect(controller: 'mail', action: 'inbox')
                }
                catch (Exception e) {

                    e.printStackTrace()

                    flash.error = "Your mail couldn't be sent. please check your content" +
                            " or the size of your attachment."
                    redirect(controller: 'mail', action: 'compose')
                }

            }


        }

    }

    def sent() {

        User user = userService.getCurrentUser()
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Mail> mailsSentByCurrentUser = customMailService.getMailsSentByCurrentUser()
        List<Post> notifications = postService.getNotifications()

        render(view: 'sent', model:[  notifications:           notifications,
                                      user:                   user,
                                      users:                  users,
                                      mailsSentByCurrentUser: mailsSentByCurrentUser,
                                      unreadMails:            unreadMails])

    }

    def readMail(long mailId){

        User user = userService.getCurrentUser()
        Mail mailToRead = customMailService.getMailById(mailId)
        if(!mailToRead || (mailToRead.sender != user && mailToRead.receiver != user)){

            flash.error = "sorry the mail no longer exists or yor are not authorized to see it."
            redirect(action: 'inbox')
        }

        else{

            customMailService.markAsRead(mailToRead)
            List<Mail> mailWithThisReply = customMailService?.getMailForReply(mailToRead)
            List<User> users = userService.getAllUsers()
            List<Mail> unreadMails = customMailService.getUnreadMails()
            List<Post> notifications = postService.getNotifications()

            render(view: 'readMail', model:[ notifications: notifications,
                                             user: user,
                                             users: users,
                                             mailToRead: mailToRead,
                                             unreadMails: unreadMails,
                                             mailWithThisReply: mailWithThisReply])

        }

    }

    def renderAttachedImage(){

        try{

            long mailId = params.mailId.toLong()
            Mail mail = customMailService.getMailById(mailId)
            response.setContentLength(mail.attachment.size())
            response.outputStream.write(mail.attachment)

        }

        catch (Exception e){

            e.printStackTrace()

        }
    }

    def downloadAttachedFiles(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${mail.attachedFileName}\"")
            def outputStream = response.getOutputStream()
            outputStream << mail.attachment
            outputStream.flush()
            outputStream.close()
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops! something went wrong. please check your internet connection and try again"
        }
    }

    def markAsResd(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.markAsRead(mail)
            flash.message = "mail marked as read."
            redirect(controller: 'mail', action: 'inbox')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'mail', action: 'inbox')
        }


    }

    def markAsUnread(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.markAsUnread(mail)
            flash.message = "mail marked as unread."
            redirect(controller: 'mail', action: 'inbox')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'mail', action: 'inbox')
        }


    }

    def sendToTrash(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.sendMailToTrash(mail)
            flash.message = "mail moved to trash."
            redirect(controller: 'mail', action: 'inbox')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'mail', action: 'inbox')
        }

    }

    def restoreFromTrash(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.restoreMail(mail)
            flash.message = "mail is restored to origin."
            redirect(controller: 'mail', action: 'trash')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'mail', action: 'trash')
        }

    }

    def trash(){

        User user = userService.getCurrentUser()
        List<Mail> mailsInTrash = customMailService.getTrashedMails(user)
        List<User> users = userService.getAllUsers()
        List<Mail> unreadMails = customMailService.getUnreadMails()
        List<Post> notifications = postService.getNotifications()

        render(view: 'trash', model:[   notifications: notifications,
                                        user: user,
                                        users: users,
                                        unreadMails: unreadMails,
                                        mailsInTrash: mailsInTrash])

    }

    def moveFromInboxToTrash(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.sendMailToTrash(mail)
            flash.message = "mail is moved to trash."
            redirect(controller: 'mail', action: 'inbox')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'mail', action: 'inbox')
        }

    }

    def moveFromSentToTrash(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.sendMailToTrash(mail)
            flash.message = "mail is moved to trash."
            redirect(controller: 'mail', action: 'sent')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'mail', action: 'semt')
        }

    }

    def deleteMailPermanently(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.deleteMailPermanently(mail)
            flash.message = "you've Permanently deleted a mail."
            redirect(controller: 'mail', action: 'trash')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'mail', action: 'trash')
        }
    }

    def markAsRead(long mailId){

        Mail mail = customMailService.getMailById(mailId)

        try {

            customMailService.markAsRead(mail)
            flash.message = "mail marked as read"
            redirect(controller: 'mail', action: 'inbox')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'mail', action: 'inbox')
        }
    }
    def emptyTrash(){

        try {
            customMailService.emptyTrash()
            flash.message = "Trash has been cleaned"
            redirect(controller: 'mail', action: 'trash')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'mail', action: 'trash')
        }
    }

    def writeReply(long mailId){

        Mail mail = customMailService.getMailById(mailId)
        User sender = userService.getCurrentUser()
        User receiver
        if (mail.sender == sender){
            receiver = mail.receiver
        }
        if (mail.receiver == sender){
            receiver = mail.sender
        }
        if (!receiver){

            flash.error = "The User Your sent the email to doesn't exist. please enter the correct name"
            redirect(controller: 'mail', action: 'compose')
        }

        else{
            String subject
            if(customMailService.getMailForReply(mail)){
               subject =  mail?.subject + " (mul)"
            }
            if(!customMailService.getMailForReply(mail)){
                subject =  "Re: " + mail?.subject
            }
            String content = params.'content'

            MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request
            CommonsMultipartFile file = (CommonsMultipartFile) multipartHttpServletRequest.getFile('attachment')
            String attachedFileName = file.getOriginalFilename()

            if((file.size > (15 * 1024 * 1024)) || attachedFileName.endsWith(".jar") || attachedFileName.endsWith(".exe") || attachedFileName.endsWith(".dll") || attachedFileName.endsWith(".exe")){

                flash.error = "Your Mail couldn't be sent, Because The attached file is either too large or not supported."
                redirect(controller: 'mail', action: 'compose')
            }

            else {

                byte[] attachment = file.getBytes()
                String attachedFileType = file.contentType

                try {

                    Mail reply = customMailService.addNewMail(sender, receiver, subject, content, attachment, attachedFileName, attachedFileType)
                    customMailService.addReply(mail, reply)
                    flash.message =  "Your reply has been sent successfully."
                    redirect(controller: 'mail', action: 'inbox')
                }
                catch (Exception e) {

                    e.printStackTrace()

                    flash.error = "Your mail couldn't be sent. please check your content" +
                            " or the size of your attachment."
                    redirect(controller: 'mail', action: 'compose')
                }

            }


        }

    }

    def forwardMail(long mailId){

        Mail mailToBeForwarded = customMailService.getMailById(mailId)
        User sender = userService.getCurrentUser()
        String name = params.'receiver'
        String username = name.substring(name.lastIndexOf("|") + 2)
        User receiver = userService?.getUserByUsername(username)
        if (!receiver){

            flash.error = "The User Your sent the email to doesn't exist. please enter the correct name"
            redirect(controller: 'mail', action: 'compose')
        }

        else{
            String subject = params.'subject'
            String content = params.'content'
            byte[] attachment = mailToBeForwarded?.attachment
            String attachedFileName = mailToBeForwarded?.attachedFileName
            String attachedFileType = mailToBeForwarded?.attachedFileType

                try {

                    customMailService.addNewMail(sender, receiver, subject, content, attachment, attachedFileName, attachedFileType)
                    flash.message =  "Your mail has been sent successfully."
                    redirect(controller: 'mail', action: 'inbox')
                }
                catch (Exception e) {

                    e.printStackTrace()

                    flash.error = "Your mail couldn't be sent. please check your content" +
                            " or the size of your attachment."
                    redirect(controller: 'mail', action: 'compose')
                }

        }

    }

}

