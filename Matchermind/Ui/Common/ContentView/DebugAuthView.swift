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
                        _ = try await authService.signIn(email: MockAuthService.mocUserEmail,
                                                         password: MockAuthService.mocUserPassword
                        )
                    }
                }
            }
            else {
                Text("User: \(authService.user!.email)")
                
                Button("Logout") {
                    Task {
                        try authService.signOut()
                    }
                }
            }
        }
    }
}

#Preview("user logged in") {
    let mocAuth = MockAuthService.initWithMockUser(loginned: true)
    
    return DebugAuthView<MockAuthService>()
        .environmentObject(mocAuth)
}

#Preview("no user") {
    let mocAuth = MockAuthService.initWithMockUser(loginned: false)
    
    return DebugAuthView<MockAuthService>()
        .environmentObject(mocAuth)
}
