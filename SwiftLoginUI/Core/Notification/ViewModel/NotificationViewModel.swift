//
//  NotificationViewModel.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 14/04/26.
//


import Foundation
import Combine
import Observation

@Observable
class NotificationViewModel {
    
    var isLoading: Bool = false
    private(set) var errorMessage: String? = nil
    private(set) var notificationResponse: NotificationResponse?
    
    private let notificationService = NotificationService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindNotificationService()
    }
    func fetchUser() {
        isLoading = true
        notificationService.getUser()
    }
    
    private func bindNotificationService() {
        notificationService.$notificationResponse
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                guard let response else { return }
                self?.isLoading = false
                self?.notificationResponse = response
            }
            .store(in: &cancellables)
        
        notificationService.$notificationError
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
            }
            .store(in: &cancellables)
    }
}
