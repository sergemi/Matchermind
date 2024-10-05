//
//  SignupView.swift
//  Matchermind
//
//  Created by sergemi on 05.10.2024.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        VStack {
            Text("SignupView")
            
            Button("Test Error") {
                let error = testError()
                errorManager.handleError(error)
            }
        }
    }
}

#Preview {
    SignupView()
}
