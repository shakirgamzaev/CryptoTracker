//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 7/11/24.
//

import Foundation
//Coin Gecko Api Key -> CG-k2bK2hNbEfKk782u42o2wTym

@MainActor
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    ///retrieves all Coin ids available on CoinGecko
    nonisolated func getAllCoinIds(url: URL) async throws -> [CoinNameModel] {
        
        var request = URLRequest(url: url)
        request.addValue("CG-k2bK2hNbEfKk782u42o2wTym", forHTTPHeaderField: "x-cg-demo-api-key")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        let ids = try decoder.decode([CoinNameModel].self, from: data)
        
        return ids
    }
    
    nonisolated func getCoindIdStrings(coinIds: [CoinNameModel]) async -> [String] {
        var coinIdStrings: [String] = []
        for coinId in coinIds {
            let coinString = coinId.id
            coinIdStrings.append(coinString)
        }
        //after we get the list of all coin ids, we need to significantly shrink the number of ids we will put into the request to coinGecko. The Api returns about 180_000 coins, which is an extremly large ammount. we select 100 random coin ids from coinGecko
        var finalCoinIds: [String] = []
        finalCoinIds.append("bitcoin")
        finalCoinIds.append("ethereum")
        finalCoinIds.append("monero")
        for _ in 0..<100 {
            let randomId = coinIdStrings.randomElement()!
            finalCoinIds.append(randomId)
        }
        return finalCoinIds
    }
    
    /// goes to coinGecko Api and gets the coins
    func getCoins() async throws -> [CoinModel] {
        let listOfCoinIds = try await getAllCoinIds(url: URL(string: "https://api.coingecko.com/api/v3/coins/list")!)
        let allCoinIdStrings = await getCoindIdStrings(coinIds: listOfCoinIds)
        //this is the part of url query parameters joined by ,. For instance, if you want to fetch bitcoin, ethereum and monery, thiswould return a string "bitcoin,ethereum,monero". this string is appended to the url below that gets all the crypto coins and their data to display on the HomeView
        let idsString = allCoinIdStrings.joined(separator: ",")
        
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&" + idsString + "&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("CG-k2bK2hNbEfKk782u42o2wTym", forHTTPHeaderField: "x-cg-demo-api-key")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        guard httpResponse.statusCode == 200 else {
            print("error: status code: \(httpResponse.statusCode)")
            return []
        }
        let decoder = JSONDecoder()
        let coins = try decoder.decode([CoinModel].self, from: data)
        return coins
    }
    

}