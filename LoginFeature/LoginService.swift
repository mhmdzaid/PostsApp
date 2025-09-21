//
//  LoginService.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//

import Foundation
import Alamofire
import Core
public protocol LoginConfig {
    var url: String { get }
    var headers: HTTPHeaders { get }
}

extension LoginConfig {
    public var url: String {
        return "https://dummyjson.com/auth/login"
    }
    
    public var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
}

public struct DefaultLoginConfig: LoginConfig {
    
    public init() {}
}

public protocol LoginServiceProtocol {
    func login<T: Codable>(username: String, password: String, config: LoginConfig,
                           completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class LoginService: LoginServiceProtocol {
    
    public init() {}
    public func login<T: Codable>(username: String,
                                  password: String,
                                  config: LoginConfig = DefaultLoginConfig(),
                                  completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(config.url,
                   method: .post,
                   parameters: ["username": username,
                                "password": password],
                   encoding: JSONEncoding.default,
                   headers: config.headers).response { response in

            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            do {
                let loginResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(loginResponse))
            } catch let error {
                completion(.failure(.error(error.localizedDescription)))
            }
        }
    }
}
