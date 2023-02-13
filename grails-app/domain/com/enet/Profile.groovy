package com.enet

import javax.websocket.Encoder

class Profile {

    User   user
    byte[] profilePicture
    String department
    String idNumber
    String stream
    String position
    String year
    String aboutMe
    Date   dateCreated
    Date   lastUpdated


    static constraints = {

        profilePicture nullable: true, maxSize: 3 * 1024 * 1024; //max size 6MB
        department nullable: true
        idNumber nullable: true
        stream nullable: true
        position nullable: true
        aboutMe nullable: true
        year nullable: true
    }

    static mapping = {

        aboutMe type: 'text'
    }
}
