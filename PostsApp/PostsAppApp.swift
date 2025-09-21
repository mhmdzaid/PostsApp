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
    var body: some Scene {
        WindowGroup {
            if(KeyChainHelper.shared.isLoggedIn) {
                AppDI.shared.constructHomeView()
                .onAppear {
                    _ = Reachability.shared // initializing Reachability
                }
            } else {
                AppDI.shared.makeLoginView()
            }
        }
    }
}
