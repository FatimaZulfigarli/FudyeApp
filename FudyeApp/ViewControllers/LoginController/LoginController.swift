//
//  LoginController.swift
//  FudyeApp
//
//  Created by Fatya on 30.05.24.
//

import UIKit
import Lottie

class LoginController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var logoVieww: UIImageView!
    @IBOutlet weak var lottieView: LottieAnimationView!
    private var viewModel = LoginViewModel()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          lottieView.play()
          getShape()
      }
      
      func getShape() {
          passwordTextField.layer.cornerRadius = 20
          mailTextField.layer.cornerRadius = 20
          
          passwordTextField.layer.masksToBounds = true
          mailTextField.layer.masksToBounds = true
      }
      
      @IBAction func loginButtonTapped(_ sender: Any) {
          viewModel.email = mailTextField.text ?? ""
                 viewModel.password = passwordTextField.text ?? ""
                 
                 viewModel.loginUser { success in
                     if success {
                         if let controller = self.storyboard?.instantiateViewController(withIdentifier: "CuisineController") as? CuisineController {
                             self.navigationController?.show(controller, sender: nil)
                         }
                     } else {
                         self.showError(message: self.viewModel.errorMessage ?? "Unknown error")
                     }
                 }
             }
      
      @IBAction func signupButtonTapped(_ sender: Any) {
          if let controller = storyboard?.instantiateViewController(withIdentifier: "RegisterController") as? RegisterController {
                     controller.onUserRegistered = { [weak self] email, password in
                         self?.mailTextField.text = email
                         self?.passwordTextField.text = password
                     }
                     navigationController?.show(controller, sender: nil)
                 }
             }
             
             func showError(message: String) {
                 let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                 self.present(alert, animated: true, completion: nil)
             }
         }
