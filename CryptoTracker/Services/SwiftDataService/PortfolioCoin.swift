//
//  PortfolioCoin.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 18/11/24.
//

import Foundation
import SwiftData



@Model
class PortfolioCoin {
    var coinId: String
    var ammount: Double
    init(coinId: String, ammount: Double) {
        self.coinId = coinId
        self.ammount = ammount
        
    }
}

