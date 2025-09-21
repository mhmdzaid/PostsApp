//
//  AppDI.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 19/09/2025.
//
import Foundation
import FeedFeature
import LoginFeature
import Swinject
import SwiftUICore

public class AppDI {
    public static let shared = AppDI()
    public let container: Container
    
    public init() {
        self.container = Container()
        registerFeedFeature()
        registerLoginFeature()
    }
    
    private func registerFeedFeature() {
        container.register(PostsService.self) { _ in
            PostsService()
        }
        
        container.register(FeedDataStore.self) { _ in
            FeedDataStore.shared
        }
        
        container.register(FeedRepo.self) { resolver in
            FeedRepo(service: resolver.resolve(PostsService.self)!,
                     cache: resolver.resolve(FeedDataStore.self)!)
        }
        
        container.register(FeedProvider.self) { resolver in
            FeedProvider(repo: resolver.resolve(FeedRepo.self)!)
        }
        
        container.register(PostsViewModel.self) { resolver in
            PostsViewModel(provider:  resolver.resolve(FeedProvider.self)!)
        }
        
        container.register(PostsView.self) { resolver in
            PostsView(viewModel: resolver.resolve(PostsViewModel.self)!)
        }
    }
    
    private func registerLoginFeature() {
        container.register(LoginService.self) { _ in
            LoginService()
        }
        container.register(LoginRouter.self) { _ in
            BaseLoginRouter()
        }
        
        container.register(LoginViewModel.self) { resolver in
            LoginViewModel(resolver.resolve(LoginService.self)!,
                           onLoginSuccess: { response in
                KeyChainHelper.shared.saveUser(response)
            })
        }
        container.register(BaseLoginRouter.self) { _ in
            BaseLoginRouter()
        }
        container.register(LoginProvider.self) { resolver in
            LoginProvider(viewModel: resolver.resolve(LoginViewModel.self)!,
                          router: resolver.resolve(BaseLoginRouter.self)!,
                          loginViewImage: Image.init("tcFeed_ic"),
                          onSuccessfullLogin: { response in
                KeyChainHelper.shared.saveUser(response)
            })
        }
        container.register(LoginView.self) { resolver in
            LoginView(provider: resolver.resolve(LoginProvider.self)!)
        }
    }
    
    public func makeLoginView() -> LoginView {
        return container.resolve(LoginView.self)!
    }
    
    public func makeFeedView() -> PostsView {
        return container.resolve(PostsView.self)!
    }
}

struct BaseLoginRouter: LoginRouter {
    public init() {}
    public func navigateToOnSuccess() -> AnyView {
        AnyView(AppDI.shared.makeFeedView())
    }
}
