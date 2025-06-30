//
//  RegisterView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct SignUpView: View {
    @Environment(AppRouter.self) var router
    @Environment(AuthService.self) var authService
    @Environment(ErrorManager.self) var errorMgr
    
    var body: some View {
        SignUpContentView(viewModel: SignUpViewModel(errorMgr: errorMgr,
                                                     router: router,
                                                     authService: authService
                                                     ))
    }
}

struct SignUpContentView: View {
    @State var viewModel: SignUpViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                DefaultTextField(text: $viewModel.email, placeholder: viewModel.emailHint, title: viewModel.emailTitle)
                
                DefaultTextField(text: $viewModel.password, placeholder: viewModel.passwordHint, title: viewModel.passwordTitle)
                
                Button("Sign up") {
                    viewModel.signUp()
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .padding()
            .navigationTitle(viewModel.title)
        }
    }
}

#Preview {
    withMockEnvironment{
        SignUpView()
    }
}
