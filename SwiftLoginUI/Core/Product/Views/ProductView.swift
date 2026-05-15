//
//  ProductView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 07/04/26.
//


import SwiftUI

struct ProductView: View {
    
    @Environment(ProductViewModel.self) private var vm
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            if vm.isLoading {
                ProgressView()
            } else if let error = vm.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            } else {
                List {
                    ForEach(vm.carts, id: \.id) { product in
                        VStack {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(product.products ?? [], id: \.id) { item in
                                    ProductItemRowView(product: item)
                                }
                            }
                            .padding()
                            bottomProductView(product: product)
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
                .contentMargins(.bottom, 0, for: .scrollContent)
            }
        }
        .task {
            await vm.fetchCarts()
        }
    }
    
    private func bottomProductView(product: Product) -> some View {
        HStack {
            Text("Total:")
                .font(.caption)
            Spacer()
            Text("₹\(product.discountedTotal ?? 0, specifier: "%.0f")")
                .font(.caption)
                .fontWeight(.bold)
        }
        .padding(8)
        .background(Color.theme.loginButton.gradient.opacity(0.5))
    }
}

#Preview {
    ProductView()
        .environment(ProductViewModel())
}
