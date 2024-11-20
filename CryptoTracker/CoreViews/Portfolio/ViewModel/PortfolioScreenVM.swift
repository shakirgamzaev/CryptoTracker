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
    var ammountOfCoinsString: String
    var searchText: String
    var showCheckMark: Bool = false
    
    init(selectedCoin: CoinModel? = nil, heightCoinView: CGSize = .zero) {
        self.selectedCoin = selectedCoin
        self.sizeCoinView = heightCoinView
        self.ammountOfCoinsString = ""
        self.searchText = ""
    }
    
    func saveCoinToPortfolio(coin: CoinModel, vm: HomeViewModel) {
        withAnimation(.smooth(duration: 0.2)) {
            showCheckMark = true
        }
        searchText = ""
        selectedCoin = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.smooth(duration: 0.2)) {
                self.showCheckMark = false
            }
        }
        vm.updatePortfolio(coin: coin, ammount: Double(ammountOfCoinsString) ?? 0)
        ammountOfCoinsString = ""
    }
}
