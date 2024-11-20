//
//  CoinDetailView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 20/11/24.
//

import SwiftUI

struct CoinDetailView: View {
    let coin: CoinModel
    //@Binding var selected
    init(coin: CoinModel) {
        self.coin = coin
        print(coin.coinId + "init is called")
    }
    
    var body: some View {
        Text(coin.coinId)
    }
}

#Preview {
    CoinDetailView(coin: .previewCoin2)
}
