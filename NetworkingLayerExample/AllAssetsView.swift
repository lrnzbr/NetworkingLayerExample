//
//  ContentView.swift
//  NetworkingLayerExample
//
//  Created by Lorenzo Brown on 7/23/24.
//

import SwiftUI

struct AllAssetsView: View {
    @StateObject private var viewModel = AllAssetsViewModel()

    var body: some View {
        if viewModel.hasErrorMessage {
            Text("Error Loading Content")
            Text(viewModel.errorMessage ?? "")
            Button("Try Again"){
                viewModel.hasErrorMessage = false
                viewModel.fetchAssets()
            }
        } else {
            NavigationView {
                List(viewModel.cryptoAssets) { asset in
                    NavigationLink(destination: AssetDetailView(asset: asset), label: {
                        
                        VStack(alignment: .leading) {
                            Text(asset.name ?? "Name not found")
                                .font(.headline)
                            Text(asset.symbol ?? "Symbol not found")
                                .font(.subheadline)
                        }
                    })
                }
                .navigationTitle("Crypto Assets")
                .onAppear {
                    viewModel.fetchAssets()
                }
                
                
            }
        }
    }
}

#Preview {
    AllAssetsView()
}


