//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 7/11/24.
//

import Foundation


@MainActor
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
#if DEBUG
    func getCoinModelTest() async throws -> [CoinModel] {
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let coinModel = try decoder.decode([CoinModel].self, from: data)
        return coinModel
    }
#endif
}
