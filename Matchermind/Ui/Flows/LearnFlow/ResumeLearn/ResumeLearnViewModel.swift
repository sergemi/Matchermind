//
//  ResumeLearnViewModel.swift
//  Matchermind
//
//  Created by sergemi on 04.10.2024.
//

import Foundation

class ResumeLearnViewModel: ViewModel {
    func fireError() {
        print("fireError")
        
       error = testError()
//        errorManager.handleError(error)
    }
}
