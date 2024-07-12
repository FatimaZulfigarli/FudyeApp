//
//  RegisterController.swift
//  FudyeApp
//
//  Created by Fatya on 30.05.24.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var registerCVE: UITextField!
    @IBOutlet weak var registerExpireDate: UITextField!
    @IBOutlet weak var register16CardNumber: UITextField!
    @IBOutlet weak var registeNumber: UITextField!
    @IBOutlet weak var registerMail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    let manager = FileManagerHelper()
     var users = [RegisterModel]()
     var onUserRegistered: ((String?, String?) -> Void)?

     override func viewDidLoad() {
         super.viewDidLoad()
         manager.getUser { userItems in
             self.users = userItems
         }
         getShape()
     }

     func getShape() {
         registerCVE.layer.cornerRadius = 20
         registerExpireDate.layer.cornerRadius = 20
         register16CardNumber.layer.cornerRadius = 20
         registeNumber.layer.cornerRadius = 20
         registerMail.layer.cornerRadius = 20
         registerPassword.layer.cornerRadius = 20
         
         registerCVE.layer.masksToBounds = true
         registerExpireDate.layer.masksToBounds = true
         register16CardNumber.layer.masksToBounds = true
         registeNumber.layer.masksToBounds = true
         registerMail.layer.masksToBounds = true
         registerPassword.layer.masksToBounds = true
     }

    @IBAction func registerButtonTapped(_ sender: Any) {
        let user = RegisterModel(registerPassword: registerPassword.text ?? "",
                                        registerMail: registerMail.text ?? "",
                                        registerNumber: registeNumber.text ?? "",
                                        registerCardNumber: register16CardNumber.text ?? "",
                                        registerExpiryDate: registerExpireDate.text ?? "",
                                        registerCVE: registerCVE.text ?? "")
               
               onUserRegistered?(user.registerMail, user.registerPassword)
               users.append(user)
               manager.saveUser(data: users)
               navigationController?.popViewController(animated: true)
           }
       }
