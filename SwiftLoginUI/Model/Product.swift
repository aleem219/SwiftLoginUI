//
//  Product.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 08/04/26.
//

import Foundation


struct Product2: Codable,Hashable {
    let id: Int
    let title: String
    let price: Double
    let quantity: Int
    let total: Double
    let discountPercentage: Double
    let discountedTotal: Double
    let thumbnail: String
}


extension Product2 {
    init() {
        self.id = 0
        self.title = "Test"
        self.price = 21.0
        self.quantity = 3
        self.total = 5
        self.discountPercentage = 2.0
        self.discountedTotal = 13.0
        self.thumbnail = "test@test.com"
    }
}
