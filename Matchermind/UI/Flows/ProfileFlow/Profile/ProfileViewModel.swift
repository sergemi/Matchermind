//
//  BaseProfileViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

@MainActor
final class ProfileViewModel: DataViewModel {
    var title = "Base profile"
    
    func detailed() {
        router.navigate(to: .profile(.statistics))
    }
    
    func editQuickModule(preload: ModulePreload) {
        router.navigate(to: .profile(.editQuickModule(preload: preload)))
    }
    
    func close() {
        router.isShowingProfile = false
    }
    
    func logout() {
        Task {
            try await authService.signOut()
        }
    }
}
