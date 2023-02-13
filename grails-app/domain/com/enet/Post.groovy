package com.enet

class Post {

    String content
    byte [] attachment
    String attachedFileName
    String department
    boolean deleted
    boolean isComment
    boolean isGroupPost
    boolean isRead
    String year
    boolean isReg
    Date dateCreated = new Date()
    Date dateModified = new Date()

    static belongsTo = [user: User]
    static hasMany = [replies: Post]

    static constraints = {

        attachment nullable: true, maxSize: 16777215; //max size 16MB
        attachedFileName nullable: true
        department nullable: true
        replies nullable: true
        content blank: false
        year nullable: true
    }

    static mapping = {

        content type: 'text'
        sort(dateCreated: 'desc')
    }
}
