//
//  NotificationService.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 14/04/26.
//

import Foundation
import Combine

class NotificationService {
    @Published var notificationResponse:  NotificationResponse? = nil
    @Published var notificationError: Error? = nil

    private var notificationSubscription: AnyCancellable?
    
    
    func getUser() {
        
        guard let url = URL(string: "\(AppsNetworkManagerConstants.Endpoints.notification)") else { return }
        notificationSubscription = NetworkingManager.getMethod(url: url)
            .decode(type: NotificationResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.notificationSubscription = nil
                case .failure(let error):
                    self?.notificationError = error
                    print("Get users failed: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] userResponse in
                self?.notificationResponse = userResponse
//                self?.notificationSubscription?.cancel()
                print("Get users success: \(userResponse.notifications ?? [])")
            })
    }
}
