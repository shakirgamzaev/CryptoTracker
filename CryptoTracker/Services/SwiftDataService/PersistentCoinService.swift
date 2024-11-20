//
//  PersistentCoinService.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 18/11/24.
//

import Foundation
import SwiftData

@MainActor
@Observable
class PersistentCoinService {
    @ObservationIgnored let modelContainer: ModelContainer
    @ObservationIgnored let modelContext: ModelContext
    var allPortfolioCoins: [PortfolioCoin] = []
    
    init(_ isPreview: Bool = false) {
        let configuration = ModelConfiguration(for: PortfolioCoin.self, isStoredInMemoryOnly: isPreview)
        do {
            try self.modelContainer = ModelContainer(for: PortfolioCoin.self, configurations: configuration)
            self.modelContext = ModelContext(modelContainer)
            getPortfolioCoins()
        } catch  {
            fatalError("DEBUG(PersistentCoinService:18):error initializing model container: \(error.localizedDescription)")
        }
    }
    
    func fetchPortfolioCoins()  -> [PortfolioCoin] {
        let sortDescriptor = SortDescriptor(\PortfolioCoin.ammount, order: .forward)
        let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
        do {
            let coins = try modelContext.fetch(fetchDescriptor)
            return coins
        }
        catch {
            print("error fetching portfolioCoins using modelContext: \(error.localizedDescription)")
            return []
        }
    }
    
    func updatePortfolio(coin: CoinModel, ammount: Double) -> [PortfolioCoin] {
        self.getPortfolioCoins()
        if let portfolioCoin = allPortfolioCoins.first(where: {$0.coinId == coin.coinId}) {
            if ammount > 0 {
                update(portfolioCoin: portfolioCoin, ammount: ammount)
                return fetchPortfolioCoins()
            }
            else {
                removeCoin(portfolioCoin: portfolioCoin)
                return fetchPortfolioCoins()
            }
        }
        else {
            add(coin: coin, ammount: ammount)
            return fetchPortfolioCoins()
        }
    }
    
    
    //PRIVATE Section
    
    private func getPortfolioCoins() {
        let sortDescriptor = SortDescriptor(\PortfolioCoin.ammount, order: .forward)
        let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
        do {
            self.allPortfolioCoins = try modelContext.fetch(fetchDescriptor)
        }
        catch {
            print("error fetching portfolioCoins using modelContext: \(error.localizedDescription)")
        }
    }
    
    private func add(coin: CoinModel, ammount: Double) {
        let newCoin = PortfolioCoin(coinId: coin.coinId, ammount: ammount)
        modelContext.insert(newCoin)
        applyChanges()
    }
    private func update(portfolioCoin: PortfolioCoin, ammount: Double) {
        portfolioCoin.ammount = ammount
        applyChanges()
    }
    
    private func removeCoin(portfolioCoin: PortfolioCoin) {
        modelContext.delete(portfolioCoin)
        applyChanges()
    }
    
    
    private func save() {
        do {
            try modelContext.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    private func applyChanges() {
        save()
        //getPortfolioCoins()
    }
}
