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
    @State private var showEditPortfolioView = false
    
    
    var body: some View {
        @Bindable var homeViewVM = homeScreenVM
        ZStack {
            Color.backgroundTheme
            VStack {
                HomeViewHeader(showPortfolio: $showPortfolio, showEditPortfolio: $showEditPortfolioView)
                    .padding(.horizontal, 18)
                
                MarketStatsRowView(marketStats: homeScreenVM.allMarketStats, showPortfolio: $showPortfolio)
                
                SearchFieldView(searchText: $homeViewVM.searchText)
                    .safeAreaPadding(.top, 20)
                    .safeAreaPadding(.bottom, 4)
                    .padding(.horizontal)
                    .onChange(of: homeViewVM.searchText) {
                        Task {
                            await homeViewVM.filterAndSortCoins(searchText: homeViewVM.searchText)
                        }
                    }
                
                HomeViewHeaderTitles(showPortfolio: showPortfolio)
                
                Group {
                    if !showPortfolio {
                        ListOfAllCoinsView(allCoins: homeScreenVM.filteredCoins)
                            .transition(.move(edge: .leading))
                    }
                    else {
                        ListOfPortfolioCoins()
                            .transition(.move(edge: .trailing))
                    }
                }
                .sheet(isPresented: $showEditPortfolioView) {
                    // PortfolioEditView    
                    PortfolioEditView()
                }
            }
            .navigationDestination(for: CoinModel.self) { coin in
                CoinDetailView(coin: coin)
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


