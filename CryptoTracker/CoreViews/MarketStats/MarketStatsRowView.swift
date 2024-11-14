//
//  MarketStatsView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 13/11/24.
//

import SwiftUI

struct MarketStatsRowView: View {
    let marketStats: [MarketStatistic]
    @Binding var showPortfolio: Bool
    @State private var scrollPosition = ScrollPosition()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(marketStats) { stat in
                    MarketStatsCellView(marketStats: stat)
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.horizontal, count: 3, spacing: 0, alignment: .leading)
                }
            }
        }
        .scrollDisabled(true)
        .scrollPosition($scrollPosition)
        .animation(.smooth(duration: 0.33), value: scrollPosition)
        .onChange(of: showPortfolio) { _, newValue in
            newValue == true ? scrollPosition.scrollTo(edge: .trailing) : scrollPosition.scrollTo(edge: .leading)
        }
        .onTapGesture {
            showPortfolio.toggle()
        }
    }
}

#Preview {
    @Previewable @State var showPortfolio = false
    
    MarketStatsRowView(marketStats: MarketStatistic.previewListOfMarketStats, showPortfolio: $showPortfolio)
}
