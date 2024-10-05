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
                DebugAuthView<AuthService>()
                MainTabBar()
            }
            .environmentObject(authService)
            .withErrorAlert(errorManager: errorManager)
            .environmentObject(errorManager)
            if authService.user == nil {
                LoginView<AuthService>()
                    .environmentObject(authService)
            }
            
            //            .fullScreenCover(isPresented: $viewModel.isAuthFlow, content: {
            //                LoginView<AuthService>()
            //                    .environmentObject(authService)
            //        })
            
            if viewModel.isLoading == true {
                LoadingView()
            }
        }
    }
}

#Preview("user logged in") {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return ContentView<MockAuthService>(authService: mocAuth)
}

#Preview("no user") {
    let mocAuth = MockAuthService()
    
    return ContentView<MockAuthService>(authService: mocAuth)
}
