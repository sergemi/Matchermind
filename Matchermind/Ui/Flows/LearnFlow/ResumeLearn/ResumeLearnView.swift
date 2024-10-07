//
//  ContinueLearnView.swift
//  Matchermind
//
//  Created by sergemi on 03.10.2024.
//

import SwiftUI

struct ResumeLearnView: View {
    @StateObject var viewModel = ResumeLearnViewModel()
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        VStack {
            Text("ContinueLearnView")
            Button("Test Error") {
//                let error = testError()
//                errorManager.handleError(error)
                viewModel.fireError()
            }
        }
        .navigationTitle("ResumeLearnView")
        
        .task {
            viewModel.setDependencies(errorManager: errorManager)
        }
    }
}

#Preview {
    ResumeLearnView()
}
