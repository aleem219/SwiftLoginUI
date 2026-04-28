//
//  UserDetailViewModel.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 06/04/26.
//

import Foundation
import Combine
import Observation

@Observable
class UserDetailViewModel {
    
    var isLoading: Bool = false
    private(set) var errorMessage: String? = nil
    private(set) var userDetail: UserDetail?
    
    private let userService = UserDetailService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindUserService()
    }
    
    func fetchUser(userId: Int) async {
        isLoading = true
//        try? await Task.sleep(nanoseconds: 1_000_000_000)
        userService.getUserDetail(userId: userId)
    }
    
    private func bindUserService() {
        userService.$UserDetailResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let response else { return } 
                self?.isLoading = false
                self?.userDetail = response
                self?.saveUserImage(user: response)
            }
            .store(in: &cancellables)
        
        userService.$userDetailError
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
            }
            .store(in: &cancellables)
    }
    
    private func saveUserImage(user: UserDetail) {
        guard let imageUrl = user.image else { return }
        let imageName = "\(user.id)"
        LocalFileManager.instance.saveImageFromURL(
            imageUrl: imageUrl,
            imageName: imageName,
            folderName: "\(StringConstants.FolderNames.userDetailImages)"
        )
    }
}
