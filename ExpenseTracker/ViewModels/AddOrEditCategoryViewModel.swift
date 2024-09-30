//
//  NewCategoryViewModel.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AddOrEditCategoryViewModel: ObservableObject {
    @Published var category: String = ""
    @Published var icon: String = ""
    @Published var errorMessage: String = ""
    @Published var subCategories: [String] = [""]
    @Published var oldName: String = ""
    @Published var showAlert: Bool = false
    let title: String
    let curr: ExpenseCategory
    let instance = DataSingleton.instance
    
    init(editing: String = "") {
        oldName = editing
        curr = instance.getCategory(cat: editing)
        category = editing
        icon = curr.img
        subCategories = Array(curr.subCategories)
        title = editing.isEmpty ? "ADD" : "EDIT"
    }
    
    func save() -> Bool {
        guard validate() && validateSub() else {
            showAlert = true
            return false
        }
        instance.removeCategory(cat: oldName)
        let spent = (oldName.isEmpty) ? 0 : instance.getCategory(cat: oldName).spent
        let newCategory: ExpenseCategory = ExpenseCategory(name: category, img: icon, spent: spent, subCategories: subCategories)
//        category = ""
//        subCategories = [""]
//        icon = ""
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(instance.currentUserID)
            .collection("categories")
            .document(category)
            .setData(newCategory.asDictionary())
        instance.addCategory(cat: newCategory)
        return true
    }
    
    func addSubCategory() {
        subCategories.append("")
    }
    
    func removeSubCategory(index: Int) {
        subCategories.remove(at: index)
    }
    
    private func validateSub() -> Bool {
        
        errorMessage = ""
        var subs: Set<String> = []
        var index: Int = 0
         
        for subCategory in subCategories {
            if subCategory.trimmingCharacters(in: .whitespaces).isEmpty {
                self.removeSubCategory(index: index)
                
                continue
            } else {
                index += 1
            }
            guard (!instance.containsSubCategory(sub: subCategory) && !subs.contains(subCategory)) || curr.subCategories.contains(subCategory) else {
                errorMessage = "Subcategory \"\(subCategory)\" already exists"
                return false
            }
            subs.insert(subCategory)
        }
        guard !subCategories.isEmpty else {
            errorMessage = "Please fill in at least one subcategory"
            subCategories = [""]
            return false
        }
        
        return true
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !category.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in category name"
            return false
        }
        guard !icon.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in icon with an emoji"
            return false
        }
        guard !instance.containsCategory(cat: category) || category == oldName else {
            errorMessage = "Category \"\(category)\" already exists"
            return false
        }
        
        return true
    }
}
