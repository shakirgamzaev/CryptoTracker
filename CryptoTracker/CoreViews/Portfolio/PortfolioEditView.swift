//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 14/11/24.
//

import SwiftUI

struct PortfolioEditView: View {
    @Environment(HomeViewModel.self) private var homeScreenVM
    @State private var portfolioVM = PortfolioScreenVM()
    
    var body: some View {
        @Bindable var homeVM = homeScreenVM
        NavigationStack {
            VStack(spacing: 20.0) {
                SearchFieldView(searchText: $portfolioVM.searchText)
                    .padding(.horizontal)
                    .onChange(of: portfolioVM.searchText) { _, newValue in
                        filterCoins(searchText: newValue)
                    }
                
                ListOfCoinsView(portfolioVM: portfolioVM)
                    .safeAreaPadding(.bottom, 10)
                
                if let selectedCoin = portfolioVM.selectedCoin {
                    InputFieldsView(portfolioVM: portfolioVM, selectedCoin: selectedCoin)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .safeAreaPadding(.top, 20)
            .navigationTitle("Edit Portfolio")
            .toolbar {
                toolBarButtons
            }
            .onDisappear {
                homeScreenVM.filteredCoins = homeScreenVM.allCoins
            }
            .onChange(of: portfolioVM.selectedCoin) {
                if let coin = $1 {
                    portfolioVM.ammountOfCoinsString = coin.numOfCoinsHeld == nil ? "" : "\(coin.numOfCoinsHeld!)"
                }
                
            }
        }
    }
}


extension PortfolioEditView {
    @ToolbarContentBuilder
    var toolBarButtons: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack {
                Image(systemName: "checkmark")
                    .opacity(portfolioVM.showCheckMark ? 1.0 : 0.0)
                Button {
                    //save Coin into user portfolio
                    portfolioVM.saveCoinToPortfolio(coin: portfolioVM.selectedCoin!, vm: homeScreenVM)
                } label: {
                    Text("SAVE")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .opacity(opacitySaveButton)
            }
        }
        ToolbarItem(placement: .topBarLeading) {
            XMarkButton()
        }
    }
}

extension PortfolioEditView {
    var opacitySaveButton: CGFloat {
        if let coin = portfolioVM.selectedCoin {
            let opacity = /*coin.currentHoldingsAmmount != Double(portfolioVM.ammountOfCoinsString) &&*/ !portfolioVM.ammountOfCoinsString.isEmpty ? 1.0 : 0.0
            return opacity
        }
        return 0.0
    }
    
    private func filterCoins(searchText: String) {
        if searchText == "" {
            portfolioVM.selectedCoin = nil
            homeScreenVM.filteredCoins = homeScreenVM.allCoins
        }
        else {
            Task {
                await homeScreenVM.filterAndSortCoins(searchText: portfolioVM.searchText)
            }
        }
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    PortfolioEditView()
}
