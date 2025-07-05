//
//  EditWordsListRowHeader.swift
//  Matchermind
//
//  Created by sergemi on 05/07/2025.
//

import SwiftUI

struct EditWordsListRowHeader: View {
    let count: Int
    let onAdd: () -> Void
    
    var body: some View {
        HStack {
            Text("\(count) words:")
                .font(.title2)
            
            Spacer()
            
            Button(action: onAdd) {
                Text("Add word")
            }
        }
    }
}

#Preview {
    EditWordsListRowHeader(count: 10, onAdd: {})
}
