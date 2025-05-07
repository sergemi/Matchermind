//
//  AppleSignInMocButton.swift
//  Matchermind
//
//  Created by sergemi on 07/05/2025.
//

import SwiftUI
import AuthenticationServices

class appleSignInMocErrorSuccess: LocalizedError {
    var errorDescription: String? { "Success!\nTODO: Implement actual SignIn" }
}

class appleSignInMocErrorFailure: LocalizedError {
    var errorDescription: String? { "Failure!\nTODO: Implement actual SignIn" }
}


struct AppleSignInMocButton: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        SignInWithAppleButton(.continue) { request in
                // Мокаем запрос — ничего не настраиваем
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                // Обработка результата — в бесплатной учётке не будет вызвана
                do {
                    switch result {
                    case .success(let authResults):
                        print("Success: \(authResults)")
                        throw appleSignInMocErrorSuccess()
                        
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        throw appleSignInMocErrorFailure()
                    }
                }
                catch {
                    Task {
                        errorManager.handleError(error)
                    }
                }
            }
            .signInWithAppleButtonStyle(.whiteOutline)
            .frame(height: 45)
        }
}

#Preview {
    let errorMgr = ErrorManager()
    
    return AppleSignInMocButton()
        .environmentObject(errorMgr)
//        .withErrorAlert(errorManager: errorMgr)
}
