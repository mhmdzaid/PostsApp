//
//  FeedDetailsView.swift
//  FeedFeature
//
//  Created by Mohamed Elmalhey on 16/09/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedDetailsView: View {
    var article: ArticleModel?
    var body: some View {
        VStack(alignment: .leading){
            WebImage(url: URL(string: article?.urlToImage ?? ""), options: .fromCacheOnly)
                .resizable()
                .frame(height: UIScreen.main.bounds.height/2.5)
            Text(article?.title ?? "")
                .font(.title)
                .truncationMode(.tail)
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 10, trailing: 15))
            Text(article?.description ?? "")
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
            Spacer()
        }
    }
}

#Preview {
    FeedDetailsView(article: ArticleModel(source: Source(id: "123", name: "Wallmart"),
                                     author: "John doe",
                                     title: "Just preview",
                                     description: "this is a description for preview only... ",
                                     url: "https://www.globenewswire.com/news-release/2025/09/06/3145598/0/en/LINE-LAWSUIT-NOTICE-Lose-Money-on-Lineage-Inc-Contact-BFA-Law-Prior-to-September-30-Legal-Deadline-NASDAQ-LINE.html",
                                     urlToImage: "https://ml.globenewswire.com/Resource/Download/44a256cf-d470-4d8a-af6b-dbb1b5bbb11e",
                                     publishedAt: "2025-09-06T11:18:00Z",
                                     content: "NEW YORK, Sept. 06, 2025 (GLOBE NEWSWIRE) -- Leading securities law firm Bleichmar Fonti &amp; Auld LLP announces that a lawsuit has been filed against Lineage, Inc. (NASDAQ: LINE) and certain of the… [+3689 chars]"))
}
