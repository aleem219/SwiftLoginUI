//
//  CircleButtonView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 12/04/26.
//

import SwiftUI


struct CircleButtonView: View {
    let iconName: String
    var width: CGFloat = 30
    var height: CGFloat = 30
    var foregroundColor: Color = Color.theme.loginButton
    var backgroundColor: Color = Color.theme.loginButton
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(foregroundColor.opacity(0.3))
            .frame(width: width, height: height)
            .background(
                Circle()
                    .foregroundColor(backgroundColor.opacity(0.3))
            )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(iconName: "info")
}
