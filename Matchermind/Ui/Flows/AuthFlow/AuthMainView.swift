//
//  AuthMainView.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import SwiftUI

struct AuthMainView<AuthServiceProxy: AuthServiceProtocol>: View {
    var body: some View {
        NavigationStack {
            LoginView<AuthServiceProxy>()
        }
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    let errorManager = ErrorManager()
    
    return AuthMainView<MockAuthService>()
        .environmentObject(mocAuth)
        .environmentObject(errorManager)
}
