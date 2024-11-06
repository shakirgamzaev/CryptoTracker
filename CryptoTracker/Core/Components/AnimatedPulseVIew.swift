//
//  AnimatedPulseVIew.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI

struct AnimatedPulseVIew: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(.accent, lineWidth: 3)
            .opacity(animate ? 0.0 : 1.0)
            .scaleEffect(animate ? 1.4 : 0.0)
            .animation(animate ? .smooth(duration: 0.45) : nil, value: animate)
    }
}

#Preview {
    AnimatedPulseVIew(animate: .constant(true))
        .frame(width: 100, height: 100)
}
