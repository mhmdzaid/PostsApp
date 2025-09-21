//
//  FeedViewModel.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import Foundation
import Combine
import Core

public protocol FeedFeatureProvider {
    func getArticles(page: Int) async throws-> [ArticleModel]
}
public class FeedViewModel: ObservableObject {
    var provider: FeedFeatureProvider
    var currentPage = 1;
    var isLoadingMore = false
    @Published var articles: [ArticleModel] = []
    @Published var contentState: ContentState = .empty
  
    public init(provider: FeedFeatureProvider) {
        self.provider = provider
    }
    
    func getPosts() async {
        await MainActor.run {
            contentState = .loading
        }
        do {
            let newArticles = try await provider.getArticles(page: currentPage)
            await MainActor.run {
                articles.append(contentsOf: newArticles)
                currentPage += 1
                isLoadingMore = false
                contentState = .loaded
                print("current page from view model ........ \(currentPage)")
            }
        } catch let error {
            await MainActor.run {
                contentState = .error(error.localizedDescription)
                print(error)
            }
        }
    }
}
