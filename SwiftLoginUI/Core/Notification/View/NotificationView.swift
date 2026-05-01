//
//  NotificationView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 14/04/26.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(NotificationViewModel.self) private var vm
    var body: some View {
        ScrollView {
              VStack(spacing: 16) {
                  Text("Hello, World!")
              }
              .padding()
          }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    navigationBarLeadingItem
                    
                }
            }
            .toolbarBackground(.clear, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
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
                        backgroundColor: Color.theme.backGround
                    )
                    Text("Notifications")
                        .font(.headline)
                        .foregroundColor(Color.theme.loginButton)
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.theme.loginButton)
            })
        .accentColor(Color.theme.loginButton)
    }
}

#Preview {
    NotificationView()
        .environment(NotificationViewModel())
}
