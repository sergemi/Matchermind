//
//  RegisterView.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject private var errorManager: ErrorManager
    
    var body: some View {
        RegisterContentView(viewModel: RegisterViewModel(router: router,
                                                         authService: authService))
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
