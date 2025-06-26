//
//  ModuleListRow.swift
//  Matchermind
//
//  Created by sergemi on 25/06/2025.
//

import SwiftUI

struct ModuleListRow: View {
    let modulePreload: ModulePreload
    
    var body: some View {
        HStack {
            Text(modulePreload.name)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    let module = Module(name: "Test module",
                        details: "Module details",
                        topics: [],
                        authorId: "1",
                        isPublic: true)
    let modulePreload = module.modulePreload
    
    return ModuleListRow(modulePreload: modulePreload)
}
