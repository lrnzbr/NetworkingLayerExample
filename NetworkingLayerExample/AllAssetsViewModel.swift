//
//  AllAssetsViewModel.swift
//  NetworkingLayerExample
//
//  Created by Lorenzo Brown on 7/23/24.
//

import Foundation

final class AllAssetsViewModel: ObservableObject {
    @Published var cryptoAssets: [CryptoAsset] = []
    @Published var errorMessage: String?
    @Published var hasErrorMessage: Bool = false
    
    private let networkService = NetworkingLayer()
    
    
    
    
    func fetchAssets(){
        let request = AssetsRequest()
        networkService.performRequest(request) { [weak self] (result: Result<CryptoAssets, NetworkError>) in
                 DispatchQueue.main.async {
                     switch result {
                     case .success(let cryptoAssets):
                         self?.cryptoAssets = cryptoAssets.data
                     case .failure(let error):
                         switch error {
                         case .requestFailed:
                             self?.errorMessage = "Request failed"
                         case .unknown:
                             self?.errorMessage = "Unknown error"
                         }
                         self?.hasErrorMessage = true
                     }
                 }
             }
         }
    
     }
