//
//  TopStoriesViewModel.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import Foundation

struct ArticleListFetchTaskToken: Equatable {
    var section: Section
    var token: Date
}

@MainActor
class TopStoriesViewModel: ObservableObject {
    
    @Published var phase = DataFetchStatus.fetching
    @Published var fetchTaskToken: ArticleListFetchTaskToken
    @Published var noInternetConnection = false
    @Published var articles: [Article] = []
    
    private let nytAPI = NYTAPI()
    private let cachedArticlesDataStorage: PlistDataStorage<[Article]>
    
    init(selectedSection: Section = .home) {
        
        self.phase = .fetching
        
        self.fetchTaskToken = ArticleListFetchTaskToken(section: selectedSection, token: Date())
        self.cachedArticlesDataStorage = PlistDataStorage<[Article]>(filename: "cachedArticles_\(selectedSection.rawValue)")
    }
    
    func loadArticlesFromWebService() async {
        if Task.isCancelled { return }
        self.articles = await loadCachedArticlesFromDataStorage()
        phase = .fetching
        do {
            let articles = try await nytAPI.fetchTopStories(from: fetchTaskToken.section)
            if Task.isCancelled { return }
            updateCachedArticleDataStorage(articles: articles)
            self.articles = articles
            phase = .success
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            switch error._code {
            case -1009:
                noInternetConnection = true
            default:
                phase = .failure(error)
            }
        }
    }
    
    // MARK: - Data storage / caching related functions
    private func updateCachedArticleDataStorage(articles: [Article]) {
        Task {
            await cachedArticlesDataStorage.save(articles)
        }
    }
    
    private func loadCachedArticlesFromDataStorage() async -> [Article] {
        return await cachedArticlesDataStorage.load() ?? []
        
    }
}
