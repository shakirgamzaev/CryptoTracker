//
//  CircularCoinImageView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 10/11/24.
//

import SwiftUI


struct CircularCoinImageView: View {
    let coin: CoinModel
    @State private var coinImageVM: CoinImageDownload
    
    init(coin: CoinModel) {
        self.coin = coin
        _coinImageVM = State(wrappedValue: CoinImageDownload(coinModel: coin))
    }
    var body: some View {
        if let image = coinImageVM.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
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
    CircularCoinImageView(coin: .previewCoin)
}
