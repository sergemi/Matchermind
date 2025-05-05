//
//  TabItem.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI

struct TabItem: View {
    let image: Image
    let caption: String
    
    var body: some View {
        VStack {
            image
            Text(caption)
        }
    }
}

#Preview {
    TabItem(image: Image(systemName: "list.bullet.clipboard"),
            caption: "Some tabitem")
}
