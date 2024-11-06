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
            VStack {
                HomeViewHeader(showPortfolio: $showPortfolio)
                    .padding(.horizontal, 18)
                Spacer(minLength: 0)
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


