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
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300,height: 300)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
