//
//  ArticleListView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
            }
            .listRowInsets(.init(top: 0.0, leading: 0.0, bottom: 16.0, trailing: 0.0))
        }
        .listStyle(.plain)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
    }
}
