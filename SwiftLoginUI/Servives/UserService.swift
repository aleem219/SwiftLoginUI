//
//  UserService.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 04/04/26.
//

import Foundation
import Combine

class UserService {
    @Published var userResponse:  UserResponse? = nil
    @Published var userError: Error? = nil

    private var userSubscription: AnyCancellable?
    
    
    func getUser(skip: Int = 0, limit: Int) {
        
        guard let url = URL(string: "\(AppsNetworkManagerConstants.Endpoints.users)") else { return }
        userSubscription = NetworkingManager.getMethod(url: url)
            .decode(type: UserResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.userSubscription = nil
                case .failure(let error):
                    self?.userError = error
                    print("Get users failed: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] userResponse in
                self?.userResponse = userResponse
//                self?.userSubscription?.cancel()
                print("Get users success: \(userResponse.users ?? [])")
            })
    }
}
