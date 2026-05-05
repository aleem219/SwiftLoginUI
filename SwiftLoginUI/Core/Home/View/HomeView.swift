//
//  HomeView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

import SwiftUI

struct HomeView: View {
    
    //    @Environment(LoginViewModel.self) private var vm
    
    var body: some View {
        
        ZStack {
                VStack {
                    Text("Lifecycle Demo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.loginButton)
                        .padding(.vertical,5)
                    Text("Understand with each \n method is called.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.loginButton)
                        .padding(.vertical,15)
                    lifecycleImage
                    Spacer()
                }

        }
    }
    
    private var lifecycleImage: some View {
        Image("\(StringConstants.ImageName.lifecycleImage)")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.height * 0.4)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: Color.theme.loginButton.opacity(0.5), radius: 5, x: -2, y: 2)
    }
}

#Preview {
    HomeView()
}
