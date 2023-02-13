package com.enet

class User implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	String username
	String fullname
	String email
	String password
	String confirmationCode
	boolean deleted
	Date dateCreated
	Date lastUpdated
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static hasOne = [profile : Profile]
	static hasMany = [followers: User, following: User, posts: Post, files: Storage]

	User(String username, String password) {
		this()
		this.username = username
		this.password = password

	}

	@Override
	int hashCode() {
		username?.hashCode() ?: 0
	}

	@Override
	boolean equals(other) {
		is(other) || (other instanceof User && other.username == username)
	}

	@Override
	String toString() {
		fullname + " | " + username
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this)*.role
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		email (email: true, blank: false, unique: true)
		fullname blank: false
		password blank: false

		profile nullable: true
		confirmationCode nullable: true
		followers nullable: true
		following nullable: true
	}

	static mapping = {
		password column: '`password`'

	}
}
