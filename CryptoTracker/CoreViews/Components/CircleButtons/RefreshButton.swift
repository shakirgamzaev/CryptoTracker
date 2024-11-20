//
//  refreshButton.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 19/11/24.
//

import SwiftUI

struct RefreshButton: View {
    let action: () -> Void
    var body: some View {
        Button {
            //call coingecko api again to refresh the data
            action()
        } label: {
            Image(systemName: "goforward")
        }

    }
}

#Preview {
    RefreshButton(action: {})
}
