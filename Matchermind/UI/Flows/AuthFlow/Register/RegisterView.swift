//
//  RegisterView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authWrapper: AuthService
    
    var body: some View {
        RegisterContentView(viewModel: RegisterViewModel(router: router,
                                                         authService: authWrapper))
    }
}

struct RegisterContentView: View {
    @StateObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack {
            Text("Register screen")

            Button("Register") {
                viewModel.register()
            }
        }
        .navigationTitle(viewModel.title)
    }
}

#Preview {
    withMockEnvironment{
        RegisterView()
    }
}
