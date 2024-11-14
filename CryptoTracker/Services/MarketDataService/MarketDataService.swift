//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 14/11/24.
//

import Foundation

@MainActor
class MarketDataService {
    let url: URL
    init(url: URL) {
        self.url = url
        Task {
            try await self.getMarketData()
        }
    }
    
    private func getGlobalMarketData(fromURL url: URL) async throws -> Data {
        let data = try await NetworkManager().getResource(from: url)
        return data
    }
    
    func getMarketData() async throws -> MarketData {
        let globalMarketData = try await getGlobalMarketData(fromURL: url)
        let decoder = JSONDecoder()
        let globalMarketModel = try decoder.decode(GlobalData.self, from: globalMarketData)
        return globalMarketModel.marketData
    }
}
