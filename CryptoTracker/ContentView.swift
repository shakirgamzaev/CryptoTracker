//
//  ContentView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .toolbarVisibility(.hidden, for: .navigationBar)
        }
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    ContentView()
}
