//
//  StatView.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-01.
//

import SwiftUI

struct StatView: View {
    @StateObject var viewModel = StatViewModel()
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StatView(userId: "")
}
