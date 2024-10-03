//
//  LoginView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct LoginView<AuthServiceProxy>: View where AuthServiceProxy: AuthServiceProtocol {
    @EnvironmentObject var authService: AuthServiceProxy
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("User: \(authService.user?.email)")
            TextField("Email", text: $email)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            
            
            TextField("Password", text: $password)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            
            Spacer()
            
            Button {
                Task {
                    try await authService.login(email: email, password: password)
                }
            } label: {
                Text("Login")
            }
        }
        .padding()
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return LoginView<MockAuthService>()
        .environmentObject(mocAuth)
}
