//
//  LoginView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(ErrorManager.self) var errorMgr
    
    var body: some View {
        SignInContentView(errorMgr: errorMgr,
                          router: router,
                          authService: authService)
    }
}

struct SignInContentView: View {
    @State var viewModel: SignInViewModel
    
    init(errorMgr: ErrorManager?, router: AppRouter, authService: AuthService) {
        _viewModel = State(initialValue: SignInViewModel(errorMgr: errorMgr,
                                                         router: router,
                                                         authService: authService))
    }
    
    var body: some View {
        ScrollView{
            VStack(spacing: 24) {
                AppleSignInMocButton()
                
                GoogleSignInButton(style: .standard) {
                    viewModel.continueWithGoogle()
                }
                
                Text("Or")
                
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
}

#Preview {
    withMockEnvironment(loginned: false) {
        SignInView()
    }
}
