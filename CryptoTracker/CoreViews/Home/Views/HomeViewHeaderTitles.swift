//
//  HomeViewHeaderTitles.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import SwiftUI

struct HomeViewHeaderTitles: View {
    let showPortfolio: Bool
    @Environment(HomeViewModel.self) private var homeVM
    
    var body: some View {
        HStack {
            HStack(spacing: 6.0) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(homeVM.sortOption == .rank ? 0 : 180))
                    .opacity(coinChevronOpacity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .safeAreaPadding(.leading, 18)
            .onTapGesture {
                homeVM.sortOption = homeVM.sortOption == .rank ? .rankReversed : .rank
            }
            
            
            if showPortfolio {
                HStack {
                    Text("Holdings")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Image(systemName: "chevron.down")
                        .opacity(holdingsChevronOpacity)
                        .rotationEffect(.degrees(homeVM.sortOption == .holdings ? 0 : 180))
                    
                }
                .onTapGesture {
                    homeVM.sortOption = homeVM.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
            
            
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(priceChevronOpacity)
                    .rotationEffect(.degrees(homeVM.sortOption == .price ? 0 : 180))
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .safeAreaPadding(.trailing, 4)
            .onTapGesture {
                homeVM.sortOption = homeVM.sortOption == .price ? .priceReversed : .price
            }
            
            RefreshButton {
                Task {
                    async let coins: Void = homeVM.getCoins()
                    async let marketData: Void = homeVM.getMarketData()
                    await coins
                    await marketData
                }
            }
            .rotationEffect(.degrees(homeVM.isDownloading ? 0 : 360))
            .animation(.smooth(duration: 0.3), value: homeVM.isDownloading)
            
        }
        .foregroundStyle(.secondaryText)
        .safeAreaPadding(.top, 10)
        .padding(.leading, 10)
        .padding(.trailing, 15)
        .animation(nil, value: showPortfolio)
        .animation(.smooth, value: homeVM.sortOption)
    }
}

extension HomeViewHeaderTitles {
    var coinChevronOpacity: CGFloat {
        return (homeVM.sortOption == .rank || homeVM.sortOption == .rankReversed) ? 1.0 : 0.0
    }
    var holdingsChevronOpacity: CGFloat {
        return (homeVM.sortOption == .holdings || homeVM.sortOption == .holdingsReversed) ? 1.0 : 0.0
    }
    
    var priceChevronOpacity: CGFloat {
        return (homeVM.sortOption == .price || homeVM.sortOption == .priceReversed) ? 1.0 : 0.0
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    HomeViewHeaderTitles(showPortfolio: true)
}
