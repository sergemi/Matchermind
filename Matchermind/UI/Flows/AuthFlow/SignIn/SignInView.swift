//
//  LoginView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject private var errorManager: ErrorManager
    
    
    var body: some View {
        SignInContentView(viewModel: SignInViewModel(router: router,
                                                   authService: authService,
                                                   errorManager: errorManager))
    }
}

struct SignInContentView: View {
    @StateObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            GoogleSignInButton(style: .standard) {
                viewModel.continueWithGoogle()
            }
            
//            Button {
//                viewModel.continueWithGoogle()
//            } label: {
//                Image(.continueWithGoogle)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 400, height: 48)
//            }

            
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
            
            Spacer()
        }
        .padding()
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    
    let errorMgr = ErrorManager()
    withMockEnvironment(loginned: false) {
        SignInView()
            .environmentObject(errorMgr)
            .withErrorAlert(errorManager: errorMgr)
    }
}
