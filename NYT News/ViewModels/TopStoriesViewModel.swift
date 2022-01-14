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
    
    @Published var phase = DataFetchStatus<[Article]>.fetching
    @Published var fetchTaskToken: ArticleListFetchTaskToken
    @Published var noInternetConnection = false
    
    private let nytAPI = NYTAPI()
    
    init(articles: [Article]? = nil, selectedSection: Section = .home) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .fetching
        }
        
        self.fetchTaskToken = ArticleListFetchTaskToken(section: selectedSection, token: Date())
    }
    
    func loadArticles() async {
        if Task.isCancelled { return }
        phase = .fetching
        do {
            let articles = try await nytAPI.fetchTopStories(from: fetchTaskToken.section)
            if Task.isCancelled { return }
            phase = .success(articles)
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
}
