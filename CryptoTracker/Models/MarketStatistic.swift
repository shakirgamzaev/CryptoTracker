//
//  MarketStatistic.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 13/11/24.
//

import Foundation



struct MarketStatistic: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

#if DEBUG
extension MarketStatistic {
    static let preview1 = MarketStatistic(title: "Market Cap", value: "$2.56Tr", percentageChange: 12.34)
    static let preview2 = MarketStatistic(title: "24h Volume", value: "$338.83Bn")
    static let preview3 = MarketStatistic(title: "BTC Dominance", value: "42.67%")
    static let preview4 = MarketStatistic(title: "Market Cap", value: "$2.56Tr", percentageChange: -116.34)
    static let previewListOfMarketStats: [MarketStatistic] = [
        MarketStatistic(title: "Market Cap", value: "$2.56Tr", percentageChange: 12.34),
        MarketStatistic(title: "24h Volume", value: "$338.83Bn"),
        MarketStatistic(title: "BTC Dominance", value: "42.67%"),
        MarketStatistic(title: "Market Cap", value: "$2.56Tr", percentageChange: -116.34)
    ]
}
#endif
