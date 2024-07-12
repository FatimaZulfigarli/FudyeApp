//
//  LoginViewModel.swift
//  FudyeApp
//
//  Created by Fatya on 29.06.24.
//

import Foundation

class LoginViewModel {
    private let manager = FileManagerHelper()
    
    var email: String = ""
    var password: String = ""
    var errorMessage: String?
    
    func loginUser(completion: @escaping (Bool) -> Void) {
        manager.getUser { users in
            if let user = users.first(where: { $0.registerMail == self.email && $0.registerPassword == self.password }) {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(self.email, forKey: "currentUserEmail")
                
                // Clear current order
                OrderManager.shared.clearOrderFile()
                
                // Load user's basket
                if let userBasket = OrderManager.shared.loadBasketForUser(self.email) {
                    OrderManager.shared.saveOrderToFile(userBasket)
                }
                
                completion(true)
            } else {
                self.errorMessage = "Invalid email or password"
                completion(false)
            }
        }
    }
}
