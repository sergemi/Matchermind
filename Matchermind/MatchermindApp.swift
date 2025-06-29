//
//  MatchermindApp.swift
//  Matchermind
//
//  Created by sergemi on 02.10.2024.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct MatchermindApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    func application(
            _ application: UIApplication,
            open url: URL,
            options: [UIApplication.OpenURLOptionsKey : Any] = [:]
        ) -> Bool {
            return GIDSignIn.sharedInstance.handle(url)
        }
}
