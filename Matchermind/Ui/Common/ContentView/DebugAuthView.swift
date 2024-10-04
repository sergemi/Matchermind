//
//  DebugAuthView.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import SwiftUI

struct DebugAuthView<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject var authService: AuthServiceProxy
    
    var body: some View {
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
    }
}

#Preview("user logged in") {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return DebugAuthView<MockAuthService>()
        .environmentObject(mocAuth)
}

#Preview("no user") {
    let mocAuth = MockAuthService()
    
    return DebugAuthView<MockAuthService>()
        .environmentObject(mocAuth)
}
