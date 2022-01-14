//
//  ArticleDetailView.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI
import SwiftUIPager

struct ArticleDetailView: View {
    @EnvironmentObject var favoriteArticleVM: FavoriteArticleViewModel
    @EnvironmentObject var networkMonitorVM: NetworkMonitorViewModel
    @State var noConnectionAlertIsShowing = false
    @State var articleStringURL: String
    var page: Page = .first()
    let articles: [Article]?
    var fromDeepLink = false
    
    var body: some View {
        ArticleDetailContentView(page: page, articleStringURL: $articleStringURL, fromDeepLink: fromDeepLink, articles: articles)
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                HStack(spacing: 16.0) {
                    Button {
                        toggleFavorite(forArticleWithStringURL: articleStringURL)
                    } label: {
                        Image(systemName: favoriteArticleVM.isFavorited(forArticleWithStringURL: articleStringURL) ? "star.fill" : "star")
                    }
                    Button {
                        print("Share tapped!")
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .alert("Network Error",
                   isPresented: $noConnectionAlertIsShowing,
                   actions: {
                Button("OK", role: .cancel, action: {})
            },
                   message: {
                    Text("Unable to contact the server")
                })
            .onChange(of: networkMonitorVM.status) { _ in
                checkNetworkConnectionForAlert()
//        if fromDeepLink {
//            if let articleURL = URL(string: articleStringURL) {
//                SafariView(url: articleURL)
//                    .edgesIgnoringSafeArea(.bottom)
//            } else {
//                EmptyView()
//            }
//        } else {
//            Pager(page: page,
//                  data: articles,
//                  id: \.id,
//                  content: { article in
//                if let articleURL = article.articleURL {
//                    SafariView(url: articleURL)
//                }
//             })
//                .onPageChanged({ index in
//                    articleStringURL = articles[index].url
//                })
//                .sensitivity(.high)
//                .edgesIgnoringSafeArea(.bottom)
//                .toolbar {
//                    HStack(spacing: 16.0) {
//                        Button {
//                            toggleFavorite(forArticleWithStringURL: articleStringURL)
//                        } label: {
//                            Image(systemName: favoriteArticleVM.isFavorited(forArticleWithStringURL: articleStringURL) ? "star.fill" : "star")
//                        }
//                        Button {
//                            print("Share tapped!")
//                        } label: {
//                            Image(systemName: "square.and.arrow.up")
//                        }
//                    }
//                }
//                .alert("Network Error",
//                       isPresented: $noConnectionAlertIsShowing,
//                       actions: {
//                    Button("OK", role: .cancel, action: {})
//                },
//                       message: {
//                        Text("Unable to contact the server")
//                    })
//                .onChange(of: networkMonitorVM.status) { _ in
//                    checkNetworkConnectionForAlert()
//            }
        }
    }
    
    private func toggleFavorite(forArticleWithStringURL stringURL: String) {
        if favoriteArticleVM.isFavorited(forArticleWithStringURL: stringURL) {
            favoriteArticleVM.removeFromFavorite(forArticleWithStringURL: stringURL)
        } else {
            favoriteArticleVM.addAsFavorite(forArticleWithStringURL: stringURL)
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

struct ArticleDetailView_Previews: PreviewProvider {
    @StateObject static var favoriteArticleVM = FavoriteArticleViewModel()
    
    static var previews: some View {
        NavigationView {
            ArticleDetailView(articleStringURL: Article.previewData[0].url, articles: Article.previewData)
                .environmentObject(favoriteArticleVM)
        }
    }
}
