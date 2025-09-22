//
//  FeedRepo.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 20/09/2025.
//

import Foundation
import FeedFeature
import Core

class FeedRepo {
    let service: FeedServiceProtocol
    let cache: FeedCacheProtocol
    var servicePage = 1
    
    init(service: FeedServiceProtocol, cache: FeedCacheProtocol) {
        self.service = service
        self.cache = cache
    }
    
    func getCachedOfflineFeed() -> [ArticleModel] {
        let cachedArticles = cache.fetchArticles();
        return servicePage == 1 ? cachedArticles : []
        
    }
    
    func getOnlineFeed() async throws -> [ArticleModel] {
        do {
            let fetchedArticles = try await service.fetchArticle(page: servicePage)
            cacheFetched(articles: fetchedArticles)
            return fetchedArticles
        } catch let error {
            throw error
        }
    }
    
    
    func fetchArticles(servicePage: Int) async throws-> [ArticleModel] {
        self.servicePage = servicePage
        guard Reachability.shared.isConnected else {
            print("getting offline feed .......")
            return getCachedOfflineFeed()
        }
        do {
            print("getting online feed ....")
           return try await getOnlineFeed()
        } catch let error {
            throw error
        }
    }
    
    func cacheFetched(articles: [ArticleModel]) {
        cache.saveArticles(models: articles)
    }
}
