//
//  ContentView.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import SwiftUI

struct PostsView: View {
    @ObservedObject var viewModel: PostsViewModel
    var body: some View {
        VStack {
            switch viewModel.contentState {
            case .loading:
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
            case .loaded:
                List(viewModel.posts) { post in
                    Text(post.title)
                }
            case .error(_):
                Text("something went wrong ...");
            case .empty:
                Text("sorry, no vailable posts right now ...");
            }
        }
        .onAppear {
            viewModel.getPosts()
        }
    }
}

#Preview {
    PostsView(viewModel: PostsViewModel())
}
