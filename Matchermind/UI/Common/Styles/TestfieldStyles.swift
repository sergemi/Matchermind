//
//  TestfieldsStyles.swift
//  Matchermind
//
//  Created by sergemi on 06.10.2024.
//

import SwiftUI

struct DefaultTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
      return configuration
            .textFieldStyle(.plain)
//            .padding(.horizontal, 8)
            .padding()
//            .frame(height: 45)
//            .cornerRadius(10)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color("HintColor")))
        
            .foregroundColor(Color("TextColor")) // text color
            .tint(Color("TextColor")) // cursor color
        
            .autocorrectionDisabled()
            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
    }
}
