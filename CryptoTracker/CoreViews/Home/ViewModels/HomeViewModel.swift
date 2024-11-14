//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import Foundation
import SwiftUI

/// a View Model that is associated with HomeView.
///
/// This model retrieves coins from CoinGecko api and sets allCoins property. allCoins property is used by HomeView to display a list of Coins, along with each of these coin's info, such their current price, 24 price percentage change, and so forth...
@MainActor
@Observable
class HomeViewModel {
    var allCoins: [CoinModel]
    var filteredCoins: [CoinModel]
    var portfolioCoins: [CoinModel]
    //TODO: fetch market stats from the internet
    var allMarketStats: [MarketStatistic] = []//MarketStatistic.previewListOfMarketStats
    
    //@ObservationIgnored let networkManager = NetworkManager.shared
    var isDownloading: Bool
    var searchText: String = ""
    private let marketDataService = MarketDataService(url: URL(string: "https://api.coingecko.com/api/v3/global")!)
    
    
    init(allCoins: [CoinModel], portfolioCoins: [CoinModel]) {
        self.allCoins = allCoins
        self.filteredCoins = []
        self.portfolioCoins = portfolioCoins
        self.isDownloading = true
        Task {
            async let coinsTask: Void = getCoins()//perhaps add async let so fetching happens parallell to market stats as well
            async let marketData: Void = getMarketData()
            await coinsTask
            await marketData
        }
    }
    
     func filterCoins() {
        guard !searchText.isEmpty else {
            self.filteredCoins = allCoins
            return
        }
        let searchCoinText = searchText.lowercased()
        let filteredCoins = allCoins.filter { coinModel in
            let coinModel_idName = coinModel.id.lowercased()
            let coinModelName = coinModel.name.lowercased()
            let coinModelSymbol = coinModel.symbol.lowercased()
            return (coinModel_idName.contains(searchCoinText) ||
                    coinModelName.contains(searchCoinText)    ||
                    coinModelSymbol.contains(searchCoinText)
            )
        }
        self.filteredCoins = filteredCoins
    }
    
    /// this method uses a NetworkManager to get all the coins, and then sets the allCoins observable property
    private func getCoins() async {
        do {
            print("DEBUG: netowrk call")
            let coins = try await NetworkManager().getCoins()
            self.allCoins = coins
            self.filteredCoins = coins
            self.isDownloading = false
        } catch  {
            print(error.localizedDescription)
            self.isDownloading = false
        }
    }
    
    private func getMarketData() async {
        do {
            let marketData = try await marketDataService.getMarketData()
            
            let marketCap = MarketStatistic(title: "Market Cap", value: marketData.marketCap, percentageChange: marketData.marketCapPercentageChange24H)
            let volume = MarketStatistic(title: "24h Volume", value: marketData.totalVolumeInUSD)
            let btcDominance = MarketStatistic(title: "BTC Dominance", value: marketData.btcDominance)
            let portfolio = MarketStatistic(title: "Portfolio Value", value: "$0.00", percentageChange: 1)
            allMarketStats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portfolio
            ])
        }
        catch {
            print(error.localizedDescription)
            
        }
    }
    
}

#if DEBUG
extension HomeViewModel {
    static let previewHomeViewModel = HomeViewModel(allCoins: [.previewCoin, .previewCoin], portfolioCoins: [.previewCoin])
}
#endif
