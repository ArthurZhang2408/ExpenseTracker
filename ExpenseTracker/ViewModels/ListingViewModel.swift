//
//  ListingViewModel.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import Foundation

class ListingViewModel: ObservableObject {
    @Published var showingNewItemView: Bool = false
    
    init() {}
}
