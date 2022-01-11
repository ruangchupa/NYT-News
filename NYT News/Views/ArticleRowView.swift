//
//  ArticleRowView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            AsyncImage(url: article.articleMultimediaURL) { phase in
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                        Spacer()
                    }
                    
                
                @unknown default:
                    fatalError()
                }
            }
            .frame(height: 300)
            .background(Color.gray)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(article.title)
                    .font(.headline)
                Text(article.abstract)
                Text(article.relativePublicationTime)
                    .font(.caption)
            }
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleRowView(article: .previewData[0])
    }
}
