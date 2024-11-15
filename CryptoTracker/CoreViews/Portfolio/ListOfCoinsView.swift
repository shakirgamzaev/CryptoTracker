//
//  ListOfCoinsView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 15/11/24.
//

import SwiftUI

struct ListOfCoinsView: View {
    @Bindable var portfolioVM: PortfolioScreenVM
    @Environment(HomeViewModel.self) private var homeScreenVM
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0.0) {
                ForEach(homeScreenVM.filteredCoins) { coin in
                    CoinView(coin: coin, portofolioVM: portfolioVM)
                        .containerRelativeFrame(.horizontal, count: 4, spacing: 0)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            portfolioVM.selectedCoin = coin
                        }
                }
            }
            .frame(height: portfolioVM.sizeCoinView.height + 10)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    ListOfCoinsView(portfolioVM: PortfolioScreenVM())
}
