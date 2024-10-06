//
//  LoginView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct SignInView<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var authService: AuthServiceProxy
    
    @StateObject var viewModel = SignInViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    
//    init(authService: AuthServiceProxy) {
    /*
    init() {
//        _authService = StateObject(wrappedValue: authService)
        _viewModel = StateObject(wrappedValue: SignInViewModel(errorManager: ErrorManager()))
    }
     */
    
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
//                    let error = testError()
//                    errorManager.handleError(error)
                    
                    viewModel.test()
                }
                
                Button("Test Error 2") {
                    let error = testError2()
                    errorManager.handleError(error)
                }
                
//                NavigationLink {
//                    SignUpView()
//                } label: {
//                    Text("SignUp")
//                        .padding()
//                }
                
                Button {
                    Task {
//                        try await viewModel.signIn(email: email, password: password)
                        
                        do {
//                            try await authService.signIn(email: email, password: password)
                            try await viewModel.signIn(email: email, password: password)
                        }
                        catch {
                            print(error)
                            
                            errorManager.handleError(error)
                        }
                    }
                } label: {
                    Text("Login")
                }
            }
//            .navigationBarBackButtonHidden()
            .padding()
            
//            .onAppear() {
            .task {
                viewModel.setDependencies(errorManager: errorManager,
                authService: authService)
            }
            
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
