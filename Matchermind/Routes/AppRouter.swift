//
//  AppRouter.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

enum AppRoute: Hashable {
    case learn(LearnFlowLink)
    case edit(EditFlowLink)
    case auth(AuthFlowLink)
    case profile(ProfileFlowLink)
}

@Observable
final class AppRouter {
    var selectedTab: Tab = .learn
    
    var learnPath = NavigationPath()
    var editPath = NavigationPath()
    var authPath = NavigationPath()
    var profilePath = NavigationPath()
    
    var isShowingAuth = false
    var isShowingProfile = false

    enum Tab: String, Identifiable {
        case learn
        case edit
        
        var id: String { rawValue }
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .learn(let link):
            learnPath.append(link)
            selectedTab = .learn
            
        case .edit(let link):
            editPath.append(link)
            selectedTab = .edit
            
        case .auth(let link):
            authPath.append(link)
            isShowingAuth = true // TODO: check if it work
            
        case .profile(let link):
            profilePath.append(link)
            isShowingProfile = true // TODO: check if it work
        }
    }

    func doLogin() {
        authPath = NavigationPath()
        isShowingAuth = true
        isShowingProfile = false
    }
    
    func closeAuth() {
        isShowingAuth = false
    }
    
    func showProfile() {
        profilePath = NavigationPath()
        isShowingProfile = true
    }
}
