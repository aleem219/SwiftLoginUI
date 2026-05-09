//
//  HomeListRow.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 08/05/26.
//

import Foundation
import SwiftUI

struct ItemRow: View {
    let item: Home

    var body: some View {
        HStack(spacing: 12) {
            Image(item.icon)
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(RoundedRectangle(cornerRadius: 6))

            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.body)
                    .foregroundColor(Color.theme.loginButton)
                    .fontWeight(.medium)
                   

                Text(item.subtitle)
                    .font(.caption)
                    .foregroundColor(Color.theme.loginButton)
                    .foregroundStyle(.secondary)
            
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
                .foregroundColor(Color.black)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    ItemRow(item: Home.mockData[0])
}
