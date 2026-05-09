//
//  Home.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 08/05/26.
//

import Foundation

struct Home: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let icon: String
    
    init(id: UUID = UUID(), title: String, subtitle: String, icon: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
}

extension Home {
    static let mockData: [Home] = [
        Home(title: "Fetch Data", subtitle: "Loaad or refresh content", icon: StringConstants.ImageName.passowrdTextfieldImg),
        Home(title: "Update UI", subtitle: "Keep UI in sync", icon: StringConstants.ImageName.passowrdTextfieldImg),
        Home(title: "Analytic", subtitle: "Track screen visibiltty", icon: StringConstants.ImageName.passowrdTextfieldImg),
    ]
}
