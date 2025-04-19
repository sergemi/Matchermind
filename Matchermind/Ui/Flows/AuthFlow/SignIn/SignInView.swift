//
//  LoginView.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct SignInView<AuthServiceProxy: AuthServiceProtocol>: View {
    @EnvironmentObject private var errorManager: ErrorManager
    @EnvironmentObject private var authService: AuthServiceProxy
    
    @StateObject private var viewModel = SignInViewModel()
    
    //    init(authService: AuthServiceProxy) {
    /*
     init() {
     //        _authService = StateObject(wrappedValue: authService)
     _viewModel = StateObject(wrappedValue: SignInViewModel(errorManager: ErrorManager()))
     }
     */
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
            VStack(spacing: 24) {
                
                DefaultTextField(text: $viewModel.email, placeholder: viewModel.emailHint, title: viewModel.emailTitle)
                
                DefaultTextField(text: $viewModel.password, placeholder: viewModel.passwordHint, title: viewModel.passwordTitle)
                
                Button("Sign in") {
                    viewModel.signIn(email: viewModel.email, password: viewModel.password)
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
                //                .buttonStyle(GhostButtonStyle())
                
                HStack {
                    Text("Don't have account yet?")
                    
                    NavigationLink {
                        SignUpView<AuthServiceProxy>()
                    } label: {
                        Text("Sign Up!")
                            .padding()
                    }
                }
                
//                HStack { // reset password
//                    Spacer()
//                    
//                    NavigationLink
//                }
                
                Spacer()
            }
            //            .navigationBarBackButtonHidden()
            .navigationTitle(viewModel.viewTitle)
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
    let mocAuth = MockAuthService.initWithMockUser(loginned: false)
    let errorManager = ErrorManager()
    
    return SignInView<MockAuthService>()
        .environmentObject(mocAuth)
        .environmentObject(errorManager)
}
