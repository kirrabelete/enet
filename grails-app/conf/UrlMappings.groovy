class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        //urlMappings for the rest controllers
        //"/api/profile/$id?"(resource: "restProfile")

        "/"(controller: 'login', action: 'auth'  )
        "500"(view:'/500')
        "404"(view:'/404')

	}


}
