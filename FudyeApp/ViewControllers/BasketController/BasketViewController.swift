//
//  BasketViewController.swift
//  FudyeApp
//
//  Created by Fatya on 07.06.24.
//

import UIKit

class BasketViewController: UIViewController {
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //mvvme kecire bilmedim 
    var selectedFoods: [FoodItem] = []
    var onFoodItemDeleted: ((Food) -> Void)?
    var onOrderComplete: (() -> Void)?
    var onBasketCleared: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedFoods = OrderManager.shared.fetchCurrentOrder()
        tableView.reloadData()
        updateTotalAmount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        tableView.dataSource = self
        tableView.delegate = self
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc func logoutButtonTapped() {
        if let email = UserDefaults.standard.string(forKey: "currentUserEmail") {
            var users = OrderManager.shared.fetchAllUsers()
            if let index = users.firstIndex(where: { $0.registerMail == email }) {
                users[index].basket = OrderManager.shared.fetchCurrentOrder()
                OrderManager.shared.saveUser(data: users)
            }
        }
        // Clear current order to ensure no basket data is left
        OrderManager.shared.clearOrderFile()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate = scene?.delegate as? SceneDelegate {
            sceneDelegate.setLoginAsRoot()
        }
    }
    
    private func updateTotalAmount() {
        let total = selectedFoods.reduce(0.0) { $0 + ($1.food.priceValue ?? 0.0) * Double($1.count) }
        totalAmount.text = String(format: "Your total price is $%.2f", total)
    }
    
    
    @IBAction func proceedToOrder(_ sender: Any)  {
        if let orderController = storyboard?.instantiateViewController(withIdentifier: "OrderController") as? OrderController {
            orderController.selectedFoods = selectedFoods
            orderController.onOrderComplete = { [weak self] in
                self?.selectedFoods.removeAll()
                self?.tableView.reloadData()
                self?.updateTotalAmount()
                self?.onBasketCleared?()
            }
            navigationController?.pushViewController(orderController, animated: true)
        }
    }
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        let foodItem = selectedFoods[indexPath.row]
        cell.configure(with: foodItem)
        return cell
    }
}

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let foodItem = selectedFoods.remove(at: indexPath.row)
            OrderManager.shared.updateFoodInOrder(foodItem.food, count: 0)
            onFoodItemDeleted?(foodItem.food)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalAmount()
        }
    }
}
