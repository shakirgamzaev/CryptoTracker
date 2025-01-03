//
//  HomeViewHeader.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 6/11/24.
//

import SwiftUI


/// a header that sits at the top of the Home View, from which navigation to portfolio view happens
struct HomeViewHeader: View {
    @Binding var showPortfolio: Bool
    @Binding var showEditPortfolio: Bool
    
    var body: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ?  "plus" : "info", showPortfolio: $showPortfolio)
                .animation(nil, value: showPortfolio)
                .background {
                    AnimatedPulseVIew(animate: $showPortfolio)
                }
                .onTapGesture {
                    if showPortfolio {
                        showEditPortfolio = true
                    }
                }
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.title2)
                .bold()
                .animation(nil)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right", showPortfolio: $showPortfolio)
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.33)) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    @Previewable @State var show = false
    
    HomeViewHeader(showPortfolio: $show, showEditPortfolio: .constant(false))
        .padding(.horizontal)
}
