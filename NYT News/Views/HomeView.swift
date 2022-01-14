//
//  HomeView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @EnvironmentObject var networkMonitorVM: NetworkMonitorViewModel
    @Environment(\.deepLink) var deepLink
    @StateObject var topStoriesVM = TopStoriesViewModel()
    @State var noConnectionAlertIsShowing = false
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: topStoriesVM.articles)
                .overlay(overlayView)
                .task(id: topStoriesVM.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .navigationTitle(topStoriesVM.fetchTaskToken.section.sectionName)
                .navigationBarItems(trailing: menu)
        }
        .alert("Network Error",
               isPresented: $noConnectionAlertIsShowing,
               actions: {
            Button("Retry", role: .cancel, action: refreshTask)
        },
               message: {
                Text("Unable to contact the server")
            })
        .onChange(of: networkMonitorVM.status) { _ in
            checkNetworkConnectionForAlert()
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch topStoriesVM.phase {
        case .fetching:
            FetchingView()
        case .success:
            if (topStoriesVM.articles.isEmpty) {
                NoDataView(text: "No News Found", image: Image(systemName: "newspaper"))
            } else {
                EmptyView()
            }
        case .failure(let error):
            FailureView(text: error.localizedDescription, retryAction: refreshTask)
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
        await topStoriesVM.loadArticlesFromWebService()
    }
    
    @Sendable
    private func refreshTask() {
        DispatchQueue.main.async {
            checkNetworkConnectionForAlert()
            topStoriesVM.fetchTaskToken = ArticleListFetchTaskToken(section: topStoriesVM.fetchTaskToken.section, token: Date())
        }
    }
    
    private func checkNetworkConnectionForAlert() {
        if (networkMonitorVM.status == .disconnected) {
            noConnectionAlertIsShowing = true
        } else {
            noConnectionAlertIsShowing = false
        }
    }

}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
