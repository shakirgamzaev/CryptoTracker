//
//  HomeViewHeaderTitles.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import SwiftUI

struct HomeViewHeaderTitles: View {
    let showPortfolio: Bool
    
    var body: some View {
        HStack {
            Text("Coin")
                .frame(maxWidth: .infinity, alignment: .leading)
                .safeAreaPadding(.leading, 18)
            if showPortfolio {
                Text("Holdings")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            Text("Price")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .foregroundStyle(.secondaryText)
        .safeAreaPadding(.top, 10)
        .padding(.leading, 10)
        .padding(.trailing, 15)
        .animation(nil, value: showPortfolio)
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    HomeViewHeaderTitles(showPortfolio: true)
}
