//
//  ProfileFlow.swift
//  MyRouter
//
//  Created by sergemi on 04/05/2025.
//

import SwiftUI

enum ProfileFlowLink: Hashable {
    case base
    case statistics
}

struct ProfileFlowView: View {
    @Environment(AppRouter.self) private var router
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.profilePath) {
            ProfileView()
                .navigationDestination(for: ProfileFlowLink.self) { link in
                    switch link {
                    case .base:
                        ProfileView()
                        
                    case .statistics:
                        UserStatisticsView()
                    }
                }
        }
    }
}

