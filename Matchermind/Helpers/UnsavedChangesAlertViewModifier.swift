//
//  UnsavedChangesAlertViewModifier.swift
//  Matchermind
//
//  Created by sergemi on 07/07/2025.
//

import SwiftUI

@MainActor
protocol HasUnsavedChanges {
    var hasUnsavedChanges: Bool { get }
}

struct BackButtonViewModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton {
                        dismiss()
                    }
                }
            }
    }
}

struct UnsavedChangesAlertModifier<VM: AnyObject>: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false

    let viewModel: VM
    let condition: (VM) async -> Bool
    let message: String
    let showBackButton: Bool

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(showBackButton)
            .toolbar {
                if showBackButton {
                    ToolbarItem(placement: .navigationBarLeading) {
                        BackButton {
                            Task {
                                if await condition(viewModel) {
                                    showAlert = true
                                } else {
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
            .alert("Data not saved", isPresented: $showAlert) {
                Button("Exit without saving", role: .destructive) {
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(message)
            }
    }
}

extension View {
    func alertOnBackButton<VM: AnyObject>(
        viewModel: VM,
        showBackButton: Bool = true,
        when condition: @escaping (VM) async -> Bool = {
            guard let hasUnsaved = $0 as? any HasUnsavedChanges else { return false }
            return await MainActor.run { hasUnsaved.hasUnsavedChanges }
        },
        message: String = "If you exit without saving the data it will be lost."
    ) -> some View {
        modifier(
            UnsavedChangesAlertModifier(
                viewModel: viewModel,
                condition: condition,
                message: message,
                showBackButton: showBackButton
            )
        )
    }
}

extension View {
    func backButton() -> some View {
        modifier(BackButtonViewModifier())
    }
}
