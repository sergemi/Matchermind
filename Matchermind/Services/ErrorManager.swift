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

class ErrorManager: ObservableObject {
    @Published var currentError: Error?

    func handleError(_ error: Error) {
        currentError = error
    }
}

extension View {
    func withErrorAlert(errorManager: ErrorManager) -> some View {
        print(errorManager.currentError)
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
