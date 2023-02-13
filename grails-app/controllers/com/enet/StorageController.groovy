package com.enet

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

class StorageController {

    def userService, postService, customMailService, storageService

    def index() {

        User user = userService.getCurrentUser()

        List<User> users = userService.getAllUsers()

        List<Storage> allDocuments = storageService.allDocumentsOfCurrentUser

        List<Storage> allPublicDocuments = storageService.getAllPublicDocumentsOfCurrentUser()

        List<Storage> allPrivateDocuments = storageService.getAllPrivateDocumentsOfCurrentUser()

        double freeSpace = storageService.calcFreeSpace()

        double publicFileSize = storageService.calcPublicFileSize()

        double privateFileSize = storageService.calcPrivateFileSize()

        List<Mail> unreadMails = customMailService.getUnreadMails()

        List<Post> notifications = postService.getNotifications()

        render(view: 'index', model:[ notifications:       notifications,
                                      user:                user,
                                      users:               users,
                                      unreadMails:         unreadMails,
                                      allPublicDocuments:  allPublicDocuments,
                                      allPrivateDocuments: allPrivateDocuments,
                                      freeSpace:           freeSpace,
                                      publicFileSize:      publicFileSize,
                                      privateFileSize:     privateFileSize,
                                      allDocuments:        allDocuments,])
    }

    def uploadPublicFiles(){

        User user = userService.getCurrentUser()
        double freeSpace = storageService.calcFreeSpace()
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request
        def files = multipartHttpServletRequest.getFiles('files')
        if(freeSpace <= 0){
            flash.error = "You don't have enough space to store this file."
            redirect(controller: 'storage', action: 'index')
        }

        else {

            try {
                for(document in files) {
                    byte[] file = document.getBytes()
                    String fileName = document.getOriginalFilename()
                    double fileSize = document.size
                    storageService.uploadPublicFiles(user, file, fileName, fileSize)
                }
                flash.message = "You have Successfully Uploaded Your files."
                redirect(controller: 'storage', action: 'index')
            }
            catch (Exception e){

                log.error(e.stackTrace)
                flash.error = "Your Files couldn't be uploaded please check your content" +
                        "or the size of your files."
                redirect(controller: 'storage', action: 'index')
            }

        }

    }

    def uploadPrivateFiles(){

        User user = userService.getCurrentUser()
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request
        def files = multipartHttpServletRequest.getFiles('files')

        try {
            for(document in files) {
                byte[] file = document.getBytes()
                String fileName = document.getOriginalFilename()
                double fileSize = document.size
                storageService.uploadPrivateFiles(user, file, fileName, fileSize)
            }
            flash.message = "You have Successfully Uploaded Your files."
            redirect(controller: 'storage', action: 'index')
        }
        catch (Exception e){

            log.error(e.stackTrace)
            flash.error = "Your Files couldn't be uploaded please check your content" +
                    "or the size of your files."
            redirect(controller: 'storage', action: 'index')
        }

    }

    def downloadFile(long fileId){

        Storage document = storageService.getFileById(fileId)

        try {
            response.setContentType("APPLICATION/OCTET-STREAM")
            response.setHeader("Content-Disposition", "Attachment;Filename=\"${document.fileName}\"")
            def outputStream = response.getOutputStream()
            outputStream << document.file
            outputStream.flush()
            outputStream.close()
        }

        catch (Exception e){

            e.printStackTrace()
        }
    }

    def deleteFile(long fileId){

        Storage file = storageService.getFileById(fileId)
        try {

            storageService.deleteFile(file)
            flash.message = "you've deleted a file."
            redirect(controller: 'storage', action: 'index')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'storage', action: 'index')
        }

    }
    def makePublic(long fileId){

        Storage file = storageService.getFileById(fileId)
        try {

            storageService.makePublic(file)
            flash.message = "you've deleted a file."
            redirect(controller: 'storage', action: 'index')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'storage', action: 'index')
        }

    }
    def makePrivate(long fileId){

        Storage file = storageService.getFileById(fileId)
        try {

            storageService.makePrivate(file)
            flash.message = "you've deleted a file."
            redirect(controller: 'storage', action: 'index')
        }

        catch (Exception e){

            e.printStackTrace()
            flash.message = "Oops something went wrong."
            redirect(controller: 'storage', action: 'index')
        }

    }

}



