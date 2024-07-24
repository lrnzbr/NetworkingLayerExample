//
//  Model.swift
//  NetworkingLayerExample
//
//  Created by Lorenzo Brown on 7/23/24.
//

import Foundation

struct CryptoAsset: Codable, Identifiable {
    var id: String
    var rank: Int?
    var symbol: String?
    var name: String?
    var supply: Double?
    var maxSupply: Double?
    var marketCapUsd: Double?
    var volumeUsd24Hr: Double?
    var priceUsd: Double?
    var changePercent24Hr: Double?
    var vwap24Hr: Double?
    
    private enum CodingKeys: String, CodingKey {
            case id, rank, symbol, name, supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr
        }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        
        if let rankInt = try? container.decode(String.self, forKey: .rank), let rankAsInteger = Int(rankInt) {
                    rank = rankAsInteger
        } else {
            rank = nil
        }

        symbol = try container.decodeIfPresent(String.self, forKey: .symbol)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        if let supplyVal = try? container.decode(String.self, forKey: .supply), let supplyDouble = Double(supplyVal) {
            supply = supplyDouble
        } else {
            supply = nil
        }
        if let maxSupplyVal = try? container.decode(String.self, forKey: .maxSupply), let maxSupplyDouble = Double(maxSupplyVal) {
            maxSupply = maxSupplyDouble
        } else {
            maxSupply = nil
        }
        if let marketCapUsdVal = try? container.decode(String.self, forKey: .marketCapUsd), let marketCapUsdDouble = Double(marketCapUsdVal) {
            marketCapUsd = marketCapUsdDouble
        } else {
            marketCapUsd = nil
        }
        if let volumeUsd24HrVal = try? container.decode(String.self, forKey: .volumeUsd24Hr), let volumeUsd24HrDouble = Double(volumeUsd24HrVal) {
            volumeUsd24Hr = volumeUsd24HrDouble
        } else {
            volumeUsd24Hr = nil
        }
        if let vwap24HrVal = try? container.decode(String.self, forKey: .vwap24Hr), let vwap24HrDouble = Double(vwap24HrVal) {
            vwap24Hr = vwap24HrDouble
        } else {
            vwap24Hr = nil
        }
       }
}

struct CryptoAssets : Codable {
    var data: [CryptoAsset]
}
