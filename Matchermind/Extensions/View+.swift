//
//  View+.swift
//  Matchermind
//
//  Created by sergemi on 12/07/2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
