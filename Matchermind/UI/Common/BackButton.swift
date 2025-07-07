//
//  BackButton.swift
//  Matchermind
//
//  Created by sergemi on 07/07/2025.
//

import SwiftUI

struct BackButton: View {
    let title: String = "Back"
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                Text(title)
            }
        }
    }
}
