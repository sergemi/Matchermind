//
//  EditFlow.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

enum EditFlowLink: Hashable {
    case modulesList
    case newModule
    case editModule(preload: ModulePreload, isQuickModule: Bool)
}

struct EditFlowView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.editPath) {
            EditModulesListView()
                .navigationDestination(for: EditFlowLink.self) { link in
                    switch link {
                    case .modulesList:
                        EditModulesListView()
                        
                    case .newModule:
                        EditModuleView(modulePreload: nil , isQuickModule: false)
                        
                        
                    case .editModule(let preload, let isQuickModule):
                        EditModuleView(modulePreload: preload , isQuickModule: isQuickModule)
                    }
                }
        }
    }
}
