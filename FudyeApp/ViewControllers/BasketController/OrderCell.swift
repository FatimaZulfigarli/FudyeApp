//
//  OrderCell.swift
//  FudyeApp
//
//  Created by Fatya on 14.06.24.
//

import UIKit
//foodPhoto orderCount foodPrice foodName
class OrderCell: UITableViewCell {
    
    @IBOutlet weak var orderCount: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPhoto: UIImageView!
    
    var food: Food?
    var currentCount: Int = 0
       
       override func awakeFromNib() {
           super.awakeFromNib()
           setupConstraints()
       }
       
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
       
       func configure(with foodItem: FoodItem) {
           self.food = foodItem.food
           self.currentCount = foodItem.count
           
           foodName.text = foodItem.food.foodName
           if let foodPhotoName = foodItem.food.foodPhoto {
               foodPhoto.image = UIImage(named: foodPhotoName)
           } else {
               foodPhoto.image = nil
           }
           updateOrderCountLabel()
           updatePriceLabel()
       }
       
       private func updateOrderCountLabel() {
           orderCount.text = "\(currentCount)"
           print("Updated order count to \(currentCount)") // Debugging print
       }
       
       private func updatePriceLabel() {
           if let price = food?.priceValue {
               let totalPrice = price * Double(currentCount)
               foodPrice.text = String(format: "$%.2f", totalPrice)
           } else {
               foodPrice.text = nil
           }
       }
       
       private func setupConstraints() {
           foodPhoto.translatesAutoresizingMaskIntoConstraints = false
           foodName.translatesAutoresizingMaskIntoConstraints = false
           foodPrice.translatesAutoresizingMaskIntoConstraints = false
           orderCount.translatesAutoresizingMaskIntoConstraints = false

           // Food Photo Constraints
           NSLayoutConstraint.activate([
               foodPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
               foodPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               foodPhoto.heightAnchor.constraint(equalToConstant: 80),
               foodPhoto.widthAnchor.constraint(equalTo: foodPhoto.heightAnchor) // Assuming square photo
           ])

           // Food Name Constraints
           NSLayoutConstraint.activate([
               foodName.leadingAnchor.constraint(equalTo: foodPhoto.trailingAnchor, constant: 12),
               foodName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
               foodName.trailingAnchor.constraint(equalTo: foodPrice.leadingAnchor, constant: -12)
           ])

           // Food Price Constraints
           NSLayoutConstraint.activate([
               foodPrice.leadingAnchor.constraint(equalTo: foodName.trailingAnchor, constant: 12),
               foodPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
               foodPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
           ])

           // Order Count Constraints
           NSLayoutConstraint.activate([
               orderCount.leadingAnchor.constraint(equalTo: foodPhoto.trailingAnchor, constant: 12),
               orderCount.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 8),
               orderCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
               orderCount.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
           ])
       }
   }
