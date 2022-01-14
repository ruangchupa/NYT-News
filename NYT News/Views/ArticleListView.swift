//
//  ArticleListView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI

struct ArticleListView: View {
    @Environment(\.deepLink) var deepLink
    @State private var isShowingDetailView = false
    @State private var articleURL: String = ""
    
    let articles: [Article]
    
    var body: some View {
        ZStack {
            NavigationLink("",
                           destination: ArticleDetailView(articleStringURL: articleURL,
                                                          articles: nil,
                                                          fromDeepLink: true),
                           isActive: $isShowingDetailView)
                .opacity(0.0)
                .disabled(true)
                .frame(width: 0.0, height: 0.0)
                .clipped()
            List {
                ForEach(0..<articles.count, id: \.self) { index in
                        ArticleRowView(article: articles[index])
                            .background(
                                NavigationLink("", destination: ArticleDetailView(
                                    articleStringURL: articles[index].url, page: .withIndex(index),
                                    articles: articles))
                                        .opacity(0))
                }
                .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 16.0, trailing: 0.0))
            }
            .listStyle(.plain)
        }
        .onChange(of: deepLink, perform: { deepLink in
                    guard let deepLink = deepLink else { return }
                    switch deepLink {
                    case .details(let articleURL):
                        self.articleURL = articleURL
                        isShowingDetailView = true
                    case .home:
                        break
                    }
                })
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
    }
}
