//
//  UserViewModel.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

import Foundation
import Combine
import Observation

@Observable
class UserViewModel {
    
    var isLoading: Bool = false
    var isLoadingMore: Bool = false
    private(set) var errorMessage: String? = nil
    private(set) var users: [User] = []
    private var currentSkip: Int = 0
    private let limit: Int = 30
    private var total: Int = 0
    var hasMore: Bool { users.count < total }
    private let userService = UserService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindUserService()
    }
    
    func fetchUsers() async{
        isLoading = true
        userService.getUser(skip: 0, limit: limit)
    }
    
    func fetchMoreUsers() async {
        guard hasMore, !isLoadingMore else { return }
        isLoadingMore = true
        currentSkip += limit
        userService.getUser(skip: currentSkip, limit: limit)
    }
    
    
    private func bindUserService() {
        userService.$userResponse
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let self else { return }
                self.isLoading = false
                self.isLoadingMore = false
                self.total = response.total ?? 0  // now total gets set!
                let newUsers = response.users ?? []
                if self.currentSkip == 0 {
                    self.users = newUsers
                } else {
                    self.users.append(contentsOf: newUsers)
                }
                self.saveUserImages(users: newUsers)
            }
            .store(in: &cancellables)
        
        userService.$userError
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.isLoading = false
                self?.isLoadingMore = false
                self?.errorMessage = error.localizedDescription
            }
            .store(in: &cancellables)
    }
    
    private func saveUserImages(users: [User]) {
        for user in users {
            guard let imageUrl = user.image else { continue }
            let imageName = "\(user.id)"
            LocalFileManager.instance.saveImageFromURL(
                imageUrl: imageUrl,
                imageName: imageName,
                folderName: "\(StringConstants.FolderNames.userImages)"
            )
        }
    }
}
