//
//  ArticleDetailView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI
import SwiftUIPager

struct ArticleDetailView: View {
    @StateObject var page: Page = .first()
    
    let articles: [Article]
    
    var body: some View {
        Pager(page: page,
              data: articles,
              id: \.id,
              content: { index in
                  // create a page based on the data passed
            if let articleURL = index.articleURL {
                SafariView(url: articleURL)
            }
         })
            .sensitivity(.high)
        
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleDetailView(articles: Article.previewData)
        }
    }
}
