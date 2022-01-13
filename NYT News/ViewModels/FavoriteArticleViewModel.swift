//
//  FavoriteArticleViewModel.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 13/01/22.
//

import Foundation

@MainActor
class FavoriteArticleViewModel: ObservableObject {
    
    @Published private(set) var favorites: [Article] = []
    
    func isFavorited(for article: Article) -> Bool {
        favorites.first { article.id == $0.id } != nil
    }
    
    func addAsFavorite(for article: Article) {
        guard !isFavorited(for: article) else {
            return
        }

        favorites.insert(article, at: 0)
    }
    
    func removeFromFavorite(for article: Article) {
        guard let index = favorites.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        favorites.remove(at: index)
    }
}
