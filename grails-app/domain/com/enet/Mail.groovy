package com.enet

class Mail {

    User sender
    User receiver
    String subject
    String content
    byte[] attachment
    String attachedFileName
    String attachedFileType
    boolean isRead
    Date dateCreated = new Date()
    Date dateModified = new Date()
    boolean trashedFromInbox
    boolean trashedFromSent
    boolean deletedFromInbox
    boolean deletedFromSent

    static hasMany = [replies : Mail]

    static constraints = {

        sender nullable: false
        receiver nullable: false
        subject nullable: true
        attachment nullable: true, maxSize: 16777215; //max size 16MB
        attachedFileName nullable: true
        content blank: false
        replies nullable: true
        attachedFileType nullable: true

    }

    static mapping = {

        content type: 'text'
        sort(dateCreated: 'desc')
    }

}


