//
//  FavoriteArticleViewModel.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 13/01/22.
//

import Foundation

@MainActor
class FavoriteArticleViewModel: ObservableObject {
    
    @Published private(set) var favoriteArticles: [Article] = []
    private let favoriteArticlesDataStorage = PlistDataStorage<[Article]>(filename: "favoriteArticles")
    
    init() {
        Task {
            await loadFavoriteArticlesFromDataStorage()
        }
    }
    
    func isFavorited(for article: Article) -> Bool {
        favoriteArticles.first { article.id == $0.id } != nil
    }
    
    func addAsFavorite(for article: Article) {
        guard !isFavorited(for: article) else {
            return
        }

        favoriteArticles.insert(article, at: 0)
        updateFavoriteArticlesDataStorage()
    }
    
    func removeFromFavorite(for article: Article) {
        guard let index = favoriteArticles.firstIndex(where: {
            $0.id == article.id
        }) else {
            return
        }
        favoriteArticles.remove(at: index)
        updateFavoriteArticlesDataStorage()
    }
    
    // MARK: - Data storage related functions
    private func updateFavoriteArticlesDataStorage() {
        let favoriteArticles = self.favoriteArticles
        Task {
            await favoriteArticlesDataStorage.save(favoriteArticles)
        }
    }
    
    private func loadFavoriteArticlesFromDataStorage() async {
        favoriteArticles = await favoriteArticlesDataStorage.load() ?? []
    }
    
}
