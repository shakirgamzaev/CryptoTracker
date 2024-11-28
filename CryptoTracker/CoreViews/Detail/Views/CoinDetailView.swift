//
//  CoinDetailView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 20/11/24.
//

import SwiftUI

struct CoinDetailView: View {
    @State private var coinDetailVM: CoinDetailViewModel
    let coin: CoinModel
    @State private var isExpandedDescription = false
    
    init(
        coin: CoinModel
    ) {
        self.coin = coin
        _coinDetailVM = State(initialValue: CoinDetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // Chart View
                PricesChartView(prices: coin.sparkLine7D?.price ?? [])
                    .frame(height: 300)
                
                VStack {
                    Text(coinDetailVM.description)
                        .lineLimit(isExpandedDescription ? nil : 3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if coinDetailVM.description != "no description" {
                        Text(isExpandedDescription ? "Less" : "Read More...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .safeAreaPadding(.top, 7)
                            .foregroundStyle(.blue)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.2)) {
                                    isExpandedDescription.toggle()
                                }
                            }
                    }

                }
                
                Text("Overview")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                Divider()
                    .safeAreaPadding(.bottom, 20)
                
                DetailStatsView(statistics: coinDetailVM.overViewStatistics)
                
                Text("Additional")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                Divider()
                    .safeAreaPadding(.bottom, 20)
                DetailStatsView(statistics: coinDetailVM.additionalStatistics)
                
                linksView
                    .safeAreaPadding(.top, 20)
                 
            }
            .padding(.horizontal)
            .navigationTitle(coin.coinId.capitalized)
        }
    }
}

extension CoinDetailView {
    var linksView: some View {
        VStack(spacing: 10.0) {
            if let links = coinDetailVM.coinDetail?.links
                {
                if let string = links.homePage.first,
                   let coinURL = URL(string: string) {
                    Link(destination: coinURL) {
                        Text("HomePage")
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                    }
                }
                if let subRedditUrl = URL(string: links.subRedditUrl) {
                    Link(destination: subRedditUrl) {
                        Text("SubReddit")
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3)
                    }
                }
            }
        }
        .fontWeight(.bold)
    }
}


#Preview {
    NavigationStack {
        CoinDetailView(coin: .previewCoin)
    }
}
