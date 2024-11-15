//
//  CoinView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 15/11/24.
//

import SwiftUI

struct CoinView: View {
    let coin: CoinModel
    @Bindable var portofolioVM: PortfolioScreenVM
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin, size: 60)
            Text(coin.symbol.uppercased())
                .font(.title2)
                .bold()
            Text(coin.name)
                .font(.subheadline)
                .foregroundStyle(.secondaryText)
        }
        .padding(.horizontal)
        .padding(.vertical, 7)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.greenTheme, lineWidth: 2)
                .opacity(rectOpacity)
        }
        .measureSize(size: $portofolioVM.sizeCoinView)
    }
}

extension CoinView {
    var rectOpacity: CGFloat {
        if let selectedCoin = portofolioVM.selectedCoin {
            let opacity =  coin.id == selectedCoin.id ? 1.0 : 0
            return opacity
        }
        return 0
    }
}

#Preview {
    CoinView(coin: .previewCoin, portofolioVM: PortfolioScreenVM())
}
