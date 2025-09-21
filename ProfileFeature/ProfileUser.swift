//
//  ProfileUser.swift
//  ProfileFeature
//
//  Created by Mohamed Elmalhey on 21/09/2025.
//

import Foundation

public struct ProfileUser {
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let image: URL
   
    public init(username: String,
                email: String,
                firstName: String,
                lastName: String,
                image: URL) {
        self.username = username
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }
}
