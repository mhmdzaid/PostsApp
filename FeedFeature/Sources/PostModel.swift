//
//  PostModel.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 03/08/2024.
//

import Foundation

public struct PostsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

public struct Article: Codable, Identifiable {
    public let id: String = UUID().uuidString;
    
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: CodingKey {
        case id
        case source
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
