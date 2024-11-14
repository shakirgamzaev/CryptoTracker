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
        @Bindable var homeViewVM = homeScreenVM
        ZStack {
            Color.backgroundTheme
            VStack {
                HomeViewHeader(showPortfolio: $showPortfolio)
                    .padding(.horizontal, 18)
                
                MarketStatsRowView(marketStats: homeScreenVM.allMarketStats, showPortfolio: $showPortfolio)
                
                SearchFieldView(searchText: $homeViewVM.searchText)
                    .safeAreaPadding(.top, 20)
                    .safeAreaPadding(.bottom, 4)
                    .padding(.horizontal)
                    .onChange(of: homeViewVM.searchText) {homeViewVM.filterCoins()}
                
                HomeViewHeaderTitles(showPortfolio: showPortfolio)
                
                if !showPortfolio {
                    ListOfAllCoinsView(allCoins: homeScreenVM.filteredCoins)
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


