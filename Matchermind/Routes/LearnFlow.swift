//
//  LearnFlow.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

enum LearnFlowLink: Hashable {
    case modulesList
    case module(preload: ModulePreload)
}

struct LearnFlowView: View {
    @Environment(AppRouter.self) private var router
    @Environment(DataManager.self) var dataMgr
    
    var body: some View {
        @Bindable var router = router
        
        NavigationStack(path: $router.learnPath) {
            ModulesListView()
                .navigationDestination(for: LearnFlowLink.self) { link in
                    switch link {
                    case .modulesList:
                        ModulesListView()
                        
                    case .module(let preload):
                        ModuleView(modulePreload: preload)
                    }
                }
        }
    }
}
