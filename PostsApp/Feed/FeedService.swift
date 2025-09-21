//
//  FeedService.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import Foundation
import Alamofire
import Core
import FeedFeature
public protocol FeedServiceProtocol {
    func fetchArticle(page: Int) async throws -> [ArticleModel]
}

public class FeedService: FeedServiceProtocol {
    public init(){}
    public func fetchArticle(page: Int) async throws -> [ArticleModel] {
        print("current page from service ........ \(page)")

        let API_KEY = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
        print("API_KEY from Info.plist: \(API_KEY)") // Debug print
        let fullURL = "https://newsapi.org/v2/everything?sources=techcrunch&page=\(page)&pageSize=10&apiKey=\(API_KEY)"
        print("full url: \(fullURL)")
        let dataTask = AF.request(fullURL, method: .get)
            .serializingDecodable(FeedResponse.self)
        let response = await dataTask.response
        switch response.result {
        case .success(let feedsResponse):
            print("response is \(feedsResponse)")
            return feedsResponse.articles ?? []
        case .failure(let error):
            throw NetworkError.error(error.localizedDescription)
        }
    }
}
