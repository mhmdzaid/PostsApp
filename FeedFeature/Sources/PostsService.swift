//
//  PostsService.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
   case noData
   case error(String)
}

public protocol Service {
    func getPosts(page: Int, completion: @escaping (Result<[Article], NetworkError>) -> Void)
}

public class PostsService: Service {
    public init(){}
    public func getPosts(page: Int, completion: @escaping (Result<[Article], NetworkError>) -> Void) {
        let bundle = Bundle(for: PostsViewModel.self)

        let API_KEY = bundle.object(forInfoDictionaryKey: "API_KEY") as? String
        //https://newsapi.org/v2/everything?sources=techcrunch&page=2&pageSize=10&apiKey=7ac2d2b17b574131a5d0a05bc59bd807
        let fullURL = "https://newsapi.org/v2/everything?sources=techcrunch&page=\(page)&pageSize=10&apiKey=\(API_KEY ?? "")"

        AF.request(fullURL, method: .get).response { response in
            
            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            do {
                 let response = try JSONDecoder().decode(PostsResponse.self, from: data)
                completion(.success(response.articles ?? []))

            } catch let error {
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }
}
