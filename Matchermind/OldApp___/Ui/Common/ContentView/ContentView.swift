//
//  ContentView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct LazyContentView<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject var authService: AuthServiceProxy

    var body: some View {
        ContentView<AuthServiceProxy>(viewModel: ContentViewViewModel(authService: authService))
            .environmentObject(authService)
    }
}

struct ContentView<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject var authService: AuthServiceProxy
    @StateObject private var errorManager = ErrorManager()
    @StateObject private var viewModel: ContentViewViewModel
    
    init(viewModel: ContentViewViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            
            VStack {
                Button("Test Error") {
                    let error = testError()
                    errorManager.handleError(error)
                }
//                DebugAuthView<AuthService>()
                MainTabBar<AuthServiceProxy>()
            }
            
            if authService.user == nil {
                AuthMainView<AuthServiceProxy>()
            }
            
            if viewModel.isLoading == true {
                LoadingView()
            }
        }
        .environmentObject(authService)
        .environmentObject(errorManager)
        .withErrorAlert(errorManager: errorManager)
    }
}

#Preview("user logged in") {
    let authService = MockAuthService.initWithMockUser(loginned: true)
    let coordinator = Coordinator<MockAuthService>()
    
    return LazyContentView<MockAuthService>()
        .environmentObject(authService)
        .environmentObject(coordinator)
}

#Preview("no user") {
    let authService = MockAuthService.initWithMockUser(loginned: false)
    let coordinator = Coordinator<MockAuthService>()
    
    return LazyContentView<MockAuthService>()
        .environmentObject(authService)
        .environmentObject(coordinator)
}
