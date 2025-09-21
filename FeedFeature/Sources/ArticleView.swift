//
//  ArticleView.swift
//  FeedFeature
//
//  Created by Mohamed Elmalhey on 06/09/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleView: View {
    var post: ArticleModel!
    var body: some View {
        HStack {
            WebImage(url: URL(string: post.urlToImage ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 2)
            
            Text(post.title ?? "").truncationMode(.tail)
        }
    }
}

#Preview {
    ArticleView(post: ArticleModel(source: Source(id: "123", name: "Wallmart"),
                           author: "John doe",
                           title: "Just preview",
                           description: "this is a description for preview only... ",
                           url: "https://www.globenewswire.com/news-release/2025/09/06/3145598/0/en/LINE-LAWSUIT-NOTICE-Lose-Money-on-Lineage-Inc-Contact-BFA-Law-Prior-to-September-30-Legal-Deadline-NASDAQ-LINE.html",
                           urlToImage: "https://ml.globenewswire.com/Resource/Download/44a256cf-d470-4d8a-af6b-dbb1b5bbb11e",
                           publishedAt: "2025-09-06T11:18:00Z",
                           content: "NEW YORK, Sept. 06, 2025 (GLOBE NEWSWIRE) -- Leading securities law firm Bleichmar Fonti &amp; Auld LLP announces that a lawsuit has been filed against Lineage, Inc. (NASDAQ: LINE) and certain of the… [+3689 chars]"))
}
