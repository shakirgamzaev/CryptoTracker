//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @State private var homeViewModel = HomeViewModel(allCoins: [], portfolioCoins: [])
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(homeViewModel)
        }
    }
}
