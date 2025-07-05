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
    case newTopic(moduleId: String)
    case editTopic(moduleId: String, topicId: String)
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
                        
                    case .newTopic(let moduleId):
                        EditTopicView(moduleId: moduleId)
                        
                    case .editTopic(let moduleId, let topicId):
                        EditTopicView(moduleId:moduleId, topicId: topicId)
                        
                    }
                }
        }
    }
}
