//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 13/11/24.
//

import Foundation
//JSON Data reponse that comes from Coin Gecko api at URL: https://api.coingecko.com/api/v3/global
/*
 JSON RESPONSE:
 {
   "data": {
     "active_cryptocurrencies": 15190,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1152,
     "total_market_cap": {
       "btc": 34610395.24756663,
       "eth": 959679065.9408386,
       "ltc": 41316924330.6828,
       "bch": 7276457205.182405,
       "bnb": 5013249248.266966,
       "eos": 5605173152789.477,
       "xrp": 4454420109658.952,
       "xlm": 24260486005112.7,
       "link": 222338771377.03412,
       "dot": 587795004663.9498,
       "yfi": 490302635.2815317,
       "usd": 3167283125625.378,
     },
     "total_volume": {
       "btc": 3870224.8841973306,
       "eth": 107313822.19937572,
       "ltc": 4620166500.246751,
       "bch": 813672468.7151289,
       "bnb": 560594637.8982917,
       "eos": 626785116465.4305,
       "xrp": 498104902580.7687,
       "xlm": 2712870973246.388,
       "link": 24862502711.97808,
     },
     "market_cap_percentage": {
       "btc": 57.15569563165657,
       "eth": 12.553648793363633,
       "usdt": 3.9649896456420635,
       "sol": 3.2209946079631484,
       "bnb": 2.9100886459453514,
       "doge": 1.9423788249084917,
       "xrp": 1.274696518468733,
       "usdc": 1.1537030317139394,
       "steth": 1.0181692235494424,
       "ada": 0.6695025494287554
     },
     "market_cap_change_percentage_24h_usd": 1.9987804414445278,
     "updated_at": 1731511219
   }
 }
 
 */

struct GlobalData: Decodable {
    let marketData: MarketData
    enum CodingKeys: String, CodingKey {
        case marketData = "data"
    }
}

struct MarketData: Decodable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapPercentageChange24H: Double
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapPercentageChange24H = "market_cap_change_percentage_24h_usd"
    }
    var totalVolumeInUSD: String {
        return (totalVolume["usd"] ?? 0).formattedWithAbbreviation()
    }
    var marketCap: String {
        return (totalMarketCap["usd"] ?? 0).formattedWithAbbreviation()
    }
    var marketCapPercChange24H: String {
        return marketCapPercentageChange24H.percentageFormatted()
    }
    
    var btcDominance: String {
        return (marketCapPercentage["btc"] ?? 0).percentageFormatted()
    }
}

