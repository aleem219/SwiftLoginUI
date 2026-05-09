//
//  HomeView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

import SwiftUI

struct HomeView: View {

    @State private var items: [Home] = Home.mockData
    @State private var selectedItem: Home?

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                Text("Lifecycle Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.loginButton)
                    .padding(.vertical, 10)

                Text("Understand which\nmethod is called.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.theme.loginButton)
                    .padding(.vertical, 10)
                
                lifecycleImage
                    .padding(.bottom, 16)
                VStack(spacing: 0) {
                    ForEach(items) { item in
                        ItemRow(item: item)
                            .padding(.horizontal, 16)
                            .background(
                                selectedItem?.id == item.id
                                    ? Color.theme.loginButton.opacity(0.1)
                                    : Color.clear
                            )
                            .onTapGesture {
                                selectedItem = item
                            }

                        if item.id != items.last?.id {
                            Divider()
                                .padding(.leading, 16)
                        }
                    }
                }
                .overlay(Color.theme.backGround.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
               
               
            }
        }
        .scrollIndicators(.hidden)
    }
    
    
    private var lifecycleImage: some View {
        Image(StringConstants.ImageName.lifecycleImage)
            .resizable()
            .scaledToFill()
            .frame(
                width: UIScreen.main.bounds.width - 24,
                height: UIScreen.main.bounds.height * 0.40
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: Color.theme.loginButton.opacity(0.5), radius: 5, x: -2, y: 2)
    }
}

#Preview {
    HomeView()
}
