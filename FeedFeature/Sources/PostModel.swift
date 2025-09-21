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
    public let articles: [ArticleModel]?
}

public struct ArticleModel: Codable, Identifiable {
    public let id: String = UUID().uuidString;
    
   public init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    let source: Source?
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
    
    enum CodingKeys: CodingKey {
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

public struct Source: Codable {
    let id: String?
    let name: String?
}
