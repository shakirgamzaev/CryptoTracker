//
//  ListOfAllCoinsView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import SwiftUI




/// This view presents a list of all Coins that are retrieved
struct ListOfAllCoinsView: View {
    let allCoins: [CoinModel]
    
    var body: some View {
        List {
            ForEach(allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
            }
            .listRowInsets(.init(top: 15, leading: 10, bottom: 10, trailing: 15))
        }
        .safeAreaPadding(.top, 10)
        .listStyle(.plain)
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    ListOfAllCoinsView(allCoins: HomeViewModel.previewHomeViewModel.allCoins)
}
