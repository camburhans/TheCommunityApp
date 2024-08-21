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
                ProfileView()
            } else {
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
