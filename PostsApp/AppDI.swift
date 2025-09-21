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
import ProfileFeature
import SwiftUI

public class AppDI {
    public static let shared = AppDI()
    public let container: Container
    
    public init() {
        self.container = Container()
        registerFeedFeature()
        registerLoginFeature()
        registerProfileFeature()
    }
    
    private func registerProfileFeature() {
        container.register(ProfileView.self) { _ in
            guard let loggedInUser = KeyChainHelper.shared.getUser() else {
                // Provide a default ProfileUser if not logged in
                return ProfileView(user: ProfileUser(
                    username: "",
                    email: "",
                    firstName: "",
                    lastName: "",
                    image: URL(string: "https://example.com/default.png")!
                )) {
                    // logout action
                    KeyChainHelper.shared.deleteUser()
                }
            }
            
            let profileUser = ProfileUser(
                username: loggedInUser.username,
                email: loggedInUser.email,
                firstName: loggedInUser.firstName,
                lastName: loggedInUser.lastName,
                image: loggedInUser.image
            )
            return ProfileView(user: profileUser,
                               onLogout: {
                KeyChainHelper.shared.deleteUser()
            })
        }
    }
    private func registerFeedFeature() {
        container.register(FeedService.self) { _ in
            FeedService()
        }
        
        container.register(FeedDataStore.self) { _ in
            FeedDataStore.shared
        }
        
        container.register(FeedRepo.self) { resolver in
            FeedRepo(service: resolver.resolve(FeedService.self)!,
                     cache: resolver.resolve(FeedDataStore.self)!)
        }
        
        container.register(FeedProvider.self) { resolver in
            FeedProvider(repo: resolver.resolve(FeedRepo.self)!)
        }
        
        container.register(FeedViewModel.self) { resolver in
            FeedViewModel(provider:  resolver.resolve(FeedProvider.self)!)
        }
        
        container.register(FeedView.self) { resolver in
            FeedView(viewModel: resolver.resolve(FeedViewModel.self)!)
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
    
    public func makeFeedView() -> FeedView {
        return container.resolve(FeedView.self)!
    }
    
    public func makeProfileView() -> ProfileView {
        return container.resolve(ProfileView.self)!
    }
    
    public func constructHomeView() -> some View {
        TabView {
            Tab("Feed", systemImage: "list.bullet") {
                AppDI.shared.makeFeedView()
            }
            Tab("Profile", systemImage: "person.circle") {
                AppDI.shared.makeProfileView()
            }
        }
    }
}

struct BaseProfileRouter: ProfileRouter {
    func navigateOnLogout() -> AnyView {
        AnyView(AppDI.shared.makeLoginView())
    }
    
    public init(){}
    
}
struct BaseLoginRouter: LoginRouter {
    public init() {}
    public func navigateToOnSuccess() -> AnyView {
        AnyView(AppDI.shared.constructHomeView())
    }
}
