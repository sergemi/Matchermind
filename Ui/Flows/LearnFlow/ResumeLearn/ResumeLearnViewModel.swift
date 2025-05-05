//
//  ResumeLearnViewModel.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import Foundation

class ResumeLearnViewModel: ViewModel {
    private var errorManager: ErrorManager?
    
    func setDependencies(errorManager: ErrorManager) {
        print(">> ResumeLearnViewModel.setDependencies")
        self.errorManager = errorManager
    }
    
    @MainActor func fireError() {
        print("fireError")
        
       let testError = testError()
        errorManager?.handleError(testError)
    }
}
