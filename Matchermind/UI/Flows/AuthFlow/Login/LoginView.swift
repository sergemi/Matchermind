//
//  LoginView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject private var errorManager: ErrorManager
    
    
    var body: some View {
        LoginContentView(viewModel: LoginViewModel(router: router,
                                                   authService: authService,
                                                   errorManager: errorManager))
    }
}

struct LoginContentView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            
            DefaultTextField(text: $viewModel.email, placeholder: viewModel.emailHint, title: viewModel.emailTitle)
            
            DefaultTextField(text: $viewModel.password, placeholder: viewModel.passwordHint, title: viewModel.passwordTitle)
            
            Button("Sign in") {
                viewModel.signIn()
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)
            
            HStack {
                Text("Don't have account yet?")
                
                Button("Sign up!") {
                    viewModel.signUp()
                }
            }
            
//                HStack { // reset password
//                    Spacer()
//
//                    NavigationLink
//                }
            
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.title)
        
//        VStack {
//            Text("Login screen")
//            Button("signIn") {
//                viewModel.signIn()
//            }
//            Spacer()
//            Button("Test error") {
//                viewModel.showTestError()
//            }
//            Button("Register") {
//                viewModel.register()
//            }
//        }
//        .navigationTitle(viewModel.title)
//
    }
}

#Preview {
    let errorMgr = ErrorManager()
    withMockEnvironment(loginned: false) {
        LoginView()
            .environmentObject(errorMgr)
    }
}
