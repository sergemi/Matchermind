//
//  ContentView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct ContentView<AuthServiceProxy: AuthServiceProtocol>: View {
    @StateObject var authService: AuthServiceProxy
    @StateObject private var viewModel: ContentViewViewModel<AuthServiceProxy>
    
    //    @State private var isFirstRun = true
    //    @State private var isLoading = true
    //    @State private var isAuthFlow = false
    
    init(authService: AuthServiceProxy) {
        _authService = StateObject(wrappedValue: authService)
        _viewModel = StateObject(wrappedValue: ContentViewViewModel(authService: authService))
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if authService.user == nil {
                        Text("No user")
                        
                        Button("Login") {
                            Task {
                                _ = try await authService.login(email: "tester1@gmail.com",
                                                                password: "tester1!"
                                )
                            }
                        }
                    }
                    else {
                        Text("User: \(authService.user!.email)")
                        
                        Button("Logout") {
                            Task {
                                try authService.logOut()
                            }
                        }
                    }
                }
                MainTabBar()
            }
            .environmentObject(authService)
            
    //        .fullScreenCover(isPresented: $viewModel.isLoading, content: {
    //            LoadingView()
    //        })
            
            .fullScreenCover(isPresented: $viewModel.isAuthFlow, content: {
                LoginView<AuthService>()
                    .environmentObject(authService)
        })
            
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
