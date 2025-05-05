//
//  ContentViewViewModel.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import Foundation
import Combine

class ContentViewViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isAuthFlow = false
    
    @Published private var authService: any AuthServiceProtocolOld
    private var cancellables = Set<AnyCancellable>()
    
    private let loadingSeconds = 5
    
    init(authService: any AuthServiceProtocolOld) {
        self.authService = authService
        setupBindings()
        startLoading()
    }
    
    private func setupBindings() {
        authService.userPublisher
            .sink { [weak self] user in
                guard let self = self else {
                    return
                }
                
                if user != nil {
                    self.isLoading = false
                    self.isAuthFlow = false
                }
                else if !self.isLoading {
                    self.isAuthFlow = true
                }
            }
            .store(in: &cancellables)
    }
    
    private func startLoading() {
        guard isLoading else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.isLoading = false
            self.isAuthFlow = (self.authService.user == nil)
        }
    }
}
