//
//  UnsavedChangesAlertViewModifier.swift
//  Matchermind
//
//  Created by sergemi on 07/07/2025.
//

//import Foundation
import SwiftUI

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
    let condition: (VM) -> Bool
    let message: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton {
                        if condition(viewModel) {
                            showAlert = true
                        } else {
                            dismiss()
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
        when condition: @escaping (VM) -> Bool = { ($0 as? any HasUnsavedChanges)?.hasUnsavedChanges ?? false },
        message: String = "If you exit without saving the data it will be lost."
    ) -> some View {
        modifier(UnsavedChangesAlertModifier(viewModel: viewModel, condition: condition, message: message))
    }
}
