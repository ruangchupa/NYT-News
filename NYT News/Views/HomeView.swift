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
            return Article.previewData
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
            VStack(alignment: .center, spacing: 16.0) {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                Text("Please wait").foregroundColor(.white)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(.black)
            .opacity(0.8)
            .alert("Network Error",
                   isPresented: $topStoriesVM.noInternetConnection,
                   actions: {
                Button("Retry", role: .cancel, action: refreshTask)
            },
                   message: {
                    Text("Unable to contact the server")
                })
        case .success(let articles) where articles.isEmpty:
            NoDataView(text: "No News Found", image: Image(systemName: "newspaper"))
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
