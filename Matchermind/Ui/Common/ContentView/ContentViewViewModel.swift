//
//  ContentViewViewModel.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import Foundation
import Combine

class ContentViewViewModel<AuthServiceProxy: AuthServiceProtocol>: ObservableObject {
    @Published var isLoading = true
    @Published var isAuthFlow = false
    
    @Published private var authService: AuthServiceProxy
    private var cancellables = Set<AnyCancellable>()
    
    private let loadingSeconds = 5
    
    init(authService: AuthServiceProxy) {
        self.authService = authService
        setupBindings()
        startLoading()
    }
    
    private func setupBindings() {
        authService.userPublisher
            .sink { [weak self] user in
                if self?.isLoading == false {
                    self?.isAuthFlow = (user == nil)
                }
            }
            .store(in: &cancellables)
    }
    
    private func startLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.isLoading = false
            self.isAuthFlow = (self.authService.user == nil)
        }
    }
}
