//
//  PostsService.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case NoData
    case error(String)
}

public protocol Service {
    func getPosts(completion: @escaping (Result<PostsResponse, NetworkError>) -> Void)
}
class PostsService: Service {
    func getPosts(completion: @escaping (Result<PostsResponse, NetworkError>) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .get).response { response in
            guard let data = response.data else {
                completion(.failure(.NoData))
                return
            }
            do {
                 let posts = try JSONDecoder().decode(PostsResponse.self, from: data)
                    completion(.success(posts))

            } catch let error {
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }
}
