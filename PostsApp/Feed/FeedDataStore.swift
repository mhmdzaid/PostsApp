//
//  FeedDataStore.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 21/09/2025.
//

import Foundation
import CoreData
import FeedFeature
protocol FeedCacheProtocol {
    func saveArticles(models: [ArticleModel])
    func fetchArticles() -> [ArticleModel]
    func deleteAllArticles()
}
class FeedDataStore: FeedCacheProtocol {
    static let shared = FeedDataStore()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Feed")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data stack failed: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Multiple Articles
    // deleting all articles before saving some ,
    // will achieve last fethced page will show for offline mode
    func saveArticles(models: [ArticleModel]) {
        deleteAllArticles()
        for model in models {
            let article = Article(context: context)
            article.author = model.author ?? ""
            article.title = model.title ?? ""
            article.desc = model.description
            article.url = model.url ?? ""
            article.urlToImage = model.urlToImage ?? ""
            article.publishedAt = model.publishedAt ?? ""
            article.content = model.content ?? ""
        }
        try? context.save()
    }
    
    // MARK: - Fetch Articles
    func fetchArticles() -> [ArticleModel] {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        let fetchedArticles = (try? context.fetch(request)) ?? []
        return fetchedArticles.map({ return ArticleModel(source: nil,
                                                         author: $0.author,
                                                         title: $0.title,
                                                         description: $0.desc,
                                                         url: $0.url,
                                                         urlToImage: $0.urlToImage,
                                                         publishedAt: $0.publishedAt,
                                                         content: $0.content)})
    }
    
    // MARK: - Delete All Articles
    func deleteAllArticles() {
        let request: NSFetchRequest<NSFetchRequestResult> = Article.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try? context.execute(deleteRequest)
        try? context.save()
    }
}
