//
//  MatchermindApp.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI
import Firebase

@main
//struct MatchermindApp: App {
struct MatchermindAppOld: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService = AuthService()
    @StateObject private var coordinator = Coordinator<AuthService>()
    
    var body: some Scene {
        WindowGroup {
            LazyContentView<AuthService>()
                .environmentObject(authService)
                .environmentObject(coordinator)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
