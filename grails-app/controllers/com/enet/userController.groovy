package com.enet

class userController {

    def userService, springSecurityService

    def index() {

        String username = params.username
        User user = userService.getUserByUsername(username)
        render(view: 'index', model: [user: user])
    }

    def activateAccount(long userId) {

        User user = userService.getUserById(userId)
        String code = params.'confirmationCode'

        if (user.confirmationCode != code) {
            flash.error = "user activation failed please input the correct confirmation code"
            redirect(action: 'index', params: [username: user.username])
        } else {

            try {
                userService.activateAccount(user)
                flash.message = "successfully activated your account"
                redirect(controller: 'dashboard', action: 'index')
            }

            catch (Exception e) {

                e.printStackTrace()
                flash.error = "user activation failed please input the correct confirmation code"
                redirect(action: 'index', params: [username: user.username])
            }

        }

    }

    def checkUser() {

        render(view: 'checkUser')
    }

    def reactivateAccount() {

        String username = params.username
        String email = params.email
        String password = params.password

        if (!userService.getUserForActivation(username, email)) {

            flash.error = "we couldn't find any user with the given inputs"
            redirect(action: 'checkUser')

        }

        else {

                User user = userService.getUserForActivation(username, email)

                if (!springSecurityService.passwordEncoder.isPasswordValid(user.getPassword(), password, null)) {

                    flash.error = "we couldn't find any user with the given inputs"
                    redirect(action: 'checkUser')
                }

                else if (!user.accountLocked) {

                    flash.error = "Your account is already active"
                    redirect(controller: 'login', action: 'auth')

                }

                else {

                    try {

                        userService.resendConfirmation(user)
                        redirect(action: 'index', params: [username: username])

                    }

                    catch (Exception e){

                        e.printStackTrace()
                        flash.error = "Oops something went wrong"
                        redirect(action: 'checkUser')
                    }
                }
            }
    }

    def forgotPassword(){

        render(view: 'forgotPassword')
    }

    def validateUser(){

        String username = params.username
        String email = params.email

        if (!userService.getUserForActivation(username, email)) {

            flash.error = "we couldn't find any user with the given inputs"
            redirect(action: 'forgotPassword')

        }

        else {

            User user = userService.getUserForActivation(username, email)

                try {

                    userService.sendConfirmationForPassword(user)
                    redirect(action: 'confirmUser', params: [username: user.username])

                }

                catch (Exception e){

                    e.printStackTrace()
                    flash.error = "Oops something went wrong"
                    redirect(action: 'forgotPassword')
                }
            }
    }

    def confirmUser(){

        String username = params.username
        User user = userService.getUserByUsername(username)

        render(view: 'confirmUser', model: [user: user])

    }

    def toPassword(long userId){

        User user = userService.getUserById(userId)
        String code = params.'confirmationCode'

        if (user.confirmtionCode != code) {
            flash.error = "please input the correct confirmation code"
            redirect(action: 'confirmUser', params: [username: user.username])
        } else {

            try {
                userService.activateAccount(user)
                flash.message = "successfully verified yourself"
                redirect(controller: 'user', action: 'updatePassword', params: [userId: userId])
            }

            catch (Exception e) {

                e.printStackTrace()
                flash.error = "user activation failed please input the correct confirmation code"
                redirect(action: 'confirmUser', params: [username: user.username])
            }

        }
    }

    def updatePassword(long userId){

        User user = userService.getUserById(userId)

        render(view: 'updatePassword', model: [user: user])
    }

    def changePassword(long userId){

        User user = userService.getUserById(userId)
        String newPassword = params.newPassword

            try {

                userService.changeForgottenPassword(user, newPassword)
                flash.message = "You've successfully changed your password"
                redirect(controller: 'dashboard', action: 'index')
            }

            catch (Exception e){

                e.printStackTrace()
                flash.error = "Error while changing password, please check your inputs."
                redirect(controller: 'user', action: 'updatePassword', params: [userId: userId])
            }
    }
}
