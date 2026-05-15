//
//  Products.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 15/05/26.
//

import Foundation

struct ProductResponse: Codable {
    let carts: [Cart]?
    let total: Int?
    let skip: Int?
    let limit: Int?
}

struct Cart: Codable {
    let id: Int?
    let products: [ProductItem]?
    let total: Double?
    let discountedTotal: Double?
    let userId: Int?
    let totalProducts: Int?
    let totalQuantity: Int?
}

struct ProductItem: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let quantity: Int?
    let total: Double?
    let discountPercentage: Double?
    let discountedTotal: Double?
    let thumbnail: String?
}
