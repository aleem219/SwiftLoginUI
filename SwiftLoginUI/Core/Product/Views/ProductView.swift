//
//  ProductView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 07/04/26.
//

import SwiftUI

struct Product {
    let id: Int
    let title: String
    let price: Double
    let quantity: Int
    let total: Double
    let discountPercentage: Double
    let discountedTotal: Double
    let thumbnail: String
}

struct ProductView: View {
    
    let product = Product(
        id: 168,
        title: "Charger SXT RWD",
        price: 32999.99,
        quantity: 3,
        total: 98999.97,
        discountPercentage: 13.39,
        discountedTotal: 85743.87,
        thumbnail: "https://cdn.dummyjson.com/products/images/vehicle/Charger%20SXT%20RWD/thumbnail.png"
    )
    
    var body: some View {
        
        ZStack {
            List {
                ForEach(1...30, id: \.self) { _ in
                    VStack() {
                        VStack(alignment: .leading, spacing: 12) {
                            productRow(product: product)
                        }
                        .padding()
//                        .background(Color.theme.backGround)
                        HStack {
                            Text("Total:")
                                .font(.caption)
                            Spacer()
                            Text("₹\(product.discountedTotal, specifier: "%.0f")")
                                .font(.caption)
                                .fontWeight(.bold)
                        }
                        .padding(8)
                        .background(Color.theme.loginButton.gradient.opacity(0.5))
                    }
                    
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.theme.loginButton.opacity(0.5).gradient, lineWidth: 1)
                    )
                    .padding(.vertical, 8)
                }
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .contentMargins(.bottom, 0, for: .scrollContent) // iOS 17+
           
        }
        
//        .padding(.bottom, 30)
    }
    
    func productRow(product: Product) -> some View {
        
        HStack(spacing: 12) {
            
            UserImageView(
                imageUrl: product.thumbnail,
                imageName: "\(product.id)",
                width: 90,
                height: 90
            )
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(product.title)
                    .font(.headline)
                
                Text("₹\(product.price, specifier: "%.0f") x \(product.quantity)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Text("₹\(product.total, specifier: "%.0f")")
                    .strikethrough()
                    .foregroundColor(.gray)
                    .font(.subheadline)
                
                Text("\(product.discountPercentage, specifier: "%.0f")% OFF")
                    .foregroundColor(.red)
                    .font(.caption)
                
                Text("₹\(product.discountedTotal, specifier: "%.0f")")
                    .foregroundColor(Color.theme.loginButton)
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            Spacer()
        }
    }
}

#Preview {
    ProductView()
}
