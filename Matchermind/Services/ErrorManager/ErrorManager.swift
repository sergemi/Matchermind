//
//  ErrorService.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import SwiftUI
import Combine

class testError: LocalizedError {
    var errorDescription: String? { "Test error" }

}

class testError2: LocalizedError {
    var errorDescription: String? { "Test error 2" }

}

@Observable
class ErrorManager {
    var currentError: Error?

    @MainActor
    func handleError(_ error: Error) {
        print("ErrorManager.handleError(\(error)")
        currentError = error
    }
}

extension View {
    func withErrorAlert(errorManager: ErrorManager) -> some View {
        print("withErrorAlert")
        return self.alert(isPresented: .constant(errorManager.currentError != nil), content: {
            Alert(
                title: Text("Error"),
                message: Text(errorManager.currentError?.localizedDescription ?? "Unknown error"),
                dismissButton: .default(Text("OK")) {
                    errorManager.currentError = nil
                }
            )
        })
    }
}
