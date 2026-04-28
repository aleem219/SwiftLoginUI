//
//  UserView.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

import SwiftUI

struct UserView: View {
    
    @Environment(UserViewModel.self) private var vm
    
    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()
            if vm.isLoading {
                ProgressView()
            } else if let error = vm.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            } else {
                List {
                    ForEach(vm.users, id: \.id) { user in
                        ZStack {
                            NavigationLink(value: user) { EmptyView() }.opacity(0)
                            HStack {
                                UserImageView(imageUrl: user.image, imageName: "\(user.id)")
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(user.firstName ?? "") \(user.maidenName ?? "") \(user.lastName ?? "")")
                                        .font(.headline)
                                        .foregroundColor(Color.theme.backGround)
                                    Text(user.email ?? "")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.theme.backGround)
                                    Text("phone: \(user.phone ?? "")")
                                        .font(.callout)
                                        .fontWeight(.light)
                                        .foregroundColor(Color.theme.backGround)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .onAppear {
                                if user.id == vm.users.last?.id {
                                    Task { await vm.fetchMoreUsers() }
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    
                    // Bottom loading spinner
                    if vm.isLoadingMore {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .listRowBackground(Color.clear)
                    }
                }
                .buttonStyle(.plain)
                .navigationDestination(for: User.self) { user in
                    UserDetailView(userID: user.id)
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .listRowSpacing(4)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
        }
        .task {
            if vm.users.isEmpty {
                await vm.fetchUsers()
            }
        }
    }
}

#Preview {
    UserView()
        .environment(UserViewModel())
}
