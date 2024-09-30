//
//  LoginViewModel.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var txtEmail: String = ""
    @Published var txtPassword: String = ""
    @Published var showSignUp: Bool = false
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    init() {}
    
    func login() {
        
        guard validate() else {
            showAlert = true
            return
        }
        
        Auth.auth().signIn(withEmail: txtEmail, password: txtPassword)
    }
    
    private func validate() -> Bool {
        
        errorMessage = ""
        guard !txtEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !txtPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: txtEmail) else {
            errorMessage = "Please enter valid email"
            return false
        }
        return true
    }
}
