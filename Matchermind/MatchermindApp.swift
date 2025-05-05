//
//  MatchermindApp.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI
import Firebase

@main
struct MatchermindApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
    
    // MARK - old app
//    @StateObject private var authService = AuthServiceOld()
//    @StateObject private var coordinator = Coordinator<AuthServiceOld>()
//    
//    var body: some Scene {
//        WindowGroup {
//            LazyContentView<AuthServiceOld>()
//                .environmentObject(authService)
//                .environmentObject(coordinator)
//        }
//    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
