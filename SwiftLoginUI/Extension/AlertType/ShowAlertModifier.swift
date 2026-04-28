//
//  ShowAlertModifier.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 09/04/26.
//

import SwiftUI

// MARK: - Alert Types
enum AppAlertType {
    case confirmation(
        title: String,
        message: String,
        confirmTitle: String = "Yes",
        cancelTitle: String = "Cancel",
        onConfirm: () -> Void
    )
    case destructive(
        title: String,
        message: String,
        confirmTitle: String = "Delete",
        cancelTitle: String = "Cancel",
        onConfirm: () -> Void
    )
    case info(
        title: String,
        message: String,
        dismissTitle: String = "OK"
    )
    case warning(
        title: String,
        message: String,
        confirmTitle: String = "Proceed",
        cancelTitle: String = "Cancel",
        onConfirm: () -> Void
    )
}

// MARK: - Alert Modifier
struct ShowAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let alertType: AppAlertType
    
    func body(content: Content) -> some View {
        switch alertType {
            
        case .confirmation(let title, let message, let confirmTitle, let cancelTitle, let onConfirm):
            content.alert(title, isPresented: $isPresented) {
                Button(confirmTitle) { onConfirm() }
                Button(cancelTitle, role: .cancel) { }
            } message: {
                Text(message)
            }
            
        case .destructive(let title, let message, let confirmTitle, let cancelTitle, let onConfirm):
            content.alert(title, isPresented: $isPresented) {
                Button(confirmTitle, role: .destructive) { onConfirm() }
                Button(cancelTitle, role: .cancel) { }
            } message: {
                Text(message)
            }
            
        case .info(let title, let message, let dismissTitle):
            content.alert(title, isPresented: $isPresented) {
                Button(dismissTitle, role: .cancel) { }
            } message: {
                Text(message)
            }
            
        case .warning(let title, let message, let confirmTitle, let cancelTitle, let onConfirm):
            content.alert(title, isPresented: $isPresented) {
                Button(confirmTitle, role: .destructive) { onConfirm() }
                Button(cancelTitle, role: .cancel) { }
            } message: {
                Text(message)
            }
        }
    }
}

#Preview {
    Text("Preview")
        .showAlert(
            isPresented: .constant(true),
            type: .info(title: "Hi", message: "How are you", dismissTitle: "Dismiss")
        )
}

// MARK: - View Extension
extension View {
    func showAlert(isPresented: Binding<Bool>, type: AppAlertType) -> some View {
        self.modifier(
            ShowAlertModifier(
                isPresented: isPresented,
                alertType: type
            )
        )
    }
}
