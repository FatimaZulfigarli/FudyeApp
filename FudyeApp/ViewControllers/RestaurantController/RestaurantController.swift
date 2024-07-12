//
//  RestaurantController.swift
//  FudyeApp
//
//  Created by Fatya on 04.06.24.
//

import UIKit

class RestaurantController: UIViewController {
    @IBOutlet weak var restaurantCollection: UICollectionView!
    
    private var viewModel: RestaurantViewModel!
      
      var selectedCuisine: Menu? {
          didSet {
              viewModel = RestaurantViewModel(selectedCuisine: selectedCuisine)
          }
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          title = selectedCuisine?.cuisineName
          
          guard let collection = restaurantCollection else {
              print("RestaurantCollection outlet is not connected")
              return
          }
          
          collection.register(UINib(nibName: "RestaurantPhotoCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantPhotoCell")
          collection.delegate = self
          collection.dataSource = self
          collection.backgroundColor = .clear
          collection.isPagingEnabled = true
          
          viewModel.reloadCollectionView = { [weak self] in
              self?.restaurantCollection.reloadData()
          }
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          // RestaurantCollection.reloadData()
      }
  }

  extension RestaurantController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel.numberOfItems()
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantPhotoCell", for: indexPath) as! RestaurantPhotoCell
          let restaurant = viewModel.item(at: indexPath.item)
          cell.configure(with: restaurant) { [weak self] selectedRestaurant in
              self?.navigateToMenuController(with: selectedRestaurant)
          }
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let selectedRestaurant = viewModel.item(at: indexPath.item)
          navigateToMenuController(with: selectedRestaurant)
      }
      
      private func navigateToMenuController(with restaurant: Restaurant) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          if let menuController = storyboard.instantiateViewController(withIdentifier: "MenuController") as? MenuController {
              menuController.restaurant = restaurant
              print("Navigating to MenuController with restaurant: \(restaurant.name ?? "Unknown")")
              navigationController?.pushViewController(menuController, animated: true)
          } else {
              print("Failed to instantiate MenuController")
          }
      }
  }
