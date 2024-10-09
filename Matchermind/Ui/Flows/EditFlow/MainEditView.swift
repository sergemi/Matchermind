//
//  MainEditView.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

struct MainEditView: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("Edit flow")
        
        .toolbar {
            ProfileNavigationBarButton()
        }
    }
}

#Preview {
    MainEditView()
}
