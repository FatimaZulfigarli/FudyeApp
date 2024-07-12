//
//  MenuController.swift
//  FudyeApp
//
//  Created by Fatya on 05.06.24.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let menuManager = MenuManagerHelper()
        var foods: [Food] = []
        var selectedFoods: [FoodItem] = []
        var restaurant: Restaurant?

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let basketCleared = UserDefaults.standard.value(forKey: "basketCleared") as? Bool, basketCleared {
                clearBasketLabels()
                UserDefaults.standard.set(false, forKey: "basketCleared")
            }
            tableView.reloadData()
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            title = restaurant?.name ?? "Menu"
            let basketButton = UIBarButtonItem(image: UIImage(systemName: "basket"), style: .plain, target: self, action: #selector(basketItemTapped))
            navigationItem.rightBarButtonItem = basketButton
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "\(RestaurantMenuCell.self)", bundle: nil), forCellReuseIdentifier: "RestaurantMenuCell")
            if let restaurantFoods = restaurant?.foods {
                foods = restaurantFoods
            }
            tableView.reloadData()
        }

        @objc func basketItemTapped() {
            if let basketNavigator = storyboard?.instantiateViewController(withIdentifier: "BasketViewController") as? BasketViewController {
                basketNavigator.selectedFoods = selectedFoods // Pass selected foods to the basket
                basketNavigator.onBasketCleared = { [weak self] in
                    self?.clearBasketLabels()
                }
                navigationController?.pushViewController(basketNavigator, animated: true)
            }
        }

        private func clearBasketLabels() {
            selectedFoods.removeAll()
            tableView.reloadData()
        }

        private func showAddedToBasketAlert() {
            let alert = UIAlertController(title: "Success", message: "Item added to basket", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }

    extension MenuController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return foods.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantMenuCell", for: indexPath) as! RestaurantMenuCell
            let food = foods[indexPath.row]
            cell.configure(with: food)
            cell.addBasketCallBack = { [weak self] selectedFood in
                guard let self = self else { return }
                if let existingIndex = self.selectedFoods.firstIndex(where: { $0.food == selectedFood }) {
                    self.selectedFoods[existingIndex].count += 1
                } else {
                    self.selectedFoods.append(FoodItem(food: selectedFood, count: 1))
                }
                self.showAddedToBasketAlert()
            }
            return cell
        }
    }
