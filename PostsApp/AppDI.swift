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
        container.register(PostsViewModel.self) { resolver in
            PostsViewModel(postsService: resolver.resolve(PostsService.self)!)
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
            LoginViewModel(resolver.resolve(LoginService.self)!)
        }
        container.register(LoginView.self) { resolver in
            LoginView(viewModel: resolver.resolve(LoginViewModel.self)!,
                      router: BaseLoginRouter())
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
