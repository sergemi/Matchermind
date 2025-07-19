//
//  AppRouter.swift
//  MyRouter
//
//  Created by sergemi on 03/05/2025.
//

import SwiftUI

enum AppRoute: Hashable {
    case learn(LearnFlowLink)
    case quickAdd(QuickAddFlowLink)
    case edit(EditFlowLink)
    case auth(AuthFlowLink)
    case profile(ProfileFlowLink)
}

@Observable
final class AppRouter {
    private static let defTab: Tab = .learn
    var selectedTab: Tab = defTab
    
    var learnPath = NavigationPath()
    var editPath = NavigationPath()
    var authPath = NavigationPath()
    var profilePath = NavigationPath()
    var quickAddPath = NavigationPath()
    
    var isShowingAuth = false
    var isShowingProfile = false

    enum Tab: String, Identifiable {
        case learn
        case quickAdd
        case edit
        
        var id: String { rawValue }
    }

    func navigate(to route: AppRoute) {
        switch route {
        case .learn(let link):
            learnPath.append(link)
            selectedTab = .learn
            
        case .quickAdd(let link):
            quickAddPath.append(link)
            selectedTab = .quickAdd
            
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
    
    func reset() {
        print("AppRouter.reset")
        learnPath = NavigationPath()
        editPath = NavigationPath()
        authPath = NavigationPath()
        profilePath = NavigationPath()
        quickAddPath = NavigationPath()
        
        selectedTab = AppRouter.defTab
        isShowingProfile = false
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
