package com.enet

import grails.transaction.Transactional

@Transactional
class AdminService {

    def userService

    AdminItem findItemById(long itemId){

        AdminItem item = AdminItem.findById(itemId)

        return item
    }

    User lockUser(User user) {

        user.accountLocked = true
        user.save(flush: true)

        return user
    }

    User unlockUser(User user) {

        user.accountLocked = false
        user.save(flush: true)

        return user
    }

    AdminItem addNewDepartment(String department){

        AdminItem item = AdminItem.findOrCreateByDepartment(department)
        item.deleted = false
        item.createdBy = userService.getCurrentUser()
        item.save(flush: true)

        return item
    }

    AdminItem editDepartment(AdminItem item, String department){

        item.department = department
        item.save(flush: true)

        return item
    }

    AdminItem deleteDepartment(AdminItem item){

        item.deleted = true
        item.save(flush: true)

        return item
    }

}
