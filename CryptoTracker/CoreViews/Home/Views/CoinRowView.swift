//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 7/11/24.
//

import SwiftUI




struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack {
            leftSide
            Spacer()
            if showHoldingsColumn {
                middlePart
            }
            
            rightSide
        }
    }
}

extension CoinRowView {
    var isNegativePercentage: Bool {
        if let percent = coin.pricePercentageChange24H {
            return percent < 0
        }
        return true
    }
}

extension CoinRowView {
    var leftSide: some View {
        HStack {
            
            Text(String(format: "%-3.d", coin.rank))
                .font(.title3)
                .safeAreaPadding(.trailing, 7)
            //placeholder for crypto coin image
            CircularCoinImageView(coin: coin)
            Text(coin.symbol.uppercased())
                .font(.title2)
                .bold()
            
        }
    }
    
    var middlePart: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsAmmount.currencyFormatted())
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(coin.numOfCoinsHeld?.stringFormatted() ?? "0 ")
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var rightSide: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.currencyFormatted())
                .font(.title3)
            
            Text(coin.pricePercentageChange24H?.percentageFormatted() ?? "0%")
                .foregroundStyle(isNegativePercentage ? .redTheme : .greenTheme)
                .font(.title3)
                .bold()
        }
        .fontWeight(.semibold)
    }
}

#Preview {
    CoinRowView(coin: .previewCoin, showHoldingsColumn: true)
        .padding(.horizontal)
}
