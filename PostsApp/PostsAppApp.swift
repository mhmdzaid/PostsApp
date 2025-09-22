//
//  PostsAppApp.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import SwiftUI
import FeedFeature
import LoginFeature
import Core

@main
struct PostsAppApp: App {
    @StateObject var appState: AppState
    
    init() {
        let root: Root = KeyChainHelper.shared.isLoggedIn ? .home : .login
        _appState = StateObject(wrappedValue: AppState(root: root))
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .onAppear {
                    _ = Reachability.shared // initializing Reachability
                }
        }
    }
}
