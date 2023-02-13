package com.enet

class Storage {

    byte [] file
    String fileName
    double fileSize
    boolean deleted
    boolean isPublic
    Date dateCreated = new Date()
    Date dateModified = new Date()

    static belongsTo = [user: User]

    static constraints = {

        file nullable: false, maxSize: 16777215; //max size 16MB
        fileName nullable: false
    }

    static mapping = {

        sort(dateCreated: 'desc')
    }

}
