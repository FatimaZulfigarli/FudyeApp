//
//  RestaurantHeader.swift
//  FudyeApp
//
//  Created by Fatya on 04.06.24.
//

import UIKit

class RestaurantHeader: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //title label
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantPhotosCollection: UICollectionView!
    
    var restaurantData: [Restaurant] = [] {
           didSet {
               restaurantPhotosCollection.reloadData()
               if let firstRestaurant = restaurantData.first {
                   restaurantName.text = firstRestaurant.name ?? "Unknown"
               } else {
                   restaurantName.text = "Unknown"
               }
           }
       }
       
       var didSelectRestaurant: ((Restaurant) -> Void)?
       
       override func awakeFromNib() {
           super.awakeFromNib()
           
           restaurantPhotosCollection.delegate = self
           restaurantPhotosCollection.dataSource = self
           restaurantPhotosCollection.register(UINib(nibName: "RestaurantCell", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
           restaurantPhotosCollection.backgroundColor = .clear
           
           if let firstRestaurant = restaurantData.first {
               restaurantName.text = firstRestaurant.name ?? "Unknown"
           } else {
               restaurantName.text = "Unknown"
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return restaurantData.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell else {
               fatalError("Failed to dequeue RestaurantCell in RestaurantHeader")
           }
           let restaurant = restaurantData[indexPath.item]
           cell.configure(with: restaurant, showName: false, photoFullSize: true)
           
           cell.didSelectRestaurant = { [weak self] in
               self?.didSelectRestaurant?(restaurant)
           }
           
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       }
   }
