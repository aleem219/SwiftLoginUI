//
//  ProductViewModel.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 15/05/26.
//

import Foundation
import Combine
import Observation

@Observable
class ProductViewModel {
    
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    private(set) var errorMessage: String? = nil
    private(set) var carts: [Cart] = []
    private var currentSkip: Int = 0
    private let limit: Int = 30
    private var total: Int = 0
    var hasMore: Bool { carts.count < total }
    private let productService = ProductService()  // ✅ lowercase — was ProductService = ProductService() (name clash)
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindProductService()
    }
    
    func fetchCarts() async {
        currentSkip = 0
        isLoading = true
        productService.getCartList(skip: 0, limit: limit)  // ✅ productService (lowercase)
    }
    
    func fetchMoreCarts() async {
        guard hasMore, !isLoadingMore else { return }
        isLoadingMore = true
        currentSkip += limit
        productService.getCartList(skip: currentSkip, limit: limit)  // ✅ productService (lowercase)
    }
    
    private func bindProductService() {
        productService.$productResponse          // ✅ productService (lowercase)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self else { return }
                self.isLoading = false
                self.isLoadingMore = false
                self.total = response.total ?? 0
                let newCarts = response.carts ?? []
                if self.currentSkip == 0 {
                    self.carts = newCarts
                } else {
                    self.carts.append(contentsOf: newCarts)
                }
                self.saveThumbnails(carts: newCarts)
            }
            .store(in: &cancellables)
        
        productService.$productError             // ✅ productService (lowercase)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.isLoading = false
                self?.isLoadingMore = false
                self?.errorMessage = error.localizedDescription
            }
            .store(in: &cancellables)
    }
    
    private func saveThumbnails(carts: [Cart]) {
        let items = carts.flatMap { $0.products ?? [] }
        for item in items {
            guard let thumbnailUrl = item.thumbnail,
                  let id = item.id else { continue }
            LocalFileManager.instance.saveImageFromURL(
                imageUrl: thumbnailUrl,
                imageName: "\(id)",
                folderName: StringConstants.FolderNames.userImages
            )
        }
    }
}
