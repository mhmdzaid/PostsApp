//
//  LoginModel.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//

import Foundation

public struct LoginResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: URL
    let accessToken: String
    let refreshToken: String
}

