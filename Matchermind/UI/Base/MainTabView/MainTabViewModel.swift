//
//  MainTabViewModel.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

@Observable
final class MainTabViewModel {
    var router: AppRouter
    
    let tabs: [AppRouter.Tab] = [.learn,
                                 .quickAdd,
                                 .edit]
    
    let tabsItemData: [AppRouter.Tab: TabItemData] = [
        .learn: TabItemData(caption: "Learn", image: .system("book")),
        .quickAdd: TabItemData(caption: "Add word", image: .system("plus")),
        .edit: TabItemData(caption: "Edit", image: .system("pencil")),
    ]
    
    @ViewBuilder func tabView(_ tab: AppRouter.Tab) -> some View {
        switch(tab) {
        case .learn:
            LearnFlowView()
            
        case .quickAdd:
            QuickAddFlowView()
        
        case .edit:
            EditFlowView()
        }
    }
    
    init(router: AppRouter) {
        self.router = router
    }
}

extension MainTabViewModel {
    struct TabItemData {
        let caption: String
        let image: Image.ImageType
    }
}
