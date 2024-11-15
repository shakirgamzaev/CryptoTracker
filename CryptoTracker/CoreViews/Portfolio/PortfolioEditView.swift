//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 14/11/24.
//

import SwiftUI

struct PortfolioEditView: View {
    @Environment(HomeViewModel.self) private var homeScreenVM
    @State private var portfolioScreenVM = PortfolioScreenVM()
    
    var body: some View {
        @Bindable var homeVM = homeScreenVM
        NavigationStack {
            VStack(spacing: 20.0) {
                SearchFieldView(searchText: $homeVM.searchText)
                    .padding(.horizontal)
                    .onChange(of: homeScreenVM.searchText) {
                        Task {
                            await homeScreenVM.filteredCoins()
                        }
                    }
                
                ListOfCoinsView(portfolioVM: portfolioScreenVM)
                    .safeAreaPadding(.bottom, 10)
                
                if let selectedCoin = portfolioScreenVM.selectedCoin {
                    InputFieldsView(portfolioVM: portfolioScreenVM, selectedCoin: selectedCoin)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .safeAreaPadding(.top, 20)
            .navigationTitle("Edit Portfolio")
            .toolbar {
                toolBarButtons
            }
        }
    }
}


extension PortfolioEditView {
    @ToolbarContentBuilder
    var toolBarButtons: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            HStack {
                Button {
                    //save Coin into user portfolio
                } label: {
                    Text("SAVE")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .opacity(portfolioScreenVM.ammountOfCoins.isEmpty ? 0.0 : 1.0)
            }
        }
        ToolbarItem(placement: .topBarLeading) {
            XMarkButton()
        }
    }
}

#Preview(traits: .modifier(HomeVMPreviewModifier())) {
    PortfolioEditView()
}
