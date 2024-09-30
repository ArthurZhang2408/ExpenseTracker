//
//  ExpenseCategory.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import Foundation

struct ExpenseCategory: Codable, Identifiable {
    let id: String
    let img: String
    let spent: Double
    let subCategories: [String]
    let status: Int = 1
}
