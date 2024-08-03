//
//  PostModel.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 03/08/2024.
//

import Foundation
struct Post: Codable, Identifiable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias PostsResponse = [Post]
