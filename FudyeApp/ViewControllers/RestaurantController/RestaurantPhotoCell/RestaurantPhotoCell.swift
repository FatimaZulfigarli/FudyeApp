//
//  RestaurantPhotoCell.swift
//  FudyeApp
//
//  Created by Fatya on 05.06.24.
//

import UIKit

class RestaurantPhotoCell: UICollectionViewCell {
    @IBOutlet weak var restaurantPhotoCollection: UICollectionView!
    //xib cell yaradib icine textfield qoyacam sea
    var restaurant: Restaurant?
       var didSelectRestaurant: ((Restaurant) -> Void)?

       override func awakeFromNib() {
           super.awakeFromNib()

           restaurantPhotoCollection.dataSource = self
           restaurantPhotoCollection.delegate = self
//           restaurantPhotoCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
           restaurantPhotoCollection.register(UINib(nibName: "RestaurantHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RestaurantHeader")
           restaurantPhotoCollection.register(UINib(nibName: "AboutRestaurantCell", bundle: nil), forCellWithReuseIdentifier: "AboutRestaurantCell")
       }

       func configure(with restaurant: Restaurant, didSelectRestaurant: @escaping (Restaurant) -> Void) {
           self.restaurant = restaurant
           self.didSelectRestaurant = didSelectRestaurant
           restaurantPhotoCollection.reloadData()
           setNeedsLayout()
           layoutIfNeeded()
       }
   }

   extension RestaurantPhotoCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 1
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutRestaurantCell", for: indexPath) as! AboutRestaurantCell
           if let restaurant = restaurant {
               cell.configure(with: restaurant.aboutRestaurant)
           }
           return cell
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3)
       }
       
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           if kind == UICollectionView.elementKindSectionHeader {
               guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RestaurantHeader", for: indexPath) as? RestaurantHeader else {
                   fatalError("Failed to dequeue RestaurantHeader")
               }
               if let restaurant = restaurant {
                   header.restaurantData = [restaurant]
                   header.didSelectRestaurant = { [weak self] selectedRestaurant in
                       self?.didSelectRestaurant?(selectedRestaurant)
                   }
               }
               return header
           }
           return UICollectionReusableView()
       }
   }
