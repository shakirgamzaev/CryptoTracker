//
//  HomeView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio = false
    @Environment(HomeViewModel.self) private var homeScreenVM
    
    var body: some View {
        ZStack {
            Color.backgroundTheme
            VStack {
                HomeViewHeader(showPortfolio: $showPortfolio)
                    .padding(.horizontal, 18)
                
                HomeViewHeaderTitles(showPortfolio: showPortfolio)
            
                if !showPortfolio {
                    ListOfAllCoinsView(allCoins: homeScreenVM.allCoins)
                        .transition(.move(edge: .leading))
                }
                else {
                    ListOfPortfolioCoins()
                        .transition(.move(edge: .trailing))
                }
                
            }
        }
        
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    NavigationStack {
        HomeView()
            .navigationTitle("hi")
            .toolbarVisibility(.hidden, for: .navigationBar)
    }
}


