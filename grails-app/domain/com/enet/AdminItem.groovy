package com.enet

class AdminItem {

    String department
    Date dateCreated = new Date()
    Date dateModified = new Date()
    User createdBy
    boolean deleted

    static constraints = {

        department unique: true, nullable: false
    }
}
