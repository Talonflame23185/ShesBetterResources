//
//  ShesBetterResourcesApp.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 12/23/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ShesBetterResourcesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel) // Ensure authViewModel is available globally
        }
    }
}
