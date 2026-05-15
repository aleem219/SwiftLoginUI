//
//  ProductService.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 15/05/26.
//
import Foundation
import Combine

class ProductService {
    @Published var productResponse: ProductResponse? = nil
    @Published var productError: Error? = nil
    
    private var productSubscription: AnyCancellable?
    
    func getCartList(skip: Int = 0, limit: Int) {
        guard let url = URL(string: "\(AppsNetworkManagerConstants.Endpoints.cart)") else { return }
        productSubscription = NetworkingManager.getMethod(url: url)
            .decode(type: ProductResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.productSubscription = nil
                case .failure(let error):
                    self?.productError = error
                    print("Cart list failed: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.productResponse = response
                print("Cart list: \(response.carts?.flatMap { $0.products ?? [] } ?? [])")
            })
    }
}
