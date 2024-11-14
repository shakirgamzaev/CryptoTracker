//
//  MarketStatsCell.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 13/11/24.
//

import SwiftUI

struct MarketStatsCellView: View {
    let marketStats: MarketStatistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(marketStats.title)
                .foregroundStyle(.secondaryText)
                .font(.callout)
            Text(marketStats.value)
                .foregroundStyle(.accent)
                .bold()
                .font(.title3)
            if let percentChange = marketStats.percentageChange {
                HStack(spacing: 3.0) {
                    Image(systemName: "triangleshape.fill")
                        .rotationEffect(.degrees(percentChange >= 0 ? 0 : 180))
                    Text("\(percentChange.percentageFormatted())")
                }
                .foregroundStyle(percentChange >= 0 ? .greenTheme : .redTheme)
                .font(.callout)
            }
        }
        .fixedSize()
    }
}

#Preview {
    MarketStatsCellView(marketStats: .preview1)
}
