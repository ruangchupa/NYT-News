//
//  ArticleDetailView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI
import SwiftUIPager

struct ArticleDetailView: View {
    @EnvironmentObject var favoriteArticleVM: FavoriteArticleViewModel
    @StateObject var page: Page = .first()
    @State var article: Article
    
    let articles: [Article]
    
    var body: some View {
        Pager(page: page,
              data: articles,
              id: \.id,
              content: { article in
            if let articleURL = article.articleURL {
                SafariView(url: articleURL)
            }
         })
            .onPageChanged({ index in
                article = articles[index]
            })
            .sensitivity(.high)
            .toolbar {
                HStack(spacing: 16.0) {
                    Button {
                        toggleFavorite(for: article)
                    } label: {
                        Image(systemName: favoriteArticleVM.isFavorited(for: article) ? "star.fill" : "star")
                    }
                    Button {
                        print("Share tapped!")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
    }
    
    private func toggleFavorite(for article: Article) {
        if favoriteArticleVM.isFavorited(for: article) {
            favoriteArticleVM.removeFromFavorite(for: article)
        } else {
            favoriteArticleVM.addAsFavorite(for: article)
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleDetailView(article: Article.previewData[0], articles: Article.previewData)
        }
    }
}
