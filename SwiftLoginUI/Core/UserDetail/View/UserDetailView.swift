//
//  UserDetailView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 06/04/26.
//

import SwiftUI

struct UserDetailView: View {
    
    let userID: Int
    @Environment(UserDetailViewModel.self) private var vm
    @Environment(LoginViewModel.self) private var vmUser
    @Environment(\.dismiss) var dismiss
    @State private var isMatched:Bool = false
    @State private var showLogoutAlert: Bool = false
    
    private let avatarSize: CGFloat = 110
    
    var body: some View {
        ZStack {
            Color.theme.backGround
                .ignoresSafeArea()
            
            if vm.isLoading {
                ProgressView()
                    .tint(Color.theme.loginButton)
                    .frame(width: 40,height: 40)
            } else if let error = vm.errorMessage {
                Text(error)
                    .foregroundStyle(.white)
            } else {
                VStack(spacing: 0) {
                    UserImageView(
                        imageUrl: "\(vm.userDetail?.image ?? "")",
                        imageName: "\(vm.userDetail?.id ?? 0)",
                        width: avatarSize,
                        height: avatarSize
                    )
                    .overlay { Color.theme.backGround.opacity(0.3) }
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    .padding(.bottom, -avatarSize / 2)
                    .zIndex(1)
                    
                    // White Card
                    VStack(spacing: 0) {
                        
                        Spacer()
                            .frame(height: avatarSize / 2 + 24)
                        
                        VStack(spacing: 16) {
                            ProfileField(
                                label: "Full Name",
                                value: [
                                    vm.userDetail?.firstName,
                                    vm.userDetail?.maidenName,
                                    vm.userDetail?.lastName
                                ]
                                    .compactMap { $0 }
                                    .joined(separator: " ")
                            )
                            ProfileField(label: "Email",            value: vm.userDetail?.email   ?? "")
                            ProfileField(label: "Company name", value: vm.userDetail?.company.name ?? "")
                            ProfileField(label: "Phone",         value: vm.userDetail?.phone ?? "", isSecure: false)
                            ProfileField(label: "Role", value: vm.userDetail?.role ?? "")
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            if vm.userDetail?.role == "admin" {
                                logoutButton
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                    .frame(maxHeight: vm.userDetail?.role == "admin" ? 450 : 400)
                    .background(Color.theme.backGround)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.theme.loginButton.opacity(0.1), lineWidth: 2)
                    }
                    
                    .padding(.horizontal, 16)
                    .zIndex(0)
                }
                .redacted(reason: vm.isLoading ? .placeholder : [])
                
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                navigationBarLeadingItem
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if vm.userDetail?.role == "admin" {
                    navigationBarTrailingItem
                }
            }
        }
        .toolbarBackground(Color.theme.backGround, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await vm.fetchUser(userId: userID)
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
                    Text(
                        [
                            vm.userDetail?.firstName,
                            vm.userDetail?.lastName
                        ]
                            .compactMap { $0 }
                            .joined(separator: " ")
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
    
    private var logoutButton: some View {
        Button(action: { showLogoutAlert = true }) {
            HStack(spacing: 8) {
                Spacer()
                Text("Log out")
                    .font(.headline)
                    .fontWeight(.medium)
                Image(systemName: "arrow.right.square")
                    .font(.system(size: 13))
                Spacer()
            }
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.theme.loginButton)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.theme.loginButton.opacity(0.3), lineWidth: 1.5)
            )
        }
        .showAlert(isPresented: $showLogoutAlert, type: .destructive(
            title: "Log Out",
            message: "Are you sure you want to log out?",
            confirmTitle: "Yes",
            onConfirm: { vmUser.logout() }
        ))

    }
}

// MARK: - Reusable Field Component
struct ProfileField: View {
    let label: String
    let value: String
    var isSecure: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray5), lineWidth: 1)
            
            HStack {
                Text(isSecure ? "••••••••••" : value)
                    .font(.system(size: 14))
                    .foregroundStyle(Color(.label))
                    .lineLimit(1)
                Spacer()
                if isSecure {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(.systemGray3))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundStyle(Color(.systemGray2))
                .padding(.horizontal, 4)
                .background(Color.theme.backGround)
                .offset(x: 10, y: -8)
        }
        .frame(height: 48)
    }
}

#Preview {
    UserDetailView(userID: 2)
        .environment(UserDetailViewModel())
        .environment(LoginViewModel())
}
