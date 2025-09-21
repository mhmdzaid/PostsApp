//
//  FeedView.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 01/08/2024.
//

import SwiftUI
import Core

public struct FeedView: View {
    
    public init(viewModel: FeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @StateObject var viewModel: FeedViewModel
    @State private var lastPostId: String? = nil
    
    public var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.articles) { post in
                    NavigationLink {
                        FeedDetailsView(article: post)
                    } label: {
                        ArticleView(post: post)
                            .onAppear() {
                                if post.id == viewModel.articles.last?.id {
                                    lastPostId = post.id
                                    viewModel.isLoadingMore = true
                                    Task {
                                        await viewModel.getPosts()
                                    }
                                }
                            }
                    }
                }
                if viewModel.isLoadingMore {
                    ProgressIndicatorView()
                }
                
                switch viewModel.contentState {
                    
                case .loading:
                    ProgressIndicatorView()
                    
                case .error:
                    Text("something went wrong ...")
                    
                case .empty:
                    Text("sorry, no available posts right now ...")
                    
                default:
                    EmptyView()
                }
            }
            .onFirstAppear {
                Task {
                    await viewModel.getPosts()
                }
            }
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationTitle(Text(viewModel.contentState == .loaded ? "New feed" : ""))
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
}

struct FeedView_Previews: FeedFeatureProvider {
    func getArticles(page: Int) async throws -> [ArticleModel] {
        return []
    }
}
#Preview {
    FeedView(viewModel: FeedViewModel(provider: FeedView_Previews()))
}
