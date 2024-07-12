import UIKit

class FoodRestaurantsController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var restaurants: [Restaurant] = []
      var foodName: String?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          title = foodName
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.register(UINib(nibName: "\(RestaurantCell.self)", bundle: nil), forCellWithReuseIdentifier: "RestaurantCell")
      }
  }

  extension FoodRestaurantsController: UICollectionViewDelegate, UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return restaurants.count
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
          let restaurant = restaurants[indexPath.row]
          cell.configure(with: restaurant, showName: true, photoFullSize: false)
          
          cell.didSelectRestaurant = { [weak self] in
              self?.navigateToMenu(for: restaurant)
          }
          
          return cell
      }

      private func navigateToMenu(for restaurant: Restaurant) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          if let menuController = storyboard.instantiateViewController(withIdentifier: "MenuController") as? MenuController {
              menuController.restaurant = restaurant
              navigationController?.pushViewController(menuController, animated: true)
          }
      }
  }
