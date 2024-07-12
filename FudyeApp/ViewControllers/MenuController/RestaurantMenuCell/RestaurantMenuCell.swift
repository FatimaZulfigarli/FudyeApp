//
//  RestaurantMenuCell.swift
//  FudyeApp
//
//  Created by Fatya on 05.06.24.
//

import UIKit

class RestaurantMenuCell: UITableViewCell {
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var foodPhoto: UIImageView!
    @IBOutlet weak var orderCount: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    var addBasketCallBack: ((Food) -> Void)?
      var reloadCallback: (() -> Void)?
      
      var food: Food?
      var currentCount: Int = 0
      
      override func awakeFromNib() {
          super.awakeFromNib()
      }
      
      func configure(with food: Food) {
          self.food = food
          foodName.text = food.foodName
          if let foodPhotoName = food.foodPhoto {
              foodPhoto.image = UIImage(named: foodPhotoName)
          } else {
              foodPhoto.image = nil
          }
          if let price = food.foodPrice {
              foodPrice.text = price
          } else {
              foodPrice.text = nil
          }
          currentCount = fetchCurrentCount(for: food)
          updateOrderCountLabel()
      }
      
      func configureForSimpleView(with food: Food) {
          self.food = food
          foodName.text = food.foodName
          if let foodPhotoName = food.foodPhoto {
              foodPhoto.image = UIImage(named: foodPhotoName)
          } else {
              foodPhoto.image = nil
          }
          hideAdditionalElements()
      }
      
      func showAdditionalElements() {
          foodPrice.isHidden = false
          orderCount.isHidden = false
          addButton.isHidden = false
          removeButton.isHidden = false
      }
      
      func hideAdditionalElements() {
          foodPrice.isHidden = true
          orderCount.isHidden = true
          addButton.isHidden = true
          removeButton.isHidden = true
      }
      
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
      }
      

       @IBAction func removeButtonTapped(_ sender: Any) {
           if currentCount > 0 {
                      currentCount -= 1
                      updateOrderCountLabel()
                      if let food = food {
                          OrderManager.shared.updateFoodInOrder(food, count: currentCount)
                      }
                  }
              }

       @IBAction func addButtonTapped(_ sender: Any) {
           currentCount += 1
                  updateOrderCountLabel()
                  if let food = food {
                      OrderManager.shared.updateFoodInOrder(food, count: currentCount)
                      addBasketCallBack?(food) // Invoke the callback with the current food
                  }
              }
              
              func updateOrderCountLabel() {
                  orderCount.text = "\(currentCount)"
              }
              
              private func fetchCurrentCount(for food: Food) -> Int {
                  let currentOrder = OrderManager.shared.fetchCurrentOrder()
                  if let foodItem = currentOrder.first(where: { $0.food == food }) {
                      return foodItem.count
                  }
                  return 0
              }
          }
