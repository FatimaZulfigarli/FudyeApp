//
//  RestaurantViewModel.swift
//  FudyeApp
//
//  Created by Fatya on 29.06.24.
//

import Foundation

class RestaurantViewModel {
    var selectedCuisine: Menu?
    var filteredRestaurants: [Restaurant] = []
    var reloadCollectionView: (() -> Void)?
    
    init(selectedCuisine: Menu?) {
        self.selectedCuisine = selectedCuisine
        if let selectedCuisine = selectedCuisine {
            filteredRestaurants = selectedCuisine.restaurants
        }
    }
    
    func numberOfItems() -> Int {
        return filteredRestaurants.count
    }
    
    func item(at index: Int) -> Restaurant {
        return filteredRestaurants[index]
    }
}
