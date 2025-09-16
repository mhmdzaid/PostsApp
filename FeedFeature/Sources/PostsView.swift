//
//  ContentView.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import SwiftUI

public struct PostsView: View {
    
    public init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: PostsViewModel
    @State private var lastPostId: String? = nil
    public var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.posts) { post in
                    NavigationLink {
                        PostDetailsView(article: post)
                    } label: {
                        PostView(post: post)
                            .onAppear {
                                if post.id == viewModel.posts.last?.id {
                                    lastPostId = post.id
                                    viewModel.isLoadingMore = true
                                    viewModel.getPosts()
                                }
                            }
                    }
                }
                if viewModel.isLoadingMore {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 100, height: 100)
                        .background(Color(.systemBackground).opacity(0.8))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.opacity)
                }
                
                switch viewModel.contentState {
                    
                case .loading:
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                    
                case .error:
                    Text("something went wrong ...")
                    
                case .empty:
                    Text("sorry, no vailable posts right now ...")
                default:
                    EmptyView()
                }
            }
            .onFirstAppear {
                viewModel.getPosts()
            }
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle(Text(viewModel.contentState == .loaded ? "New feed" : ""))
        }
        
        
    }
}

#Preview {
    PostsView(viewModel: PostsViewModel(postsService: PostsService()))
}
