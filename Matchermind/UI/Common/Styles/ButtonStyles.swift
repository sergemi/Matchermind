//
//  ButtonStyles.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

struct GhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.tint)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .stroke(.tint, lineWidth: 1)
            )
    }
}
