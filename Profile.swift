//
//  Profile.swift
//  CommunityEventsMap
//
//  Created by Ashleigh Edwards on 27/07/2022.
//

import JWTDecode//decode the token to extract user profile information it contains
import Foundation

struct Profile {
    let id: String
    var name: String
    let email: String
    let emailVerified: String
    let updatedAt: String
}

extension Profile {
    static var empty: Self {
        return Profile(
            id: "",
            name: "",
            email: "",
            emailVerified: "",
            updatedAt: ""
        )
    }
    
    static func from(_ idToken: String) -> Self {
        guard
            let jwt = try? decode(jwt: idToken),
                let id = jwt.subject,
                let name = jwt.claim(name: "name").string,
                let email = jwt.claim(name: "email").string,
                let emailVerified = jwt.claim(name: "email_verified").boolean,
                let updatedAt = jwt.claim(name: "updated_at").string
        else {
            return .empty
        }
        
        return Profile(
            id: id,
            name: name,
            email: email,
            emailVerified: String(describing: emailVerified),
            updatedAt: updatedAt
        )
    }
}
