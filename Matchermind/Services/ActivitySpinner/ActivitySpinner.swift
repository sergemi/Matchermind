//
//  ActivitySpinner.swift
//  Matchermind
//
//  Created by sergemi on 01/07/2025.
//

import SwiftUI

struct ActivitySpinnerModifier: ViewModifier {
    @Binding var isPresented: Bool
    var text: String?
    var isModal: Bool = true
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isPresented && isModal)
            
            if isPresented {
                //                Color.black.opacity(0.4)
                //                    .ignoresSafeArea()
                //                    .transition(.opacity)
                
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    
                    if let text = text {
                        Text(text)
                            .foregroundColor(.white)
                            .font(.body)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(24)
                .background(Color.black.opacity(0.3))
                .cornerRadius(16)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: isPresented)
    }
}

extension View {
    func activitySpinner(isPresented: Binding<Bool>, text: String? = nil, isModal: Bool = true) -> some View {
        self.modifier(ActivitySpinnerModifier(isPresented: isPresented, text: text, isModal: isModal))
    }
    
    func activitySpinner(viewModel: BaseViewModel) -> some View {
        let isPresentedBinding = Binding(
            get: { viewModel.isActivity },
            set: { viewModel.isActivity = $0 }
        )
        
        return self.modifier(ActivitySpinnerModifier(isPresented: isPresentedBinding,
                                                     text: viewModel.activityMessaage,
                                                     isModal: viewModel.isActivityModal))
    }
}
