//
//  LoginView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authWrapper: AuthService
    
    var body: some View {
        LoginContentView(viewModel: LoginViewModel(router: router,
                                                   authService: authWrapper))
    }
}

struct LoginContentView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Login screen")
            Button("Login") {
                viewModel.login()
            }
            Spacer()
            Button("Register") {
                viewModel.register()
            }
        }
        .navigationTitle(viewModel.title)

    }
}

#Preview {
    withMockEnvironment(loginned: false) {
        LoginView()
    }
}
