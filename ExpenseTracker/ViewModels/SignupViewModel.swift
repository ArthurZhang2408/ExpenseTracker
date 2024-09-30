//
//  SignupViewModel.swift
//  ExpenseTracker
//
//  Created by Arthur Zhang on 2024-06-30.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class SignupViewModel: ObservableObject {
    
    @Published var txtEmail: String = ""
    @Published var txtName: String = ""
    @Published var txtPassword: String = ""
    @Published var txtPasswordReenter: String = ""
    @Published var showSignIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    init() {}
    
    func signin() {
        guard validate() else {
            showAlert = true
            return
        }
        Auth.auth().createUser(withEmail: txtEmail, password: txtPassword) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, name: txtName, email: txtEmail, joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        
        db.collection("users").document(id).setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !txtEmail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !txtPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, !txtPasswordReenter.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: txtEmail) else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        guard txtPassword.count > 6 else {
            errorMessage = "Password has to be more than 6 characters"
            return false
        }
        
        guard txtPassword.elementsEqual(txtPasswordReenter) else {
            errorMessage = "Passwords do not match"
            return false
        }
        return true
    }
}
