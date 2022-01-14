//
//  FavoriteArticleViewModel.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 13/01/22.
//

import Foundation

@MainActor
class FavoriteArticleViewModel: ObservableObject {
    
    @Published private(set) var favoriteArticles: [String] = []
    private let favoriteArticlesDataStorage = PlistDataStorage<[String]>(filename: "favoriteArticles")
    
    init() {
        Task {
            await loadFavoriteArticlesFromDataStorage()
        }
    }
    
    func isFavorited(forArticleWithStringURL stringURL: String) -> Bool {
        favoriteArticles.first { stringURL == $0 } != nil
    }
    
    func addAsFavorite(forArticleWithStringURL stringURL: String) {
        guard !isFavorited(forArticleWithStringURL: stringURL) else {
            return
        }

        favoriteArticles.insert(stringURL, at: 0)
        updateFavoriteArticlesDataStorage()
    }
    
    func removeFromFavorite(forArticleWithStringURL stringURL: String) {
        guard let index = favoriteArticles.firstIndex(where: {
            $0 == stringURL
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
