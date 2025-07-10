//
//  QuickAddFlow.swift
//  Matchermind
//
//  Created by sergemi on 10/07/2025.
//

import SwiftUI

enum QuickAddFlowLink: Hashable {
    case addWord
}

struct QuickAddFlowView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.quickAddPath) {
            QuickAddWordView()
                .navigationDestination(for: QuickAddFlowLink.self){link in
                    switch link {
                    case .addWord:
                        QuickAddWordView()
                    }
                }
        }
    }
}
