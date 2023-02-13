import com.enet.AdminItem
import com.enet.EduGroup
import com.enet.Post
import com.enet.Profile
import com.enet.User
import com.enet.Role
import com.enet.Mail
import com.enet.UserRole
import grails.converters.JSON

class BootStrap {

/**
 * Created by kirubel belete
 */

    def init = { servletContext ->

        if(!Role.findByAuthority('ROLE_ADMIN')){
            new Role(authority: 'ROLE_ADMIN').save(flush: true, failOnError: true)
        }

        if (!User.findByUsername('enet')) {
            def enet = new User(username: 'enet', password: 'wordpass', fullname:'educational networking', email: 'educationalnetworking@gmail.com', confirmitionCode: 'adminpass')
            enet.save(flush: true, failOnError: true)
            def adminRole = Role.findByAuthority('ROLE_ADMIN')
            UserRole.create(enet, adminRole, true)
        }

        if (!AdminItem.findByDepartment('Pre Engineering')) {
            def pre = new AdminItem(department: 'Pre Engineering', createdBy: User.findByUsername('enet'))
            pre.save(flush: true, failOnError: true)
        }

        if (!AdminItem.findByDepartment('Electrical and Computer Engineering')) {
            def elec = new AdminItem(department: 'Electrical and Computer Engineering', createdBy: User.findByUsername('enet'))
            elec.save(flush: true, failOnError: true)
        }
        if (!AdminItem.findByDepartment('Mechanical Engineering')) {
            def mech = new AdminItem(department: 'Mechanical Engineering', createdBy: User.findByUsername('enet'))
            mech.save(flush: true, failOnError: true)
        }
        if (!AdminItem.findByDepartment('Civil and Environmental Engineering')) {
            def civil = new AdminItem(department: 'Civil and Environmental Engineering', createdBy: User.findByUsername('enet'))
            civil.save(flush: true, failOnError: true)
        }
        if (!AdminItem.findByDepartment('Software Engineering')) {
            def soft = new AdminItem(department: 'Software Engineering', createdBy: User.findByUsername('enet'))
            soft.save(flush: true, failOnError: true)
        }
        if (!AdminItem.findByDepartment('Chemical and Bio Engineering')) {
            def che = new AdminItem(department: 'Chemical and Bio Engineering', createdBy: User.findByUsername('enet'))
            che.save(flush: true, failOnError: true)
        }
        if (!AdminItem.findByDepartment('BioMedical Engineering')) {
            def bio = new AdminItem(department: 'BioMedical Engineering', createdBy: User.findByUsername('enet'))
            bio.save(flush: true, failOnError: true)
        }
        if (!AdminItem.findByDepartment('Information Technology Engineering')) {
            def info = new AdminItem(department: 'Information Technology Engineering', createdBy: User.findByUsername('enet'))
            info.save(flush: true, failOnError: true)
        }

        //Register User domain class for customized JSON rendering
        JSON.registerObjectMarshaller(User){
            def output = [:]
            output['id'] = it.id
            output['username'] = it.username
            output['fullname'] = it.fullname
            output['roles'] = it.getAuthorities().authority
            output['email'] = it.email
            output['profilePicture'] = it.profile?.profilePicture?.encodeBase64().toString()

            return output
        }

        //Register Profile domain class for customized JSON rendering
        JSON.registerObjectMarshaller(Profile){
            def output = [:]
            output['id'] = it.id
            output['department'] = it.department
            output['stream'] = it.stream
            output['year'] = it.year
            output['idNumber'] = it.idNumber
            output['position'] = it.position
            output['aboutMe'] = it.aboutMe
            output['userId'] = it.user.id
            output['fullname'] = it.user.fullname
            output['roles'] = it.user.getAuthorities().authority
            output['profilePicture'] = it.profilePicture.encodeBase64().toString()

            return output
        }
        //Register Post domain class for customized JSON rendering
        JSON.registerObjectMarshaller(Post){
            def output = [:]
            output['id'] = it.id
            output['content'] = it.content
            output['dateCreated'] = it.dateCreated
            output['attachment'] = it.attachment
            output['attachedFileName'] = it.attachedFileName
            output['isComment'] = it.isComment
            output['profilePicture'] = it.user?.profile?.profilePicture?.encodeBase64().toString()
            output['userId'] = it.user.id
            output['fullname'] = it.user.fullname
            output['replies'] = ["id":it.replies.id]
//           output['replies'] = it.replies

            return output

        }

        //Register Mail domain class for customized JSON rendering
        JSON.registerObjectMarshaller(Mail){
            def output = [:]
            output['id'] = it.id
            output['subject'] = it.subject
            output['content'] = it.content
            output['dateCreated'] = it.dateCreated
            output['isRead'] = it.isRead
            output['receiverId'] = it.receiver.id
            output['senderFullname'] = it.sender.fullname
            output['senderId'] = it.sender.id
            output['receiverFullname'] = it.receiver.fullname
            output['SenderPicture'] = it.sender?.profile?.profilePicture?.encodeBase64().toString()
            output['attachment'] = it.attachment
            output['attachedFileName'] = it.attachedFileName

            return output

        }

        //Register EduGroup domain class for customized JSON rendering
        JSON.registerObjectMarshaller(EduGroup) {
            def output = [:]
            output['id'] = it.id
            output['name'] = it.name
            output['type'] = it.type
            output['creatorId'] = it.creator.id
            output['creatorName'] = it.creator.fullname
            output['membersId'] = it.members.id
            output['membersName'] = it.members.fullname
            return output
        }

        }

    def destroy = {
    }

}
