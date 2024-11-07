//
//  HomeView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            Color.backgroundTheme
            VStack {
                HomeViewHeader(showPortfolio: $showPortfolio)
                    .padding(.horizontal, 18)
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .navigationTitle("hi")
            .toolbarVisibility(.hidden, for: .navigationBar)
    }
}


