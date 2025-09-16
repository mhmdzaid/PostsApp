//
//  PostsViewModel.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import Foundation
import Combine

public class PostsViewModel: ObservableObject {
    var postsService: Service = PostsService()
    @Published var posts: [Article] = []
    @Published var contentState: ContentState = .empty
    var currentPage = 1;
    var isLoadingMore = false
    public init(postsService: Service) {
        self.postsService = postsService
    }
    func getPosts() {
        contentState = .loading
        postsService.getPosts(page: currentPage) {[weak self] result in
            switch result {
            case .success(let returnedPosts):
                self?.posts.append(contentsOf: returnedPosts)
                self?.contentState = .loaded
                self?.currentPage += 1
                self?.isLoadingMore = false;
                
            case .failure(let error):
                self?.contentState = .error(error.localizedDescription)
                print(error)
            }
        }
    }

}

enum ContentState: Equatable {
    case loading
    case loaded
    case error(String)
    case empty
}
