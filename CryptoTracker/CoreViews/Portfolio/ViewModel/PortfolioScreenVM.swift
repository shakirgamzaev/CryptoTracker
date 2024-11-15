//
//  PortfolioScreenVM.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 15/11/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class PortfolioScreenVM {
    var selectedCoin: CoinModel? = nil
    var sizeCoinView: CGSize
    var ammountOfCoins: String
    init(selectedCoin: CoinModel? = nil, heightCoinView: CGSize = .zero) {
        self.selectedCoin = selectedCoin
        self.sizeCoinView = heightCoinView
        self.ammountOfCoins = ""
    }
}
