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
    var portfolioCoins: [CoinModel] /*{
        didSet {
            Task {
                await self.getMarketData()
            }
        }
    }*/
    //TODO: fetch market stats from the internet
    var allMarketStats: [MarketStatistic] = []//MarketStatistic.previewListOfMarketStats
    var isDownloading: Bool
    var searchText: String = ""
    @ObservationIgnored private var portfolioService: PersistentCoinService
    private var marketDataService: MarketDataService
    var sortOption: SortOption = .rank {
        didSet {
            Task {
                await filterAndSortCoins(searchText: self.searchText)
            }
            Task {
                self.portfolioCoins = await sortPortfolioCoins(coins: portfolioCoins)
            }
        }
    }
    
    init(allCoins: [CoinModel], portfolioCoins: [CoinModel], isPreview: Bool = false) {
        self.allCoins = allCoins
        self.filteredCoins = []
        self.portfolioCoins = portfolioCoins
        self.isDownloading = true
        if isPreview == false {
            self.portfolioService = PersistentCoinService(false)
            print("DEBUG(HomeViewModel:36): init HomeViewModel main called")
            self.marketDataService = MarketDataService(url: URL(string: "https://api.coingecko.com/api/v3/global")!)
//            Task {
//                async let coinsTask: Void = getCoins()//perhaps add async let so fetching happens parallell to market stats as well
//                async let marketData: Void = getMarketData()
//                await coinsTask
//                await marketData
//                fetchPortfolioCoins()
//            }
        }
        else {
            self.portfolioService = PersistentCoinService(true)
            print("DEBUG(HomeViewModel:36): preview part called")
            self.marketDataService = MarketDataService(url: URL(string: "https://api.coingecko.com/api/v3/global")!, true)
            self.filteredCoins = allCoins
            self.allMarketStats = MarketStatistic.previewListOfMarketStats
            self.isDownloading = false
            fetchPortfolioCoins()
        }
    }
    
    func filterAndSortCoins(searchText: String) async {
        var filteredCoins = await getFilteredCoins(allCoins: allCoins, searchText: searchText)
        sortCoins(by: self.sortOption, coins: &filteredCoins)
        self.filteredCoins = filteredCoins
    }
    
    private func sortPortfolioCoins(coins: [CoinModel]) async -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted {$0.currentHoldingsAmmount < $1.currentHoldingsAmmount}
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsAmmount > $1.currentHoldingsAmmount})
        default:
            return coins
        }
    }
    
    private func sortCoins(by sortOption: SortOption, coins: inout [CoinModel]) {
        switch sortOption {
        case .holdings, .rank:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    
    nonisolated private func getFilteredCoins(allCoins: [CoinModel], searchText: String) async -> [CoinModel] {
        guard !searchText.isEmpty else {
            return allCoins
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
        return filteredCoins
    }
    
    /// fetch coins from swift data store. This calls the PersistenCoin model service.
    private func fetchPortfolioCoins() {
        let portfolioCoins = portfolioService.fetchPortfolioCoins()
        let coinModels = portfolioCoins.compactMap { portfolioCoin in
            let coin = allCoins.first(where: {$0.coinId == portfolioCoin.coinId})!
            return coin.updateHoldings(ammount: portfolioCoin.ammount)
        }
        self.portfolioCoins = coinModels
    }
    
    func updatePortfolio(coin: CoinModel, ammount: Double) {
        let _ = portfolioService.updatePortfolio(coin: coin, ammount: ammount)
        fetchPortfolioCoins()
    }
    
    /// this method uses a NetworkManager to get all the coins, and then sets the allCoins observable property
    func getCoins() async {
        do {
            print("DEBUG: getCoins call")
            self.isDownloading = true
            let coins = try await NetworkManager().getCoins()
            self.allCoins = coins
            self.filteredCoins = coins
            self.isDownloading = false
            fetchPortfolioCoins()
        } catch  {
            print(error.localizedDescription)
            self.isDownloading = false
        }
    }
    
    func getMarketData() async {
    do {
        let marketData = try await marketDataService.getMarketData()
        
        let marketCap = MarketStatistic(title: "Market Cap", value: marketData.marketCap, percentageChange: marketData.marketCapPercentageChange24H)
        let volume = MarketStatistic(title: "24h Volume", value: marketData.totalVolumeInUSD)
        let btcDominance = MarketStatistic(title: "BTC Dominance", value: marketData.btcDominance)
        
        let currentPortfolioValue = portfolioCoins.map({$0.currentHoldingsAmmount})
            .reduce(0.0) { partialResult, ammount in
                partialResult + ammount
            }
        let previousPortfolioValue = portfolioCoins.map { coin in
            let currentValue = coin.currentHoldingsAmmount
            let percentageChange = coin.pricePercentageChange24H ?? 0 / 100
            let previousValue = currentValue / (percentageChange + 1.0)
            return previousValue
        }
            .reduce(0.0) { partialResult, ammount in
                partialResult + ammount
            }
        
        let percentageChange = ((currentPortfolioValue - previousPortfolioValue) / previousPortfolioValue) * 100
        
        let portfolio = MarketStatistic(title: "Portfolio Value", value: currentPortfolioValue.currencyFormatted(), percentageChange: percentageChange)
        let marketDataStats = [marketCap, volume, btcDominance, portfolio]
        self.allMarketStats = marketDataStats
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

extension HomeViewModel {
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
}
