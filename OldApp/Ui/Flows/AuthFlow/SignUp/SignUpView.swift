//
//  SignupView.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import SwiftUI

struct SignUpView<AuthServiceProxy: AuthServiceProtocolOld>: View {
    @EnvironmentObject private var errorManager: ErrorManager
    @EnvironmentObject private var authService: AuthServiceProxy
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            Text("SignupView")
            
            Button("Test Error") {
                let error = testError()
                errorManager.handleError(error)
            }
        }
        .navigationTitle(viewModel.viewTitle)
        
        .task {
            viewModel.setDependencies(errorManager: errorManager, authService: authService)
        }
    }
}

#Preview {
    let mocAuth = MockAuthServiceOld.initWithMockUser(loginned: false)
    let errorManager = ErrorManager()
    
    return SignUpView<MockAuthServiceOld>()
        .environmentObject(mocAuth)
        .environmentObject(errorManager)
}
