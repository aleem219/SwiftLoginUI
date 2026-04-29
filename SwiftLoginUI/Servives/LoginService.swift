//
//  LoginService.swift
//  SwiftLoginUI
//
//  Created by Abdul Aleem on 02/04/26.
//

import Foundation
import Combine

class LoginService {
    
    @Published var loginResponse: LoginModel.Response? = nil
    @Published var loginError: Error? = nil
    @Published var showNoInternetAlert: Bool = false
    private let networkMonitor = NetworkMonitor.shared
    private var loginSubscription: AnyCancellable?
    
    func login(username: String, password: String) {
        
        guard networkMonitor.isConnected else {
            showNoInternetAlert = true
            print("Login aborted: No internet connection.")
            return
        }
        
        
        guard let url = URL(string: "\(AppsNetworkManagerConstants.Endpoints.login)") else { return }
        
        let requestBody = LoginModel.createRequestBody(username: username, password: password)
        
        loginSubscription = NetworkingManager.postMethod(url: url, body: requestBody)
            .decode(type: LoginModel.Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loginSubscription = nil
                case .failure(let error):
                    self?.loginError = error
                    print("Login failed: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] returnedResponse in
                self?.loginResponse = returnedResponse
                //                self?.loginSubscription?.cancel()
                print("Login Success - received data from \(LoginModel.self) is: \n\(returnedResponse)\n")
            })
    }
}
