//
//  FeedProvider.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 21/09/2025.
//

import Foundation
import FeedFeature

class FeedProvider: FeedFeatureProvider {
    private let repo: FeedRepo
   
    init(repo: FeedRepo) {
        self.repo = repo
    }
    
    func getArticles(page: Int) async throws -> [ArticleModel] {
        do{
           return try await repo.fetchArticles(servicePage: page)
        } catch let error {
            throw error
        }
    }
}
