//
//  InputFieldsView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 15/11/24.
//

import SwiftUI

struct InputFieldsView: View {
    @Bindable var portfolioVM: PortfolioScreenVM
    let selectedCoin: CoinModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Current Price of \(selectedCoin.name):")
                    .bold()
                    .font(.title3)
                Spacer()
                Text(selectedCoin.currentPrice.currencyFormatted())
                    .bold()
            }
            Divider()
            HStack {
                Text("Ammount Holding: ")
                    .bold()
                    .font(.title3)
                Spacer()
                TextField("ammount", text: $portfolioVM.ammountOfCoins, prompt: Text("Ex: 1.42"))
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)

            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(totalAmmountInDollars)
            }
        }
    }
}

extension InputFieldsView {
    var totalAmmountInDollars: String {
        let ammount = Double(portfolioVM.ammountOfCoins)
        if let ammount {
            return Double(ammount * selectedCoin.currentPrice).currencyFormatted()
        }
        return 0.currencyFormatted()
    }
}

#Preview {
    InputFieldsView(portfolioVM: PortfolioScreenVM(), selectedCoin: .previewCoin)
        .padding(.horizontal)
}
