//
//  ContentView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI
import Combine

struct ContentView<AuthServiceProxy>: View where AuthServiceProxy: AuthServiceProtocol {
    @StateObject var authService: AuthServiceProxy
    @State private var isFirstRun = true
    @State private var isLoading = true
    @State private var isAuthFlow = false
    
    var body: some View {
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
        
        .fullScreenCover(isPresented: $isLoading, content: {
            LoadingView()
        })
        
        .fullScreenCover(isPresented: $isAuthFlow, content: {
            LoginView<AuthService>()
                .environmentObject(authService)
        })
        
//        .fullScreenCover(isPresented: Binding(
//            get: { authService.user == nil },
//            set: { _ in }
//        )) {
//            LoginView<AuthService>()
//                .environmentObject(authService)
//        }
        
//        .fullScreenCover(isPresented: Binding(
//            get: { authService.user == nil && !isLoading},
//            set: { _ in }
//        )) {
//            LoginView<AuthService>()
//                .environmentObject(authService)
//        }
        
        .onAppear() {
            if isFirstRun {
                isFirstRun = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isLoading = false
                }
            }
        }
        
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return ContentView<MockAuthService>(authService: mocAuth)
}
