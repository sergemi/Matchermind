//
//  EditModuleRowHeader.swift
//  Matchermind
//
//  Created by sergemi on 01/07/2025.
//

import SwiftUI

struct EditModuleRowHeader: View {
    let count: Int
    let onAdd: () -> Void
    
    var body: some View {
        HStack {
            Text("\(count) Modules:")
                .font(.title2)
            
            Spacer()
            
            Button(action: onAdd) {
                Text("Add module")
            }
        }
    }
}

#Preview {
    EditModuleRowHeader(count: 10, onAdd: {})
}
