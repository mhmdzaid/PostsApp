//
//  PostsAppApp.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import SwiftUI

@main
struct PostsAppApp: App {
    var body: some Scene {
        WindowGroup {
            PostsView(viewModel: PostsViewModel())
        }
    }
}
