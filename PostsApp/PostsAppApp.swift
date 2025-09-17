//
//  PostsAppApp.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import SwiftUI
import FeedFeature
import LoginFeature
@main
struct PostsAppApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel(LoginService()))
        }
    }
}
