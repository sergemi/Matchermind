//
//  ContentView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct ContentView<AuthServiceProxy: AuthServiceProtocol>: View {
    @StateObject var authService: AuthServiceProxy
    @StateObject private var errorManager = ErrorManager()
    @StateObject private var viewModel: ContentViewViewModel<AuthServiceProxy>
    
    init(authService: AuthServiceProxy) {
        _authService = StateObject(wrappedValue: authService)
        _viewModel = StateObject(wrappedValue: ContentViewViewModel(authService: authService))
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                Button("Test Error") {
                    let error = testError()
                    errorManager.handleError(error)
                }
//                DebugAuthView<AuthService>()
                MainTabBar()
            }
            
            if authService.user == nil {
                AuthMainView<AuthService>()
            }
            
            if viewModel.isLoading == true {
                LoadingView()
            }
        }
        .environmentObject(authService)
//        .withErrorAlert(errorManager: errorManager)
        .environmentObject(errorManager)
        .withErrorAlert(errorManager: errorManager)
    }
}

#Preview("user logged in") {
    let mocAuth = MockAuthService.initWithMockUser(loginned: true)
    let coordinator = Coordinator()
    
    return ContentView<MockAuthService>(authService: mocAuth)
        .environmentObject(coordinator)
}

#Preview("no user") {
    let mocAuth = MockAuthService.initWithMockUser(loginned: false)
    let coordinator = Coordinator()
    
    return ContentView<MockAuthService>(authService: mocAuth)
        .environmentObject(coordinator)
}
