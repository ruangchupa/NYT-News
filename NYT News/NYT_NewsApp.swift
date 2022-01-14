//
//  NYT_NewsApp.swift
//  NYT News
//
//  Created by Muhammad Yusuf  on 12/01/22.
//

import SwiftUI

@main
struct NYT_NewsApp: App {
    
    @StateObject var favoriteArticleVM = FavoriteArticleViewModel()
    @StateObject var networkMonitorVM = NetworkMonitorViewModel()
    @State var deepLink: DeepLinkManager.DeepLink?

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.deepLink, deepLink)
                .environmentObject(favoriteArticleVM)
                .environmentObject(networkMonitorVM)
                .onOpenURL { url in
                    let deepLinkManager = DeepLinkManager()
                    guard let deepLink = deepLinkManager.manage(url: url) else { return }
                    self.deepLink = deepLink
                    
                    // Reset the deeplink after being used.
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                            self.deepLink = nil
                    }
                }
        }
    }
    
}
