//
//  AddOrEditTransaction.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-07.
//

import Foundation
import SwiftUI

class AddOrEditTransactionViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var description: String = ""
    @Published var category: String = ""
    @Published var subCategory: String = ""
    @Published var oldId: String = ""
    @Published var amount: String = ""
    @Published var showingNewCategoryView: Bool = false
    @Published var showAlert: Bool = false
    let title: String
    let curr: ExpenseTransaction
    let instance = DataSingleton.instance
    
    init(id: String = "") {
        oldId = id
        curr = instance.getTransaction(id: id)
        description = curr.description
        category = curr.category
        subCategory = curr.subCategory
        amount = String(curr.amount)
        title = id.isEmpty ? "ADD" : "EDIT"
    }
    
    func save() -> Bool {
        guard validate() else {
            showAlert = true
            return false
        }
        return true
    }
    
    func select(sub: String) {
        subCategory = subCategory == sub ? "" : sub
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard amount != "" else {
            errorMessage = "Please fill in amount of transaction"
            return false
        }
        guard subCategory != "" else {
            errorMessage = "Please select a subcategory"
            return false
        }
        
        return true
    }
}
