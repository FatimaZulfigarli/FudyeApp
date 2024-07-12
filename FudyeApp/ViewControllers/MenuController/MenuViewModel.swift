//
//  MenuViewModel.swift
//  FudyeApp
//
//  Created by Fatya on 29.06.24.
//

import Foundation

class MenuViewModel {
    var foods: [Food] = []
    var selectedFoods: [FoodItem] = []
    var restaurant: Restaurant?
    
    var reloadTableView: (() -> Void)?
    var showAlert: ((String, String) -> Void)?
    
    init(restaurant: Restaurant?) {
        self.restaurant = restaurant
        if let restaurantFoods = restaurant?.foods {
            foods = restaurantFoods
        }
    }
    
    func numberOfRows() -> Int {
        return foods.count
    }
    
    func food(at index: Int) -> Food {
        return foods[index]
    }
    
    func addToBasket(_ selectedFood: Food) {
        if let existingIndex = selectedFoods.firstIndex(where: { $0.food == selectedFood }) {
            selectedFoods[existingIndex].count += 1
        } else {
            selectedFoods.append(FoodItem(food: selectedFood, count: 1))
        }
        showAlert?("Success", "Item added to basket")
    }
    
    func clearBasket() {
        selectedFoods.removeAll()
        reloadTableView?()
    }
    
    func fetchFoods() {
        if let restaurantFoods = restaurant?.foods {
            foods = restaurantFoods
        }
        reloadTableView?()
    }
}
