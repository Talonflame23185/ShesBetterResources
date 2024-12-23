//
//  ContentView.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 12/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if authViewModel.isUserLoggedIn {
                    NavView() // Use NavView for navigation
                } else {
                    LoginView() // Show the login screen
                }
    }
}

#Preview {
    ContentView()
}
