//
//  CoinDetailViewModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 21/11/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
@Observable
class CoinDetailViewModel {
    @ObservationIgnored private let networkManager = NetworkManager()
    @ObservationIgnored let coin: CoinModel
    var coinDetail: CoinDetailModel? = nil {
        didSet {
            updateStatisticsArrays()
        }
    }
    var overViewStatistics: [MarketStatistic] = []
    var additionalStatistics: [MarketStatistic] = []
    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()
    
    var description: String {
        return coinDetail?.coinDescription?.en ?? "no description"
    }
    
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    ///retrieve specific coin's detail data from the following Coin Gecko URL: https://api.coingecko.com/api/v3/coins/{coinId}
    func getCoinDetails() {
        Task {
            do {
                let coinJSONData = try await networkManager.getResource(from: URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.coinId)")!)
                self.coinDetail = try decodeCoinData(fromJSONData: coinJSONData)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    /*
     struct MarketStatistic: Identifiable {
         let title: String
         let value: String
         let percentageChange: Double?
     }
     */
    private func updateStatisticsArrays() {
        if let coinDetail = self.coinDetail {
            let price = coin.currentPrice.currencyFormatted()
            let pricePercentChangeIn24H = coin.pricePercentageChange24H
            let priceStats = MarketStatistic(title: "Current Price", value: price, percentageChange: pricePercentChangeIn24H)
            
            let marketCap =  (coin.marketCap?.formattedWithAbbreviation() ?? "")
            let marketCapPercentChangeIn24h = coin.marketCapChangePercentage24H
            let marketCapStats = MarketStatistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentChangeIn24h)
            
            let rank = "\(coin.rank)"
            let rankStats = MarketStatistic(title: "Rank", value: rank)
            
            let volume = (coin.totalVolume ?? 0).formattedWithAbbreviation()
            let volumeStat = MarketStatistic(title: "Trading Volume", value: volume )
            let overviewStats = [priceStats, marketCapStats, rankStats, volumeStat]
            
            
            //Additional
            let high = coin.high24H?.formattedWithAbbreviation() ?? "n/a"
            let highStat = MarketStatistic(title: "24h High", value: high)
            
            let low = coin.low24H?.formattedWithAbbreviation() ?? "n/a"
            let lowStat = MarketStatistic(title: "24h Low", value: low)
            
            let priceChange24H = coin.priceChange24H?.formattedWithAbbreviation() ?? "n/a"
            let priceStatistic = MarketStatistic(title: "24h Price Change", value: priceChange24H, percentageChange: pricePercentChangeIn24H)
            
            let marketCapChangeIn24h = coin.marketCapChange24H?.formattedWithAbbreviation() ?? "n/a"
            let marketCapStats2 = MarketStatistic(title: "24h Market Cap Change", value: marketCapChangeIn24h, percentageChange: marketCapPercentChangeIn24h)
            
            let blockTimeInMinutes = String(coinDetail.blockTimeInMinutes ?? 0)
            let blockStatistic = MarketStatistic(title: "Block Time", value: blockTimeInMinutes + "m")
            
            let hashingAlgorithm = coinDetail.hashingAlgorithm ?? "n/a"
            let hashingStatistic = MarketStatistic(title: "Hashing Algorithm", value: hashingAlgorithm)
            
            let additionalStats = [
                highStat,
                lowStat,
                priceStatistic,
                marketCapStats2,
                blockStatistic,
                hashingStatistic
            ]
            self.overViewStatistics = overviewStats
            self.additionalStatistics = additionalStats
        }
    }
    
    
    
    private func decodeCoinData(fromJSONData data: Data) throws -> CoinDetailModel {
        let decoder = JSONDecoder()
        let coinDetailModel = try decoder.decode(CoinDetailModel.self, from: data)
        return coinDetailModel
    }
}
