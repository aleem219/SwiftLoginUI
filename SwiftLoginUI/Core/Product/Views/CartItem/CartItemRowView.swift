//
//  ProductItemRowView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 15/05/26.
//

import Foundation
import SwiftUI

struct ProductItemRowView: View {
    
    let product: ProductItem
    
    var body: some View {
        HStack(spacing: 12) {
            UserImageView(
                imageUrl: product.thumbnail ?? "",
                imageName: "\(product.id ?? 0)",
                width: 90,
                height: 90
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title ?? "Unknown")
                    .font(.headline)
                
                Text("₹\(product.price ?? 0, specifier: "%.0f") x \(product.quantity ?? 0)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Text("₹\(product.total ?? 0, specifier: "%.0f")")
                    .strikethrough()
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Text("\(product.discountPercentage ?? 0, specifier: "%.0f")% OFF")
                    .foregroundColor(.red)
                    .font(.caption)
                
                Text("₹\(product.discountedTotal ?? 0, specifier: "%.0f")")
                    .foregroundColor(Color.theme.loginButton)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
}


#Preview {
    ProductItemRowView(product: ProductItem(
        id: 1,
        title: "iPhone 9",
        price: 549.99,
        quantity: 2,
        total: 1099.98,
        discountPercentage: 12.0,
        discountedTotal: 967.98,
        thumbnail: "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
    ))
}
