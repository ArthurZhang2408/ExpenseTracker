//
//  User.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
