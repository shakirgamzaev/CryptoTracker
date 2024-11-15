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
    private let marketDataService: MarketDataService
    
    
    init(allCoins: [CoinModel], portfolioCoins: [CoinModel], isPreview: Bool = false) {
        self.allCoins = allCoins
        self.filteredCoins = []
        self.portfolioCoins = portfolioCoins
        self.isDownloading = true
        if isPreview == false {
            print("DEBUG(HomeViewModel:36): init HomeViewModel main called")
            self.marketDataService = MarketDataService(url: URL(string: "https://api.coingecko.com/api/v3/global")!)
            Task {
                async let coinsTask: Void = getCoins()//perhaps add async let so fetching happens parallell to market stats as well
                async let marketData: Void = getMarketData()
                await coinsTask
                await marketData
            }
        }
        else {
            print("DEBUG(HomeViewModel:36): preview part called")
            self.marketDataService = MarketDataService(url: URL(string: "https://api.coingecko.com/api/v3/global")!, true)
            self.filteredCoins = allCoins
            self.allMarketStats = MarketStatistic.previewListOfMarketStats
            self.isDownloading = false
        }
    }
    
    func filteredCoins() async {
        guard !searchText.isEmpty else {
            self.filteredCoins = allCoins
            return
        }
        let searchCoinText = searchText.lowercased()
        self.filteredCoins = await getFilteredCoins(allCoins: allCoins, searchText: searchCoinText)
    }
    
    nonisolated private func getFilteredCoins(allCoins: [CoinModel],searchText: String) async -> [CoinModel] {
        let filteredCoins = allCoins.filter { coinModel in
            let coinModel_idName = coinModel.id.lowercased()
            let coinModelName = coinModel.name.lowercased()
            let coinModelSymbol = coinModel.symbol.lowercased()
            return (coinModel_idName.contains(searchText) ||
                    coinModelName.contains(searchText)    ||
                    coinModelSymbol.contains(searchText)
            )
        }
        return filteredCoins
    }
    
    
    /// this method uses a NetworkManager to get all the coins, and then sets the allCoins observable property
    private func getCoins() async {
        do {
            print("DEBUG: getCoins call")
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
    static let previewHomeViewModel = HomeViewModel(
        allCoins: [
            .previewCoin,
            .previewCoin,
            .previewCoin2,
            .previewCoin2,
            .previewCoin,
            .previewCoin,
            .previewCoin2,
            .previewCoin2,
            .previewCoin,
            .previewCoin,
            .previewCoin2,
            .previewCoin2
        ],
        portfolioCoins: [.previewCoin, .previewCoin2],
        isPreview: true
    )
}
#endif
