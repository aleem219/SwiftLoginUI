//
//  ToastView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 09/04/26.
//

import SwiftUI

struct ToastView: View {
    let message: String

       var body: some View {
           Text(message)
               .font(.system(size: 14))
               .foregroundColor(.white)
               .padding(.horizontal, 16)
               .padding(.vertical, 10)
               .background(Color.black.opacity(0.5))
               .cornerRadius(10)
       }
}

#Preview {
    ToastView(message: "Demo")
}
