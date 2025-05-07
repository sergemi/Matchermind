//
//  RegisterView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject private var errorManager: ErrorManager
    
    var body: some View {
        SignUpContentView(viewModel: SignUpViewModel(router: router,
                                                     authService: authService,
                                                     errorManager: errorManager))
    }
}

struct SignUpContentView: View {
    @StateObject var viewModel: SignUpViewModel
    
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
