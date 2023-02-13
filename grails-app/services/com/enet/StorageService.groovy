package com.enet

import grails.transaction.Transactional

@Transactional
class StorageService {

    def userService

    Storage getFileById(long id) {

        return Storage.findByIdAndDeleted(id, false)
    }

    Storage uploadPublicFiles(User user, byte[] file, String fileName, double fileSize){

        Storage storage = new Storage()

        storage.user = user
        storage.file = file
        storage.fileName = fileName
        storage.fileSize = fileSize
        storage.dateModified = new Date()
        storage.dateCreated = new Date()
        storage.isPublic = true
        storage.deleted = false
        storage.save(flush: true)

        return storage
    }
    Storage uploadPrivateFiles(User user, byte[] file, String fileName, double fileSize){

        Storage storage = new Storage()

        storage.user = user
        storage.file = file
        storage.fileName = fileName
        storage.fileSize = fileSize
        storage.dateModified = new Date()
        storage.dateCreated = new Date()
        storage.isPublic = false
        storage.deleted = false
        storage.save(flush: true)

        return storage
    }

    List<Storage> getAllDocumentsOfCurrentUser(){

        User currentUser = userService.getCurrentUser()
        List<Storage> allDocumentsOfCurrentUser = Storage.findAllByUserAndDeleted(currentUser,false)
    }

    List<Storage> getAllPublicDocumentsOfCurrentUser(){

        User currentUser = userService.getCurrentUser()
        List<Storage> allDocumentsOfCurrentUser = Storage.findAllByUserAndDeletedAndIsPublic(currentUser,false,true)
    }

    List<Storage> getAllPrivateDocumentsOfCurrentUser(){

        User currentUser = userService.getCurrentUser()
        List<Storage> allDocumentsOfCurrentUser = Storage.findAllByUserAndDeletedAndIsPublic(currentUser,false,false)
    }

    List<Storage> getAllPublicDocumentsOfUser(User user){

        List<Storage> allPublicDocumentsOfUser = Storage.findAllByDeletedAndUserAndIsPublic(false, user, true)
    }

    List<Storage> getAllPrivateDocumentsOfUser(long userId){

        User user = userService.getUserById(userId)
        List<Storage> allPrivateDocumentsOfUser = Storage.findAllByDeletedAndUserAndIsPublic(false, user, false)
    }

    Storage deleteFile(Storage file){

        file.deleted = true
        return file
    }
    Storage makePublic(Storage file){

        file.isPublic = true
        return file
    }
    Storage makePrivate(Storage file){

        file.isPublic = false
        return file
    }

    double calcFreeSpace(){

        List<Storage> allFiles = getAllDocumentsOfCurrentUser()
        double freeSpace = 100
        for(file in allFiles){

            freeSpace = freeSpace - (file.fileSize / 1048576)
        }

        return freeSpace
    }

    double calcPublicFileSize(){

        List<Storage> publicFiles = getAllPublicDocumentsOfCurrentUser()
        double publicFileSize = 0
        for(file in publicFiles){

            publicFileSize = publicFileSize + (file.fileSize / 1048576)
        }

        return publicFileSize
    }

    double calcPrivateFileSize(){

        List<Storage> privateFiles = getAllPrivateDocumentsOfCurrentUser()
        double privateFileSize = 0
        for(file in privateFiles){

            privateFileSize = privateFileSize + (file.fileSize / 1048576)
        }

        return privateFileSize
    }

}
