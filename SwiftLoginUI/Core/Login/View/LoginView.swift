//
//  LoginView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 02/04/26.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    @Environment(LoginViewModel.self) private var vm
    
    //    @Environment(UserViewModel.self) private var user
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack {
            Color.theme.backGround.ignoresSafeArea()
            
            VStack(spacing: 0) {
                loginImage
                VStack(spacing: 14) {
                    emailTextField
                    passwordField
                    Button {
                        vm.login()
                    } label: {
                        loginButton
                    }
                    .disabled(vm.isLoading)
                    .padding(.top, 4)
                    forgotPasswordView
                }
                .padding(.vertical, 25)
                .padding(.horizontal, 25)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            // Toast overlay sits above all content in the ZStack
            if showToast {
                VStack {
                    Spacer()
                    ToastView(message: toastMessage)
                        .transition(.slide)
                        .padding(.bottom, 100)
                }
                .ignoresSafeArea()
            }
        }
        .onChange(of: vm.errorMessage) { _, newValue in
            if let message = newValue, !message.isEmpty {
                toastMessage = message
                withAnimation {
                    showToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        showToast = false
                    }
                    vm.clearError()
                }
            }
        }
    }
    
    private var loginImage: some View {
        Image("\(StringConstants.ImageName.loginLogo)")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 300)
            .shadow(color: Color.theme.loginButton.opacity(0.5), radius: 20, x: -10, y: 12)
    }
    
    private var emailTextField: some View {
        @Bindable var vm = vm
        return HStack {
            Image(systemName: "\(StringConstants.ImageName.emailTextfieldImg)")
                .foregroundStyle(Color.secondary.opacity(0.7))
                .frame(width: 20)
            TextField("Enter username here", text: $vm.username)
                .tint(Color.secondary)
                .autocapitalization(.none)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        )
    }
    
    private var passwordField: some View {
        @Bindable var vm = vm
        return HStack {
            Image(systemName: "\(StringConstants.ImageName.passowrdTextfieldImg)")
                .foregroundStyle(Color.secondary.opacity(0.7))
                .frame(width: 20)
            SecureField("Enter password here", text: $vm.password)
                .tint(Color.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.gray.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
        )
    }
    
    private var loginButton: some View {
        HStack {
            if vm.isLoading {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(0.85)
                    .padding(.trailing, 6)
            }
            Text(vm.isLoading ? "Logging in..." : "Login")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme.loginButton.opacity(vm.isLoading ? 0.4 : 0.75))
        )
        .animation(.easeInOut(duration: 0.2), value: vm.isLoading)
    }
    
    private var forgotPasswordView: some View {
        HStack(spacing: 4) {
            Text("Forgotten your password?")
                .font(.subheadline)
                .foregroundStyle(Color.secondary.opacity(0.8))
            Button {
                print("Navigate to Forgot Password")
            } label: {
                Text("Click here")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.loginButton)
            }
        }
    }
    
    private var signupSignInView: some View {
        HStack(spacing: 4) {
            Text("Don't have an account?")
                .font(.subheadline)
                .foregroundStyle(Color.secondary.opacity(0.8))
            Button {
                print("Navigate to SignUp")
            } label: {
                Text("Sign Up here")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.loginButton)
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(LoginViewModel())
}
