//
//  CoindModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 7/11/24.
//

import Foundation
import SwiftUI

// CoinGecko Coin Data request API
/*
 
  url to get all the data about a specific Coin. In this url, ids=[value], you can insert a value of cryptocurrency that you want to fetch the price data and history for. Syntax is like this: for example, if you want to fetch all the data for ethereum, you need to type "ids=ethereum". No [] characters and NO SPACES, this is very important. The format should be exactly how i specified it above
  URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 
    COINMODEL JSON response:
 [
   {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 74859,
     "market_cap": 1480457065950,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1571854570933,
     "total_volume": 77269603693,
     "high_24h": 76244,
     "low_24h": 73492,
     "price_change_24h": 1327.25,
     "price_change_percentage_24h": 1.805,
     "market_cap_change_24h": 27596660275,
     "market_cap_change_percentage_24h": 1.89947,
     "circulating_supply": 19778928,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 76244,
     "ath_change_percentage": -1.69476,
     "ath_date": "2024-11-06T20:56:23.198Z",
     "atl": 67.81,
     "atl_change_percentage": 110433.75202,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null, // can ommit this property
     "last_updated": "2024-11-07T10:11:43.139Z",
     "sparkline_in_7d": {
       "price": [
         72266.0989592653,
         72203.02986430954,
         72329.48935058291,
         (NOTE: this is an array of floating point prices of a requested cryptocurrency, the price of each cell is an hourly price. This array will be much larger than this model smaple.
       ]
     },
     "price_change_percentage_24h_in_currency": 1.8049956958332427
   }
 ]
 
 */

struct CoinModel: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    // coding keys
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H: Double?
    let pricePercentageChange24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply: Int?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparkLine7D: SparkLine7Days?
    let priceChangePercentage24H: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case pricePercentageChange24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparkLine7D = "sparkline_in_7d"
        case priceChangePercentage24H = "price_change_percentage_24h_in_currency"
    }
}

struct SparkLine7Days: Codable {
    let price: [Double]?
}
