//
//  HomeView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @StateObject var topStoriesVM = TopStoriesViewModel()
    
    private var articles: [Article] {
        if case let .success(articles) = topStoriesVM.phase {
            return articles
        } else {
            return []
        }
    }
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: topStoriesVM.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .navigationTitle(topStoriesVM.fetchTaskToken.section.sectionName)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch topStoriesVM.phase {
        case .fetching:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            NoDataView(text: "There's no article available", image: nil)
        case .failure(let error):
            FailureView(text: error.localizedDescription, retryAction: refreshTask)
        default: EmptyView()
        }
    }
    
    private var menu: some View {
        Menu {
            Picker("Section", selection: $topStoriesVM.fetchTaskToken.section) {
                ForEach(Section.allCases) {
                    Text($0.sectionName).tag($0)
                }
            }
        } label: {
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .foregroundColor(.black)
        }
    }
    
    @Sendable
    private func loadTask() async {
        await topStoriesVM.loadArticles()
    }
    
    @Sendable
    private func refreshTask() {
        DispatchQueue.main.async {
            topStoriesVM.fetchTaskToken = ArticleListFetchTaskToken(section: topStoriesVM.fetchTaskToken.section, token: Date())
        }
    }

}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
