//
//  SearchController.swift
//  FudyeApp
//
//  Created by Fatya on 19.06.24.
//

import UIKit

class SearchController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
   
    var allFoods: [Food] = []
        var searchController: UISearchController!
        let menuManager = MenuManagerHelper()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "Search Foods"
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "\(RestaurantMenuCell.self)", bundle: nil), forCellReuseIdentifier: "RestaurantMenuCell")
            
            setupSearchController()
            
            // Load and parse menu data
            menuManager.callback = { [weak self] in
                guard let self = self else { return }
                self.allFoods = self.getUniqueFoods(from: self.menuManager.extractAllFoods())
                self.tableView.reloadData()
            }
            menuManager.parseMenu()
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let foodRestaurantsController = storyboard.instantiateViewController(withIdentifier: "FoodRestaurantsController") as? FoodRestaurantsController {
                let selectedFood = allFoods[indexPath.row]
                
                // Filter restaurants that offer the selected food
                let restaurantsOfferingFood = menu.flatMap { $0.restaurants }.filter { restaurant in
                    restaurant.foods.contains { $0.foodName == selectedFood.foodName }
                }
                
                // Pass the filtered restaurants to the next controller
                foodRestaurantsController.restaurants = restaurantsOfferingFood
                foodRestaurantsController.foodName = selectedFood.foodName
                
                navigationController?.pushViewController(foodRestaurantsController, animated: true)
            }
        }

        private func setupSearchController() {
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search Foods"
            navigationItem.searchController = searchController
            definesPresentationContext = true
        }

        private func isSearchBarEmpty() -> Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        }

        private func filterContentForSearchText(_ searchText: String) {
            if isSearchBarEmpty() {
                allFoods = getUniqueFoods(from: menuManager.extractAllFoods())
            } else {
                allFoods = getUniqueFoods(from: menuManager.extractAllFoods().filter { $0.foodName?.lowercased().contains(searchText.lowercased()) ?? false })
            }
            tableView.reloadData()
        }
        
        private func getUniqueFoods(from foods: [Food]) -> [Food] {
            var seenNames: Set<String> = []
            return foods.filter { food in
                guard let name = food.foodName else { return false }
                if seenNames.contains(name) {
                    return false
                } else {
                    seenNames.insert(name)
                    return true
                }
            }
        }
    }

    extension SearchController: UISearchResultsUpdating {
        func updateSearchResults(for searchController: UISearchController) {
            let searchBar = searchController.searchBar
            filterContentForSearchText(searchBar.text ?? "")
        }
    }

    extension SearchController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allFoods.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantMenuCell", for: indexPath) as! RestaurantMenuCell
            let food = allFoods[indexPath.row]
            cell.configureForSimpleView(with: food)
            return cell
        }
    }
