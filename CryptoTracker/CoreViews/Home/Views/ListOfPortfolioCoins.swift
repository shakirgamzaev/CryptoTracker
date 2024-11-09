//
//  ListOfPortfolioCoins.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import SwiftUI

///This view presents a list of Coins that a user adds to his portfolio
struct ListOfPortfolioCoins: View {
    @Environment(HomeViewModel.self) private var homeScreenVM
    
    var body: some View {
        List {
            ForEach(homeScreenVM.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
            }
            .listRowInsets(.init(top: 15, leading: 10, bottom: 10, trailing: 15))
        }
        .safeAreaPadding(.top, 10)
        .listStyle(.plain)
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    ListOfPortfolioCoins()
}
