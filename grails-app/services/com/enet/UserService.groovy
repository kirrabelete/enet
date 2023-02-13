package com.enet

import grails.plugin.springsecurity.SpringSecurityService
import grails.transaction.Transactional
import org.apache.commons.lang.RandomStringUtils
import org.apache.commons.lang.math.RandomUtils
import org.apache.log4j.Level
import org.apache.log4j.Logger
import org.codehaus.groovy.grails.orm.hibernate.cfg.GrailsHibernateUtil


@Transactional
class UserService {

    def springSecurityService

    Logger logger = Logger.getLogger(UserService.class);

    /*
    * returns the current user
    * i.e a user who is logged in and currently in session
    * @return current user
    */
    User getCurrentUser(){

        User user = springSecurityService.currentUser as User

        return user
    }

    /**
     * Returns a user with the provided id.
     * @param id : user id
     * @return user
     */
    User getUserById(long id) {

        User user = User?.get(id)
        return user
    }

    /**
     * Returns an active user with the given username.
     * @param username
     * @return user
     */

    User getUserByUsername(String username){

        User user = User.findByUsernameAndDeleted(username, false)
        return user

    }

    /**
     * Returns an active user with the given email
     * @param email
     * @return
     */
    User getUserByEmail(String email) {

        User user = User.findByEmailAndDeleted(email, false)
        return user
    }

    /**
     * Returns an active user with the given fullnem.
     * @param fullname
     * @return user
     */

    User getUserByFullname(String fullname){

        User user = User.findByFullnameAndDeleted(fullname, false)
        return user

    }

    /*
    * returns all users except
    * the admin user
    * @return all users
    */
    List<User> getAllUsers() {

        List<User> allUsers = User.findAllByDeleted(false).collect {  GrailsHibernateUtil.unwrapIfProxy it } - User.findByUsername('enet') - getCurrentUser()
        return allUsers
    }

    List<User> getAllTeachers() {

        List<User> allUsers = getAllUsers()

        List<User> allTeachers = []
        for(user in allUsers){

            if(user.getAuthorities().authority.contains("ROLE_TEACHER")){

                allTeachers += user
            }
        }

        return allTeachers
    }

    List<User> getAllStudents() {

        List<User> allUsers = getAllUsers()

        List<User> allStudents = []
        for(user in allUsers){

            if(user.getAuthorities().authority.contains("ROLE_STUDENT")){

                allStudents += user
            }
        }

        return allStudents
    }

    User addUser(String username, String fullname, String email, String password, String authority) {

        User user = new User()
        String confirmationCode = RandomStringUtils.randomAlphanumeric(6)

        user.username = username
        user.fullname = fullname
        user.email = email
        user.password = password
        user.confirmationCode = confirmationCode
        user.accountLocked = true

        user.save(flush: true)

        Role role = Role.findOrCreateByAuthority(authority)
        role.save(flush: true)
        UserRole.create(user, role, true)


        try {

            sendMail {
                from "enet Team<enetdevelopersteam@gmail.com>"
                to email
                subject "enet Registration."
                html 'Hey ' + fullname + ',<br /> You have successfully registered to <b>enet.</b> ' +
                        '<p>Your confirmation code is <b>' + confirmationCode + ' </b>.Use it to activate your account.</p>' +
                        'Peace,<br />' +
                        'The enet Team.'
            }

        } catch (Exception e) {

            logger.log(Level.ERROR, e.getMessage(), e);
        }

        return user;

    }

    Profile updateProfile(User user,String department, String year, String idNumber, String stream, String position, String aboutMe){

        Profile profile = Profile.findOrCreateByUser(user)
        profile.department = department
        profile.idNumber = idNumber
        profile.year = year
        profile.stream = stream
        profile.position = position
        profile.aboutMe = aboutMe

        profile.save(flush: true)

        return profile

    }

    User updateUser(User user,String username, String fullname){

        user.username = username
        user.fullname = fullname
        user.save(flush: true)

        return user
    }

    User changePassword(User user,String newPassword){

        user.password = newPassword
        user.save(flush: true)

        return user
    }


    Profile uploadProfilePicture(User user, byte[] profilePicture){

        Profile profile = Profile.findOrCreateByUser(user)
        profile.profilePicture = profilePicture
        profile.save(flush: true)

        return profile
    }

    /*
    takes in two users as a parameter and
    creates a follower/following
    relationship between the users
    */

    def createRelation(User user, User follower){

     user.addToFollowers(follower)
     follower.addToFollowing(user)
     user.save(flush: true)
     follower.save(flush: true)

    }

    /*
    takes in two users as a parameter and
    removes the follower/following
    relationship between the users
    */

    def removeRelation(User user, User follower){

        user.removeFromFollowers(follower)
        follower.removeFromFollowing(user)
        user.save(flush: true)
        follower.save(flush: true)

    }

    List<User> getAllUsersFollwedByCurrentUser(){

        User user = getCurrentUser()

        List<User> usersFollowedByCurrentUser = user.following as List<User>

        return usersFollowedByCurrentUser

    }

    List<User> getAllUsersFollwingCurrentUser(){

        User user = getCurrentUser()

        List<User> usersFollowingCurrentUser = user.followers as List<User>

        return usersFollowingCurrentUser

    }


    boolean isThisUserFollwedByCurrentUser(User user){ //takes a given user as a parameter (i.e ThisUser)

        User currentUser = getCurrentUser()

        boolean isUserFollwedByCurrentUser = user.followers.contains(currentUser) //checks if this user is followed by the current user in session.

        return isUserFollwedByCurrentUser
    }

    User activateAccount(User user){

        user.accountLocked = false
        user.save(flush: true)
        springSecurityService.reauthenticate(user.username, user.password)
        return user
    }

    User getUserForActivation(String username, String email){

        User user = User.findByUsernameAndDeletedAndEmail(username, false, email)
        return user
    }

    def resendConfirmation(User user) {

        user.confirmationCode = RandomStringUtils.randomAlphanumeric(6)

        sendMail {
            from "enet Team<enetteam@gmail.com>"
            to user.email
            subject "enet Activate account."
            html 'Hey ' + user.fullname + ',<br />' +
                    '<p>Your enet confirmation code is <b>' + user.confirmationCode + ' </b>.Use it to activate your account.</p>' +
                    'Peace,<br />' +
                    'The enet Team.'
                  }

            user.save(flush: true)

            return user
    }

    def sendConfirmationForPassword(User user){

            user.confirmationCode = RandomStringUtils.randomAlphanumeric(6)

            sendMail {
                from "enet Team<enetteam@gmail.com>"
                to user.email
                subject "enet confirmation."
                html 'Hey ' + user.username + ',<br />' +
                        '<p>There has been a request to change the password for your enet account.' +
                        ' if the request actually came from you, Use the confirmation code below to change your password. ' +
                        'Your confirmation code is <b>' + user.confirmationCode + ' </b>.</p>' +
                        'Peace,<br />' +
                        'The enet Support Team.'
            }


        user.save(flush: true)

        return user
    }


    def changeForgottenPassword(User user,String newPassword){

        user.password = newPassword
        user.accountLocked = false
        user.save(flush: true)
        springSecurityService.reauthenticate(user.username, user.password)

        return user
    }
}
