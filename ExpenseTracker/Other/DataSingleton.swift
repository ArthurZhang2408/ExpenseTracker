//
//  DataSingleton.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-01.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class DataSingleton: ObservableObject {
    static let instance: DataSingleton = DataSingleton()
    @Published var currentUserID: String = ""
    @Published var categories: [String: ExpenseCategory] = ["Grocery":ExpenseCategory(id: "Grocery", img: "😭", spent: 30, subCategories: ["大统华", "Costco", "大百汇"])]
    @Published var subCategories: Set<String> = []
    @Published var models: [CategoryModel] = [CategoryModel(cObj: ExpenseCategory(id: "Grocery", img: "😭", spent: 30, subCategories: ["大统华", "Costco", "大百汇"]), clicked: false)]
    @Published var transactions: [String: ExpenseTransaction] = [:]
    private var handler: AuthStateDidChangeListenerHandle?
    
    private init() {
        self.handler = Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserID = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil && !currentUserID.isEmpty
    }
    
    public func resetModels () {
        for i in models.indices {
            models[i].clicked = false
        }
    }
    
    public func click (index: Int) {
        models[index].clicked.toggle()
    }
    
    public func getCategory (cat: String) -> ExpenseCategory {
        return categories[cat] ?? ExpenseCategory(id: "", img: "", spent: 0, subCategories: [""])
    }
    
    public func containsSubCategory (sub: String) -> Bool {
        return subCategories.contains(sub)
    }
    
    public func containsCategory (cat: String) -> Bool {
        return categories[cat] != nil
    }
    
    public func addCategory (cat: ExpenseCategory) {
        subCategories.formUnion(cat.subCategories)
        categories[cat.id] = cat
        models.append(CategoryModel(cObj: cat))
    }
    
    public func removeCategory (cat: String) {
        if (containsCategory(cat: cat)){
            subCategories.subtract(categories[cat]?.subCategories ?? [])
            categories[cat] = nil
        }
    }
    
    public func getTransaction (id: String) -> ExpenseTransaction {
        return transactions[id] ?? ExpenseTransaction(id: "", amount: 0, description: "", category: "", subCategory: "", createdDate: Date().timeIntervalSince1970, currency: "CAD")
    }
    
    public func containsTransaction (id: String) -> Bool {
        return transactions[id] != nil
    }
    
    public func addTransaction (tra: ExpenseTransaction) {
        transactions[tra.id] = tra
    }
    
    public func removeTransaction (id: String) {
        transactions[id] = nil
    }
}
