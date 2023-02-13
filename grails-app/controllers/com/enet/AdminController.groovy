package com.enet

class AdminController {

    def userService, postService, customMailService, adminService

    def index() {

        User user = userService.getCurrentUser()

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<AdminItem> departments = AdminItem.findAllByDeleted(false)

        List<User> users = userService.getAllUsers()

        List<Post> notifications = postService.getNotifications()

        render(view: 'index', model:[ notifications:       notifications,
                                      user:                user,
                                      users:               users,
                                      unreadMails:         unreadMails,
                                      departments:         departments])
    }

    def lockUser(long userId){

        User user = userService.getUserById(userId)
        try {

            adminService.lockUser(user)
            flash.message = "user account is locked."
            redirect(controller: 'admin', action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'admin', action: index())
        }
    }

    def unlockUser(long userId){

        User user = userService.getUserById(userId)
        try {

            adminService.unlockUser(user)
            flash.message = "user account is unlocked."
            redirect(controller: 'admin', action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'admin', action: index())
        }
    }

    def addNewDepartment(){

        String department = params.department

        try {

            adminService.addNewDepartment(department)
            flash.message = "department has been added"
            redirect(controller: 'admin', action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'admin', action: index())
        }

    }

    def editDepartment(long itemId){

        AdminItem item = adminService.findItemById(itemId)

        String department = params.department
        try {

            adminService.editDepartment(item, department)
            flash.message = "department has been updated"
            redirect(controller: 'admin', action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'admin', action: index())
        }
    }

    def deleteDepartment(long itemId){

        AdminItem item = adminService.findItemById(itemId)

        try {

            adminService.deleteDepartment(item)
            flash.message = "department has been deleted"
            redirect(controller: 'admin', action: index())
        }

        catch (Exception e){

            e.printStackTrace()
            flash.error = "Oops something went wrong."
            redirect(controller: 'admin', action: index())
        }
    }
}
