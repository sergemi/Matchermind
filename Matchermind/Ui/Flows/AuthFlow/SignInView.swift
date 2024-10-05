//
//  LoginView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct SignInView<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject var authService: AuthServiceProxy
    @EnvironmentObject var errorManager: ErrorManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                
                TextField("Password", text: $password)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                
                Spacer()
                
                Button("Test Error") {
                    let error = testError()
                    errorManager.handleError(error)
                }
                
                NavigationLink {
                    SignUpView<AuthServiceProxy>()
                } label: {
                    Text("SignUp")
                        .padding()
                }
                
                Button {
                    Task {
                        do {
                            try await authService.login(email: email, password: password)
                        }
                        catch {
                            print(error)
                            print("!!!")
                        }
                    }
                } label: {
                    Text("Login")
                }
            }
//            .navigationBarBackButtonHidden()
            .withErrorAlert(errorManager: errorManager)
            .padding()
            
        }
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    let errorManager = ErrorManager()
    
    return SignInView<MockAuthService>()
        .environmentObject(mocAuth)
        .environmentObject(errorManager)
}
