//
//  LoginView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct LoginView<AuthServiceProxy>: View where AuthServiceProxy: AuthServiceProtocol {
    @EnvironmentObject var authService: AuthServiceProxy
    @StateObject private var errorManager = ErrorManager()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isSignUp = false
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack {
                Text("User: \(authService.user?.email)")
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
                
                Button("SignUp") {
                    isSignUp.toggle()
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
            .navigationBarBackButtonHidden()
            .withErrorAlert(errorManager: errorManager)
            .padding()
            
            .sheet(isPresented: $isSignUp) {
                SignupView()
                    .environmentObject(errorManager)
        }
        }
    }
}

#Preview {
    let mocAuth = MockAuthService(email: "aaa@gmail.com")
    
    return LoginView<MockAuthService>()
        .environmentObject(mocAuth)
}
