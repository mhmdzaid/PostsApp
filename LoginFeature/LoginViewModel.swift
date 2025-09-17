//
//  LoginViewModel.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//
import Foundation
import Core
import Combine

public protocol LoginViewModelProtocol {
    func login()
}

public class LoginViewModel: ObservableObject, LoginViewModelProtocol {
    private let service: LoginServiceProtocol
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var contentState: ContentState = .empty
    
    public init(_ service: LoginServiceProtocol) {
        self.service = service
    }
    
    public func login() {
        print("username: \(username), password: \(password)")
        contentState = .loading
        service.login(username: username,
                      password: password,
                      config: DefaultLoginConfig()) { [weak self ] (result: Result<LoginResponse, NetworkError>) in
            
            switch result {
            case .success(let response):
                print("Logged in user: \(response.username)")
                self?.contentState = .loaded
                
            case .failure(let error):
                self?.contentState = .error(error.localizedDescription)
                print("Login failed with error: \(error.localizedDescription)")
            }
        }
    }
}
