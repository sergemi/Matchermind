//
//  DebugAuthView.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import SwiftUI

struct DebugAuthView<AuthServiceProxy: AuthServiceProtocolOld>: View {
    @EnvironmentObject var authService: AuthServiceProxy
    
    var body: some View {
        HStack {
            if authService.user == nil {
                Text("No user")
                
                Button("Login") {
                    Task {
                        _ = try await authService.signIn(email: MockAuthServiceOld.mocUserEmail,
                                                         password: MockAuthServiceOld.mocUserPassword
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
    let mocAuth = MockAuthServiceOld.initWithMockUser(loginned: true)
    
    return DebugAuthView<MockAuthServiceOld>()
        .environmentObject(mocAuth)
}

#Preview("no user") {
    let mocAuth = MockAuthServiceOld.initWithMockUser(loginned: false)
    
    return DebugAuthView<MockAuthServiceOld>()
        .environmentObject(mocAuth)
}
