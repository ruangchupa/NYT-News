//
//  ArticleDetailContentView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import SwiftUI
import SwiftUIPager

struct ArticleDetailContentView: View {
    @StateObject var page: Page
    @Binding var articleStringURL: String
    var fromDeepLink: Bool
    let articles: [Article]?
    
    var body: some View {
        if fromDeepLink {
            if let articleURL = URL(string: articleStringURL) {
                SafariView(url: articleURL)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                EmptyView()
            }
        } else if let articles = articles {
            Pager(page: page,
                  data: articles,
                  id: \.id,
                  content: { article in
                if let articleURL = article.articleURL {
                    SafariView(url: articleURL)
                }
             })
                .onPageChanged({ index in
                    articleStringURL = articles[index].url
                })
                .sensitivity(.high)
        } else {
            EmptyView()
        }
    }
}
