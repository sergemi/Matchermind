//
//  BaseProfileViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import Foundation

@MainActor
final class ProfileViewModel: AuthViewModel {
    @Published var title = "Base profile"
    
    func detailed() {
        router.navigate(to: .profile(.statistics))
    }
    
    func close() {
        router.isShowingProfile = false
    }
    
    func logout() {
        Task {
            await authService.signOut()
        }
    }
}
