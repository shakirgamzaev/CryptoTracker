//
//  LaunchScreenView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 28/11/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var loadingText = "Loading your portfolio...".map({String($0)})
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var index = 0
    @State private var loops = 0
    @Binding var dismissLauncScreen: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Image(.logoTransparent)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                HStack(spacing: 1.0) {
                    ForEach(0..<25) { i in
                        Text(loadingText[i])
                            .foregroundStyle(.white)
                            .bold()
                            .fontWeight(.heavy)
                            .font(.title3)
                            .offset(y: i == index ? -7 : 0)
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.spring(duration: 0.4)) {
                if index == loadingText.count {
                    index = 0
                    loops += 1
                }
                else {
                    index += 1
                }
                if loops >= 2 {
                    dismissLauncScreen = true
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView(dismissLauncScreen: .constant(false))
}
