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
    @State private var dismissLaunchScreen = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .environment(homeViewModel)
                if !dismissLaunchScreen {
                    LaunchScreenView(dismissLauncScreen: $dismissLaunchScreen)
                }
            }
        }
    }
}
