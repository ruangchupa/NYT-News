//
//  ArticleRowView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            WebImage(url: article.articleMultimediaURL)
                .resizable()
                .placeholder{
                    Image(systemName: "photo")
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: 300,
                            alignment: .center
                          )
                }
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(height: 300, alignment: .center)
                .clipped()
                .background(Color.gray.opacity(0.4))
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                Text(article.abstract)
                    .font(.subheadline)
                    .lineLimit(3)
                Text(article.relativePublicationTime)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(.init(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ArticleRowView(article: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
    }
}
