//
//  MainQuickAddView.swift
//  Matchermind
//
//  Created by sergemi on 07.10.2024.
//

import SwiftUI

struct MainQuickAddView<AuthServiceProxy: AuthServiceProtocolOld>: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("Quick add")
        
        .toolbar {
            ProfileNavigationBarButton<AuthServiceProxy>()
        }
    }
}

#Preview {
    MainQuickAddView<MockAuthServiceOld>()
}
