//
//  ExpenseTransaction.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-07-07.
//

import Foundation

struct ExpenseTransaction: Codable {
    let id: String
    var amount: Double
    var description: String
    let category: String
    let subCategory: String
}
