//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-29.
//

import FirebaseCore
import SwiftUI

@main
struct ExpenseTrackerApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                MainView()
//                AddOrEditTransactionView().environmentObject(DataSingleton.instance)
            }
        }
    }
}
