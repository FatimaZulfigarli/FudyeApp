//
//  CuisineController.swift
//  FudyeApp
//
//  Created by Fatya on 30.05.24.
//

import UIKit

class CuisineController: UIViewController {

    @IBOutlet weak var cuisineCollection: UICollectionView!
    
    private var viewModel = CuisineViewModel()
       var selectedCuisine: Menu?
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           cuisineCollection.register(UINib(nibName: "CuisineCell", bundle: nil), forCellWithReuseIdentifier: "CuisineCell")
           cuisineCollection.delegate = self
           cuisineCollection.dataSource = self
           
           viewModel.reloadCollectionView = { [weak self] in
               self?.cuisineCollection.reloadData()
           }
           
           viewModel.fetchCuisine()
       }
   }

   extension CuisineController: UICollectionViewDataSource {
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return viewModel.numberOfItems()
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CuisineCell", for: indexPath) as! CuisineCell
           cell.configure(data: viewModel.item(at: indexPath.item))
           return cell
       }
   }

   extension CuisineController: UICollectionViewDelegate {
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           selectedCuisine = viewModel.item(at: indexPath.item)
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let restaurantController = storyboard.instantiateViewController(withIdentifier: "RestaurantController") as? RestaurantController {
               restaurantController.selectedCuisine = selectedCuisine
               self.navigationController?.show(restaurantController, sender: nil)
           }
       }
   }

   extension CuisineController: UICollectionViewDelegateFlowLayout {
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = (collectionView.frame.width / 2) - 15
           return CGSize(width: width, height: width)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 15
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 15
       }
   }
