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
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(favoriteArticleVM)
                .environmentObject(networkMonitorVM)
        }
    }
    
}
