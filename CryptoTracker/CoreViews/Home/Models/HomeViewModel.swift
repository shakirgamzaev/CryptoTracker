//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class HomeViewModel {
    var allCoins: [CoinModel]
    var portfolioCoins: [CoinModel]
    let networkManager = NetworkManager.shared
    
    init(allCoins: [CoinModel], portfolioCoins: [CoinModel]) {
        self.allCoins = allCoins
        self.portfolioCoins = portfolioCoins
        Task {
            await getCoins()
        }
    }
    
    /// this method uses a NetworkManager to get all the coins, and then sets the allCoins observable property
    private func getCoins() async {
        do {
            print("DEBUG: netowrk call")
            let coins = try await networkManager.getCoins()
            allCoins = coins
        } catch  {
            print(error.localizedDescription)
        }
    }
}

#if DEBUG
extension HomeViewModel {
    static let previewHomeViewModel = HomeViewModel(allCoins: [.previewCoin, .previewCoin], portfolioCoins: [.previewCoin])
}
#endif
