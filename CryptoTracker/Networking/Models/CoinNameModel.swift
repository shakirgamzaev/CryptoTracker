//
//  CoinNameModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 9/11/24.
//

import Foundation

/// A temprorary model used to get the list of all possible coins available on CoinGecko Api
struct CoinNameModel: Decodable {
    let id: String
    enum CodingKeys: String, CodingKey {
        case id
    }
}
