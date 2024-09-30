//
//  AddOrEditTransaction.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-07.
//

import FirebaseFirestore
import Foundation
import SwiftUI

class AddOrEditTransactionViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var description: String = ""
    @Published var category: String = ""
    @Published var subCategory: String = ""
    @Published var oldId: String = ""
    @Published var amount: String = ""
    @Published var createdDate: Date = Date()
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
        createdDate = Date(timeIntervalSince1970: curr.createdDate)
        title = id.isEmpty ? "ADD" : "EDIT"
        DispatchQueue.main.async {
            self.instance.resetModels()
        }
    }
    
    func save() -> Bool {
        guard validate() else {
            showAlert = true
            return false
        }
        instance.removeTransaction(id: oldId)
        let id: String = (oldId.isEmpty) ? UUID().uuidString : oldId
        let newTra: ExpenseTransaction = ExpenseTransaction(id: id, amount: Double(amount) ?? 0, description: description, category: category, subCategory: subCategory, createdDate: createdDate.timeIntervalSince1970)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(instance.currentUserID)
            .collection("transactions")
            .document(id)
            .setData(newTra.asDictionary())
        instance.addTransaction(tra: newTra)
        return true
    }
    
    func click (index: Int) {
        instance.click(index: index)
    }
    
    func select(sub: String, catInd: Int) {
        subCategory = subCategory == sub ? "" : sub
        category = instance.models[catInd].cObj.id
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
