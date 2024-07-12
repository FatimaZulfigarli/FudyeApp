//
//  RestaurantCell.swift
//  FudyeApp
//
//  Created by Fatya on 04.06.24.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    //labelde problem var sehv yerde print olur duzelde bilmedim (FoodRestaurantsControllerde sehvdir)
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantPhoto: UIImageView!
    
//    override func awakeFromNib() {
//           super.awakeFromNib()
//           RestaurantPhoto.contentMode = .scaleAspectFill
//           RestaurantPhoto.clipsToBounds = true
//           setupGestureRecognizer()
//           setupConstraints()
//           styleRestaurantName()
//       }
//       
//       override func prepareForReuse() {
//           super.prepareForReuse()
//           RestaurantName.text = nil
//           RestaurantPhoto.image = nil
//       }
//       
//       private func setupGestureRecognizer() {
//           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//           RestaurantPhoto.isUserInteractionEnabled = true
//           RestaurantPhoto.addGestureRecognizer(tapGesture)
//       }
//       
//       @objc private func handleTap() {
//           didSelectRestaurant?()
//       }
//       
//       func configure(with restaurant: Restaurant, showName: Bool = true, photoFullSize: Bool = false) {
//           RestaurantName.isHidden = !showName
//           if showName {
//               RestaurantName.text = restaurant.name ?? "Unknown"
//           }
//           
//           if let photoName = restaurant.restaurantPhoto {
//               RestaurantPhoto.image = UIImage(named: photoName)
//           } else {
//               RestaurantPhoto.image = nil
//           }
//       }
//       
//       var didSelectRestaurant: (() -> Void)?
//       
//       private func setupConstraints() {
//           RestaurantPhoto.translatesAutoresizingMaskIntoConstraints = false
//           RestaurantName.translatesAutoresizingMaskIntoConstraints = false
//           NSLayoutConstraint.activate([
//               RestaurantPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//               RestaurantPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//               RestaurantPhoto.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//               RestaurantPhoto.heightAnchor.constraint(equalTo: contentView.heightAnchor),
//               
//               // Constraints for the label to overlay the photo
//               RestaurantName.leadingAnchor.constraint(equalTo: RestaurantPhoto.leadingAnchor, constant: 8),
//               RestaurantName.trailingAnchor.constraint(equalTo: RestaurantPhoto.trailingAnchor, constant: -8),
//               RestaurantName.bottomAnchor.constraint(equalTo: RestaurantPhoto.bottomAnchor, constant: -8)
//           ])
//       }
//       
//       private func styleRestaurantName() {
//           RestaurantName.textAlignment = .center
//           RestaurantName.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//           RestaurantName.textColor = .white
//           RestaurantName.font = UIFont.boldSystemFont(ofSize: 16)
//           RestaurantName.numberOfLines = 0
//       }
//   }
//    

    var didSelectRestaurant: (() -> Void)?
      
      override func awakeFromNib() {
          super.awakeFromNib()
          restaurantPhoto.contentMode = .scaleAspectFill
          restaurantPhoto.clipsToBounds = true
          setupGestureRecognizer()
//          setupConstraints()
//          styleRestaurantName()
      }
      
      override func prepareForReuse() {
          super.prepareForReuse()
          restaurantName.text = nil
          restaurantPhoto.image = nil
      }
      
      private func setupGestureRecognizer() {
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          restaurantPhoto.isUserInteractionEnabled = true
          restaurantPhoto.addGestureRecognizer(tapGesture)
      }
      
      @objc private func handleTap() {
          didSelectRestaurant?()
      }
      
      func configure(with restaurant: Restaurant, showName: Bool = true, photoFullSize: Bool = false) {
          restaurantName.isHidden = !showName
          if showName {
              restaurantName.text = restaurant.name ?? "Unknown"
          }
          
          if let photoName = restaurant.restaurantPhoto, !photoName.isEmpty {
              restaurantPhoto.image = UIImage(named: photoName)
          } else {
              restaurantPhoto.image = nil
          }
      }
      
      
  }
