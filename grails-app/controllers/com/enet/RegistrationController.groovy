package com.enet

class RegistrationController {

    def userService

    def index() {}

    def addUser(){

        String username = params.username
        String fullname = params.fullname
        String email = params.email
        String password = params.password
        String authority = params.authority

        if(userService.getUserByUsername(username)){

            //TODO: make this an ajax call
            flash.error = "Username already taken, please input another"

            return redirect(action: index())
        }

        if(userService.getUserByEmail(email)) {

            flash.error = "a user with email address ${email} already exists"

            return redirect(action: index())

        }

        try {

            userService.addUser(username, fullname, email, password, authority)

            flash.message = "Congratulations! you have successfully registered to enet"

            redirect(controller: 'user', action: 'index', params: [username: username])
        }

        catch (Exception e){

            e.printStackTrace()

            flash.error = "Registration couldn't be completed,Please Check your inputs"

            redirect(action: index())
        }

    }

    def resendConfirmationCode(long userId) {

        User user = userService.getUserById(userId);

        try {

            userService.resendConfirmation(user);
            flash.message = "Code Sent successfully"
            return redirect(controller:'user', action: 'index', params: [username: user.username])
        }

        catch (Exception e) {
            e.printStackTrace();
            flash.error = "Unable to send code";
            return redirect(controller:'user', action: 'index', params: [username: user.username])
        }

    }
}
