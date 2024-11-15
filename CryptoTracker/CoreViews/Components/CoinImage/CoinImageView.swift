//
//  CircularCoinImageView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 10/11/24.
//

import SwiftUI


struct CoinImageView: View {
    let coin: CoinModel
    @State private var coinImageVM: CoinImageViewModel
    let size: CGFloat
    
    init(coin: CoinModel, size: CGFloat) {
        self.coin = coin
        _coinImageVM = State(wrappedValue: CoinImageViewModel(coinModel: coin))
        self.size = size
    }
    var body: some View {
        if let image = coinImageVM.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
        else if coinImageVM.error != nil {
            VStack {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text("error fetching")
            }
            .frame(maxWidth: 40)
        }
        else if coinImageVM.isDownloading {
            ProgressView()
        }
    }
}

#Preview {
    CoinImageView(coin: .previewCoin, size: 45)
}
