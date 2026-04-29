//
//  LoginViewModel.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation
import Combine
import Observation

@Observable
class LoginViewModel {
    
    // MARK: - Input
    var username: String = ""
    var password: String = ""
    
    // MARK: - Output
    var isLoading: Bool = false
    private(set) var errorMessage: String? = nil
    private(set) var loggedInUser: LoginModel.Response? = nil
    private(set) var isLoggedIn: Bool = UserDefaults.standard.bool(
        forKey: StringConstants.UserDefaultKeys.kIsUserLoggedIn
    )
    
    // MARK: - Private
    private let loginService = LoginService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    // MARK: - Public
    func login() {
        guard isValidInput() else { return }
        isLoading = true
        errorMessage = nil
        loginService.login(username: username, password: password)
    }
    
    func logout() {
        isLoggedIn = false
        loggedInUser = nil
        username = ""
        password = ""
        UserDefaults.standard.set(false, forKey: StringConstants.UserDefaultKeys.kIsUserLoggedIn)
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    // MARK: - Private
    private func addSubscribers() {
        
        loginService.$loginResponse
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                self?.handleLoginResponse(response)
            }
            .store(in: &cancellables)
        
        loginService.$loginError
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.handleLoginError(error)
            }
            .store(in: &cancellables)
        
        loginService.$showNoInternetAlert
            .filter { $0 == true }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    private func handleLoginResponse(_ response: LoginModel.Response) {
        isLoading = false
        
        if let message = response.message, !message.isEmpty {
            errorMessage = message
            isLoggedIn = false
        } else {
            loggedInUser = response
            isLoggedIn = true
            UserDefaults.standard.set(true, forKey: StringConstants.UserDefaultKeys.kIsUserLoggedIn)
        }
    }
    
    private func handleLoginError(_ error: Error) {
        isLoading = false
        if let networkError = error as? NetworkingManager.NetworkingError {
            switch networkError {
            case .unauthorized:
                errorMessage = "\(StringConstants.AuthorizationFailedMsg.incorrectAuth)"
                
            case .badUrlResponse:
                errorMessage = "\(StringConstants.AuthorizationFailedMsg.serverError)"
            case .unknown:
                errorMessage = "\(StringConstants.AuthorizationFailedMsg.somethingWentWrong)"
            }
        } else {
            errorMessage = "\(StringConstants.AuthorizationFailedMsg.somethingWentWrong)"
        }
    }
    
    private func isValidInput() -> Bool {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "\(StringConstants.ValidInputdMsg.emptyUserNme)"
            return false
        }
        guard !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "\(StringConstants.ValidInputdMsg.emptyPassword)"
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "\(StringConstants.ValidInputdMsg.passwordLength)"
            return false
        }
        return true
    }
}
