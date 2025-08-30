//
//  PostsViewModel.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import Foundation

public class PostsViewModel: ObservableObject {
    var postsService: Service!
    @Published var posts: PostsResponse = []
    @Published var contentState: ContentState = .empty

    init(service: Service) {
        self.postsService = service
    }

    func getPosts() {
        contentState = .loading
        postsService.getPosts {[weak self] result in
            switch result {
            case .success(let returnedPosts):
                self?.posts = returnedPosts
                self?.contentState = .loaded

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
