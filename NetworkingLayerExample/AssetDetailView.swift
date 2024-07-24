//
//  AssetDetailView.swift
//  NetworkingLayerExample
//
//  Created by Lorenzo Brown on 7/23/24.
//

import SwiftUI

struct AssetDetailView: View {
    let asset: CryptoAsset
        var body: some View {
            VStack {
                Text(asset.name ?? "Unknown Asset")
                    .font(.largeTitle)
                    .padding()
                
                Text(asset.symbol ?? "Unknown Symbol")
                    .font(.title)
                    .padding()
                Group {
                    if let rank = asset.rank {
                        Text("Rank: ")
                        Text("\(rank)")
                    }
                }.font(.body)
                Group {
                    if let supply = asset.supply {
                        Text("Supply: ")
                        Text("\(supply)")
                    }
                }.font(.body)
                
                Group {
                    if let maxSupply = asset.maxSupply {
                        Text("Max Supply: ")
                        Text("\(maxSupply)")
                    }
                }.font(.body)

                Group {
                    if let marketCapUsd = asset.marketCapUsd {
                        Text("Market Cap (USD): ")
                        Text("\(marketCapUsd)")
                    }
                }.font(.body)
                
                Group {
                    if let volumeUsd24Hr = asset.volumeUsd24Hr {
                        Text("Volume USD 24 Hours: ")
                        Text("\(volumeUsd24Hr)")
                    }
                }.font(.body)
                
                Group {
                    if let priceUsd = asset.priceUsd {
                        Text("Price (USD): ")
                        Text("\(priceUsd)")
                    }
                }.font(.body)
                
                Group {
                    if let changePercent24Hr = asset.changePercent24Hr {
                        Text("Percent Change 24 hours (USD): ")
                        Text("\(changePercent24Hr)")
                    }
                }.font(.body)
                
                Group {
                    if let vwap24Hr = asset.changePercent24Hr {
                        Text("Volume Weighted Average Price: ")
                        Text("\(vwap24Hr)")
                    }
                }.font(.body)
    
                
            }
            .navigationTitle(asset.name ?? "Unknown Asset")
        }
    }
