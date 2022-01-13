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
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(favoriteArticleVM)
        }
    }
    
}
