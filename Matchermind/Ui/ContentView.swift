//
//  ContentView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct ContentView<AuthServiceProxy>: View where AuthServiceProxy: AuthServiceProtocol {
    @StateObject var authService: AuthServiceProxy
    
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
        
        .fullScreenCover(isPresented: Binding(
                    get: { authService.user == nil },
                    set: { _ in }
                )) {
                    LoginView<AuthService>()
                        .environmentObject(authService)
                }
        
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return ContentView<MockAuthService>(authService: mocAuth)
}
