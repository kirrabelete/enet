package com.enet

class EduGroup {

    User creator
    String name
    String type
    Date dateCreated = new Date()
    Date dateModified = new Date()
    boolean  deleted

    static hasMany = [members: User, posts: Post]
    static constraints = {

        name unique: true
        posts nullable: true
    }
}
