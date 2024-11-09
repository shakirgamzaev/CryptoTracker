//
//  CoindModel.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 7/11/24.
//

import Foundation
import SwiftUI

// CoinGecko Coin Data request API
/*
 
  url to get all the data about a specific Coin. In this url, ids=[value], you can insert a value of cryptocurrency that you want to fetch the price data and history for. Syntax is like this: for example, if you want to fetch all the data for ethereum, you need to type "ids=ethereum". No [] characters and NO SPACES, this is very important. The format should be exactly how i specified it above
  URL: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 
    COINMODEL JSON response:
 [
   {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 74859,
     "market_cap": 1480457065950,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1571854570933,
     "total_volume": 77269603693,
     "high_24h": 76244,
     "low_24h": 73492,
     "price_change_24h": 1327.25,
     "price_change_percentage_24h": 1.805,
     "market_cap_change_24h": 27596660275,
     "market_cap_change_percentage_24h": 1.89947,
     "circulating_supply": 19778928,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 76244,
     "ath_change_percentage": -1.69476,
     "ath_date": "2024-11-06T20:56:23.198Z",
     "atl": 67.81,
     "atl_change_percentage": 110433.75202,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null, // can ommit this property
     "last_updated": "2024-11-07T10:11:43.139Z",
     "sparkline_in_7d": {
       "price": [
         72266.0989592653,
         72203.02986430954,
         72329.48935058291,
       ]
     },
     "price_change_percentage_24h_in_currency": 1.8049956958332427
   }
 ]
 
 */

/*
 {
    "id": "ethereum",
    "symbol": "eth",
    "name": "Ethereum",
    "image": "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
    "current_price": 2918.98,
    "market_cap": 351254831611,
    "market_cap_rank": 2,
    "fully_diluted_valuation": 351254831611,
    "total_volume": 32088245359,
    "high_24h": 2947.84,
    "low_24h": 2790.6,
    "price_change_24h": 113.78,
    "price_change_percentage_24h": 4.05588,
    "market_cap_change_24h": 13970647427,
    "market_cap_change_percentage_24h": 4.1421,
    "circulating_supply": 120420137.425969,
    "total_supply": 120420137.425969,
    "max_supply": null,
    "ath": 4878.26,
    "ath_change_percentage": -40.20743,
    "ath_date": "2021-11-10T14:24:19.604Z",
    "atl": 0.432979,
    "atl_change_percentage": 673567.39515,
    "atl_date": "2015-10-20T00:00:00.000Z",
    "roi": {
      "times": 50.30801689504705,
      "currency": "btc",
      "percentage": 5030.801689504705
    },
    "last_updated": "2024-11-08T12:04:57.711Z",
    "sparkline_in_7d": {
      "price": [
        2515.5899631739694,
        2535.3514151128998,
        2576.0608853528647,
        2548.990194214874,
        2513.497301622508,
        2527.5335925421136,
        2505.49293478801,
        2500.7622047870777,
        2517.3784870617114,
        2513.1307516756224,
        2508.7014185893363,
        2514.765170164251,
        2511.971171522551,
        2516.5666644580842,
        2514.4503947072308,
        2512.8176233570985,
        2506.100581307112,
        2504.6796623757655,
        2511.6634731218287,
        2511.1686632027477,
        2507.2949305165184,
        2498.419496444809,
        2494.6116869447605,
        2501.038967387042,
        2501.451870295995,
        2488.910695705866,
        2477.903879722394,
        2480.9808707053553,
        2484.0774741822506,
        2492.221749981915,
        2481.641225822578,
        2488.49952282632,
        2491.275024905671,
        2493.4248447587133,
        2491.171307450643,
        2487.265701316592,
        2495.210882657583,
        2485.41138105615,
        2471.646509769016,
        2429.23617633712,
        2450.0111867531696,
        2455.48134433623,
        2444.1429243820967,
        2455.118363846138,
        2449.745869590284,
        2456.8677312704854,
        2455.318174851385,
        2455.9298716068897,
        2455.505516139951,
        2453.47660621413,
        2434.470590848142,
        2417.7508304097028,
        2445.36395107492,
        2448.0339312763695,
        2447.4960897145556,
        2431.899805600637,
        2448.441263255776,
        2470.1644077534024,
        2467.578232705301,
        2454.127239964868,
        2455.093450798762,
        2457.1127992376314,
        2464.471330387361,
        2474.429990640879,
        2474.1581054661983,
        2468.040270030291,
        2469.1674432454574,
        2471.607858951318,
        2457.7612417194496,
        2462.52834531666,
        2463.686128790964,
        2461.8001728930835,
        2465.719413110207,
        2481.8260293174244,
        2458.31027469136,
        2447.8680129507857,
        2436.0936227997868,
        2408.5250436571905,
        2423.2553250239416,
        2435.5013014544093,
        2426.721790134349,
        2422.1962554419574,
        2373.6253786583316,
        2399.1456773662426,
        2403.1309263640032,
        2401.3441576056766,
        2406.6312934391044,
        2402.7107667028235,
        2422.3531303134787,
        2425.0440265136704,
        2426.546725156869,
        2429.6339028317066,
        2443.5435005910263,
        2441.375421777093,
        2433.730648768377,
        2438.699118391354,
        2437.2531459217175,
        2442.5554050411047,
        2440.227647087435,
        2466.425597995752,
        2444.2752553335317,
        2469.619082756912,
        2454.4301439409232,
        2453.084696030993,
        2419.289634285991,
        2424.339885856694,
        2415.8579652507096,
        2429.710822252049,
        2429.8836459672857,
        2502.3053150367437,
        2482.6489058612656,
        2599.0401051434633,
        2569.860312228567,
        2583.611604373404,
        2596.200019574709,
        2584.722350730383,
        2591.236499347948,
        2604.56751732936,
        2616.840451692132,
        2624.403311655071,
        2632.2576003321224,
        2636.413672487837,
        2618.8997224717336,
        2632.1103411520808,
        2647.646753858681,
        2657.139029242699,
        2662.7753458239854,
        2678.392240372216,
        2697.377662353487,
        2692.9699826251094,
        2693.2541572110663,
        2732.925669321108,
        2717.536952936055,
        2723.329536415664,
        2820.221854727408,
        2862.1814457661967,
        2840.1646435641787,
        2839.2876550005194,
        2830.396780049646,
        2804.133778013536,
        2819.8280098933146,
        2822.7424145379464,
        2813.943052351306,
        2819.172443583565,
        2803.5923060979867,
        2817.972401148839,
        2808.208039489025,
        2792.7420414794105,
        2843.981622643806,
        2847.6354842578635,
        2863.1215765955676,
        2879.0083362367895,
        2888.484511422058,
        2901.6084390745673,
        2892.5066490997674,
        2887.1792653841712,
        2900.4698485303757,
        2913.364126946589,
        2918.6835013559967,
        2893.0382199791657,
        2906.456964958217,
        2910.9349521859344,
        2921.8802189918556,
        2902.302810259103,
        2905.540569535828,
        2902.437106008034,
        2917.346209679091,
        2922.5498497120534
      ]
    },
    "price_change_percentage_24h_in_currency": 4.0558813395914655
  }
 */


struct CoinModel: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    // coding keys
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H, priceChange24H: Double?
    let pricePercentageChange24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparkLine7D: SparkLine7Days?
    let priceChangePercentage24HInCurrency: Double?
    let numOfCoinsHeld: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case pricePercentageChange24H = "price_change_percentage_24h"
        
        case marketCapChange24H = "market_cap_change_24h"
        
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        
        case circulatingSupply = "circulating_supply"
        
        case maxSupply = "max_supply"
        
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparkLine7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case numOfCoinsHeld
    }
    
}


extension CoinModel {
    func updateHoldings(ammount: Double) -> CoinModel {
       let coinModel = CoinModel(
       id: id,
       symbol: symbol,
       name: name,
       image: image,
       currentPrice: currentPrice,
       marketCap: marketCap,
       marketCapRank: marketCapRank,
       fullyDilutedValuation: fullyDilutedValuation,
       totalVolume: totalVolume,
       high24H: high24H,
       low24H: low24H,
       priceChange24H: priceChange24H,
       pricePercentageChange24H: pricePercentageChange24H,
       marketCapChange24H: marketCapChange24H,
       marketCapChangePercentage24H: marketCapChangePercentage24H,
       circulatingSupply: circulatingSupply,
       maxSupply: maxSupply,
       ath: ath,
       athChangePercentage: athChangePercentage,
       athDate: athDate,
       atl: atl,
       atlChangePercentage: atlChangePercentage,
       atlDate: atlDate,
       lastUpdated: lastUpdated,
       sparkLine7D: sparkLine7D,
       priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
       numOfCoinsHeld: ammount
   )
        return coinModel
   }
    var currentHoldingsAmmount: Double {
       return (numOfCoinsHeld ?? 0) * currentPrice
   }
   
   var rank: Int {
       return Int(marketCapRank ?? 0)
   }
   
   //TODO: implement this method to get the data to create a UiImage that is the symbol of the current crypto coin
   func getCoinImage(urlString: String) {
       
   }
    
#if DEBUG
    static var previewCoin: CoinModel {
        return CoinModel(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 74_553.234354, // change this to test preview for price
            marketCap: 1480457065950,
            marketCapRank: 1,
            fullyDilutedValuation: 1571854570933,
            totalVolume: 77269603693,
            high24H: 76244,
            low24H: 73492,
            priceChange24H: 1327.25,
            pricePercentageChange24H: 1.805,
            marketCapChange24H: 27596660275,
            marketCapChangePercentage24H: 1.89947,
            circulatingSupply: 19778928,
            maxSupply: 21000000,
            ath: 76244,
            athChangePercentage: -1.69476,
            athDate: "2024-11-06T20:56:23.198Z",
            atl: 67.81,
            atlChangePercentage: 110433.75202,
            atlDate: "2013-07-06T00:00:00.000Z",
            lastUpdated: "2024-11-07T10:11:43.139Z",
            sparkLine7D: nil,
            priceChangePercentage24HInCurrency: 1.8049956958332427,
            numOfCoinsHeld: 1.4
        )
    }
#endif
    
}
   
    



struct SparkLine7Days: Codable {
    let price: [Double]?
}
