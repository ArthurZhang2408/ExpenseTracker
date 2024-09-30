//
//  MainView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-01.
//

import SwiftUI

struct MainView: View {
    @StateObject var instance = DataSingleton.instance
//    @StateObject var instance = MainViewModel()
    var body: some View {
        if instance.isSignedIn {
            accountView
        } else {
            WelcomeView()
        }
    }
    
    @ViewBuilder
    var accountView: some View {
        TabView {
            ListingView(userId: instance.currentUserID )
                .tabItem { Label("Home", systemImage: "house") }
            StatView(userId: instance.currentUserID )
                .tabItem { Label("Stat", systemImage: "chart.bar") }
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle")}
        }
    }
}

#Preview {
    MainView()
}
