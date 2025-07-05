//
//  EditModuleExercisesView.swift
//  Matchermind
//
//  Created by sergemi on 05/07/2025.
//

import SwiftUI

struct EditModuleExercisesView: View {
    @Binding var exercises: Set<ExerciseType>
    
    var body: some View {
        HStack {
            Text("\(exercises.count) exercises:")
                .font(.title2)
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var exercises: Set<ExerciseType> = [
            .choseTranslate,
            .choseTranslateInverse
        ]
        
        var body: some View {
            EditModuleExercisesView(exercises: $exercises)
        }
    }
    
    return PreviewWrapper()
}
