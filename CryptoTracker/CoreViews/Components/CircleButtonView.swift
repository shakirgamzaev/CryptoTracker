//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    @Binding var showPortfolio: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Image(systemName: iconName)
            .frame(width: 50, height: 50)
            .bold()
            .padding(.all, 6)
            .background {
                Color.backgroundTheme
            }
            .clipShape(Circle())
            .shadow(color: .accent.opacity(opacityValue), radius: shadowRadius)
    }
}

extension CircleButtonView {
    var opacityValue: CGFloat {
        colorScheme == .dark ? 0.4 : 0.28
    }
    
    var shadowRadius: CGFloat {
        colorScheme == .dark ? 13 : 11
    }
}

#Preview {
    CircleButtonView(iconName: "chevron.left", showPortfolio: .constant(false))
}
