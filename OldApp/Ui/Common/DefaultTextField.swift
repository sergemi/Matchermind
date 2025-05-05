//
//  DefaultTextField.swift
//  Matchermind
//
//  Created by sergemi on 06.10.2024.
//

import SwiftUI

struct DefaultTextField: View {
    @Binding var text: String
    @State var placeholder: String
    @State var title: String
    @State var errorText: String?
    
    var body: some View {
        ZStack {
            TextField("",
                      text: $text,
                      prompt: Text(placeholder)
                .foregroundStyle(Color("HintColor"))
            )
                .textFieldStyle(DefaultTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(Color("HintColor")))
            
            
            // TODO: clear rect under title text. Not just override by background color
            VStack(alignment: .leading) {
                HStack {
                    Text(" \(title) ")
                        .background(Color("BackgroundColor"))
                        .foregroundColor(Color("TextColor"))
//                        .foregroundColor(Color("HintColor"))
                        .opacity(1)
    //                    .offset(x: -120, y: -28)
                        .offset(y: -28)
                    .padding()
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DefaultTextField(text: .constant(""), placeholder: "placeholder", title: "title")
        .padding()
}
