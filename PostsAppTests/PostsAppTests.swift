//
//  PostsAppTests.swift
//  PostsAppTests
//
//  Created by Mohamed Elmalhey on 29/08/2025.
//

import XCTest
@testable import PostsApp

class PostsViewModelTests: XCTestCase {

    var viewModel: PostsViewModel?

    override func setUp() {
        viewModel = PostsViewModel()
        viewModel?.postsService = MockedPostsService()
    }

    func testGetPostsMethod() async throws {
        viewModel?.getPosts()
        XCTAssertEqual(viewModel?.contentState, .loaded)

        let firstPostUserId = viewModel?.posts[0].userID
        XCTAssertEqual(firstPostUserId, 123)
    }

}

class MockedPostsService: Service {
    func getPosts(completion: @escaping (Result<PostsApp.PostsResponse, PostsApp.NetworkError>) -> Void) {
        completion(.success([Post(userID: 123,
                                              id: 1,
                                              title: "Main Test header",
                                              body: "this is a mocked post just for testing")]))
    }
}
