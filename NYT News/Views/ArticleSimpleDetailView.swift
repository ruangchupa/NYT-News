//
//  ArticleSimpleDetailView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 14/01/22.
//

import SwiftUI

struct ArticleSimpleDetailView: View {
    let articleURL: URL?
    var body: some View {
        if let articleURL = self.articleURL {
            SafariView(url: articleURL)
                .edgesIgnoringSafeArea(.bottom)
        } else {
            EmptyView()
        }
    }
}

struct ArticleSimpleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleSimpleDetailView(articleURL: URL(string: Article.previewData[0].url)!)
    }
}
