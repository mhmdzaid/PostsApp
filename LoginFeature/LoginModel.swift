//
//  LoginModel.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//

import Foundation

public struct LoginResponse: Codable {
    public let id: Int
    public let username: String
    public let email: String
    public let firstName: String
    public let lastName: String
    public let gender: String
    public let image: URL
    public let accessToken: String
    public let refreshToken: String
}

