package com.enet

import grails.transaction.Transactional

@Transactional
class CustomMailService {

    def userService

    Mail getMailById(long id){

        Mail mail = Mail?.findById(id)

        return mail
    }

    Mail addNewMail(User sender, User receiver, String subject, String content, byte[] attachment, String attachedFileName, String attachedFileType) {

        Mail mail = new Mail()
        mail.sender = sender
        mail.receiver = receiver
        mail.subject = subject
        mail.content = content
        mail.attachment = attachment
        mail.attachedFileName = attachedFileName
        mail.attachedFileType = attachedFileType

        mail.save(flush: true, failOnError: true)

        return mail

    }

    List<Mail> getMailsForCurrentUser(){

        List<Mail> mailForCurrentUser = Mail.findAllByReceiverAndDeletedFromInboxAndTrashedFromInbox(userService.getCurrentUser(), false, false)

        return mailForCurrentUser
    }

    List<Mail> getMailsSentByCurrentUser(){

        List<Mail> mailSentFromCurrentUser = Mail.findAllBySenderAndDeletedFromSentAndTrashedFromSent(userService.getCurrentUser(), false, false)

        return mailSentFromCurrentUser
    }

    List<Mail> getUnreadMails(){

        User user = userService.getCurrentUser()

        List<Mail> unreadMails = Mail.findAllByReceiverAndIsReadAndDeletedFromInboxAndTrashedFromInbox(user, false, false, false)

        return unreadMails
    }

    List<Mail> getTrashedMails(User user){

        List<Mail> trashedMails = Mail.findAllBySenderAndTrashedFromSentAndDeletedFromSent(user, true, false) + Mail.findAllByReceiverAndTrashedFromInboxAndDeletedFromInbox(user, true, false)

        return trashedMails
    }

    Mail sendMailToTrash(Mail mail){

        User currentUser = userService.getCurrentUser()

        if(mail.sender == currentUser){
            mail.trashedFromSent = true
        }

        else if(mail.receiver == currentUser){
            mail.trashedFromInbox = true
        }
        mail.save(flush: true)
        return mail
    }

    Mail restoreMail(Mail mail){

        User currentUser = userService.getCurrentUser()

        if(mail.sender == currentUser){
            mail.trashedFromSent = false
        }

        else if(mail.receiver == currentUser){
            mail.trashedFromInbox = false
        }
        mail.save(flush: true)
        return mail
    }

    Mail markAsRead(Mail mail){

        User currentUser = userService.getCurrentUser()
        if(mail.receiver == currentUser){
            mail.isRead = true
        }
        mail.save(flush: true)
        return mail
    }

    Mail markAsUnread(Mail mail){

        User currentUser = userService.getCurrentUser()
        if(mail.receiver == currentUser){
            mail.isRead = false
        }
        mail.save(flush: true)
        return mail
    }

    def deleteMailPermanently(Mail mail){

        User currentUser = userService.getCurrentUser()

        if(mail.sender == currentUser){
            mail.deletedFromSent = true
        }

        else if(mail.receiver == currentUser){
            mail.deletedFromInbox = true
        }
        mail.save(flush: true)
        return mail
    }

    def emptyTrash(){

        User currentUser = userService.getCurrentUser()
        List<Mail> trashedMails = getTrashedMails(userService.getCurrentUser())
        for(mail in trashedMails){

            if(mail.sender == currentUser){
                mail.deletedFromSent = true
            }
            else if(mail.receiver == currentUser){
                mail.deletedFromInbox = true
            }
            mail.save(flush: true)
        }

    }

    def addReply(Mail mail, Mail reply){

        mail.addToReplies(reply)
        mail.save(flush: true)
        return mail

    }

    List<Mail> getMailForReply(Mail reply){

        List<Mail> mail = Mail.withCriteria {

            replies{

                idEq(reply.id)
            }
        }

        return mail
    }
}

