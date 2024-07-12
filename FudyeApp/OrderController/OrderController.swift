//
//  OrderController.swift
//  FudyeApp
//
//  Created by Fatya on 22.06.24.
//

import UIKit

class OrderController: UIViewController {
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cveLabel: UILabel!
    
    var selectedFoods: [FoodItem] = []
    var onOrderComplete: (() -> Void)?
    
    let fileManagerHelper = FileManagerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch user data and update labels
        fileManagerHelper.getUser { [weak self] users in
            guard let self = self, let user = users.first else { return }
            self.cardNumber.text = user.registerCardNumber
            self.dateLabel.text = user.registerExpiryDate
            self.cveLabel.text = user.registerCVE
        }
    }
    
    @IBAction func payButtonTapped(_ sender: Any) {
        let userBalance: Double = 100.0
        let totalAmount = selectedFoods.reduce(0.0) { $0 + ($1.food.priceValue ?? 0.0) * Double($1.count) }
        
        if totalAmount > userBalance {
            showAlert(title: "Payment Failed", message: "Insufficient balance")
        } else {
            processSuccessfulPayment()
        }
    }
    
    private func processSuccessfulPayment() {
        showAlert(title: "Payment Successful", message: "Paid successfully") {
            OrderManager.shared.clearOrderFile()
            self.onOrderComplete?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
