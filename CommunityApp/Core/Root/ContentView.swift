//
// ContentView.swift
// CommunityApp
//
// Created by Cameron Burhans on 7/27/24

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                // Show TabView if user is signed in
                MainTabView()
            } else {
                // Show LoginView if user is not signed in
                LoginView()
            }
        }
    }
}

#Preview {
    let testModel = AuthViewModel()
    testModel.currentUser = User(id: "123", fullname: "Cameron Burhans", email: "cameron@example.com")
    return ContentView()
        .environmentObject(testModel)
}
