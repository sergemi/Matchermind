//
//  EditTopicsListRowHeader.swift
//  Matchermind
//
//  Created by sergemi on 03/07/2025.
//

import SwiftUI

struct EditTopicsListRowHeader: View {
    let count: Int
    let onAdd: () -> Void
    
    var body: some View {
        HStack {
            Text("\(count) topics:")
                .font(.title2)
            
            Spacer()
            
            Button(action: onAdd) {
                Text("Add topic")
            }
        }
    }
}

#Preview {
    EditTopicsListRowHeader(count: 10, onAdd: {})
}
