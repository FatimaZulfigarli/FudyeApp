//
//  RegisterViewModel.swift
//  FudyeApp
//
//  Created by Fatya on 29.06.24.
//

import Foundation

class RegisterViewModel {
    private let manager = FileManagerHelper()
    var users = [RegisterModel]()
    
    var registerCVE: String = ""
    var registerExpireDate: String = ""
    var register16CardNumber: String = ""
    var registerNumber: String = ""
    var registerMail: String = ""
    var registerPassword: String = ""
    var errorMessage: String?
    
    var onUserRegistered: ((String?, String?) -> Void)?
    
    func loadUsers(completion: @escaping () -> Void) {
        manager.getUser { userItems in
            self.users = userItems
            completion()
        }
    }
    
    func registerUser(completion: @escaping (Bool) -> Void) {
        let user = RegisterModel(registerPassword: registerPassword,
                                 registerMail: registerMail,
                                 registerNumber: registerNumber,
                                 registerCardNumber: register16CardNumber,
                                 registerExpiryDate: registerExpireDate,
                                 registerCVE: registerCVE)
        
        users.append(user)
        manager.saveUser(data: users)
        onUserRegistered?(user.registerMail, user.registerPassword)
        completion(true)
    }
}
