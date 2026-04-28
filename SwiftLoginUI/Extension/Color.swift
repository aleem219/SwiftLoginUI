//
//  Color.swift
//  Cryptara
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation
import SwiftUI


extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let backGround = Color("\(StringConstants.Colors.backGround)")
    let loginButton = Color("\(StringConstants.ButtonColors.loginButton)")
}

struct LaunchTheme  {
    let accent = Color("\(StringConstants.Colors.accent)")
    let backGround = Color("\(StringConstants.Colors.backGroundLaunchColor)")
}
