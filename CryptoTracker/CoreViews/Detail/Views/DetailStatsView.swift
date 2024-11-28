//
//  OverviewStatsView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 22/11/24.
//

import SwiftUI

struct DetailStatsView: View {
    let statistics: [MarketStatistic]
    let gridItems = [
        GridItem(.flexible(minimum: 150, maximum: .infinity),alignment: .leading),
        GridItem(.flexible(minimum: 150, maximum: .infinity), alignment: .leading)
    ]
    
    var body: some View {
        LazyVGrid(
            columns: gridItems,
            spacing: 30
        ) {
            ForEach(statistics) { stat in
                MarketStatsCellView(marketStats: MarketStatistic(title: stat.title, value: stat.value,percentageChange: stat.percentageChange))
            }
        }
    }
}

#Preview {
    DetailStatsView(statistics: [.preview1, .preview2, .preview3])
        .padding()
}
