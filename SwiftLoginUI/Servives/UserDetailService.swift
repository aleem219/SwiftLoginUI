//
//  UserDetailService.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 06/04/26.
//

import Foundation
import Combine

class UserDetailService {
    @Published var UserDetailResponse: UserDetail?
    @Published var userDetailError: Error? = nil
    private var userDetailSubscription: AnyCancellable?
    
    func getUserDetail(userId: Int) {
        
        let urlString = String(format: AppsNetworkManagerConstants.Endpoints.userDetail, userId)
        guard let url = URL(string: urlString) else { return }
        
        userDetailSubscription = NetworkingManager.getMethod(url: url)
            .decode(type: UserDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.userDetailSubscription = nil
                case .failure(let error):
                    self?.userDetailError = error
                    print("Get users failed: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] userDetailResponse in
                self?.UserDetailResponse = userDetailResponse
                //                self?.userSubscription?.cancel()
                print("Get users Deatil success: \(userDetailResponse)")
            })
    }
}
