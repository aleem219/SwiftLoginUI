//
//  ForgotPasswordView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 28/04/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.theme.backGround
                .ignoresSafeArea()
            
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                navigationBarLeadingItem
            }
            ToolbarItem(placement: .principal) {
                Text("Forgot Password")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.loginButton)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
    }
    
    private var navigationBarLeadingItem: some View {
        Button(
            action: {
                dismiss()
            },
            label: {
                HStack {
                    CircleButtonView(
                        iconName: "chevron.left",
                        width: 25,
                        height: 25,
                        foregroundColor: Color.theme.loginButton,
                        backgroundColor:Color.theme.backGround
                    )
                    .font(.headline)
                    .foregroundColor(Color.theme.loginButton)
                }
            })
        .accentColor(Color.theme.loginButton)
    }
    
    private var navigationBarTrailingItem: some View  {
        Button(
            action: {
            },
            label: {
                CircleButtonView(
                    iconName: "square.and.pencil",
                    width: 25,
                    height: 25,
                    foregroundColor: .loginButton,
                    backgroundColor:Color.theme.backGround
                )
            })
        .accentColor(Color.theme.loginButton)
    }
}

#Preview {
    ForgotPasswordView()
}
