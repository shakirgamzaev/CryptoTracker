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
    @Environment(HomeViewModel.self) private var homeScreenVM
    
    var body: some View {
        Group {
            if !homeScreenVM.isDownloading {
                List {
                    ForEach(allCoins) { coin in
                        NavigationLink(value: coin) {
                            CoinRowView(coin: coin, showHoldingsColumn: false)
                        }
                    }
                    .listRowInsets(.init(top: 15, leading: 10, bottom: 10, trailing: 15))
                    
                }
                .safeAreaPadding(.top, 10)
                .listStyle(.plain)
            }
            else {
                ProgressView()
                    .scaleEffect(1.9)
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    NavigationStack {
        ListOfAllCoinsView(allCoins: HomeViewModel.previewHomeViewModel.allCoins)
    }
}
