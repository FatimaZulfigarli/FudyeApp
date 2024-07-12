//
//  CuisineCell.swift
//  FudyeApp
//
//  Created by Fatya on 01.06.24.
//

import UIKit

class CuisineCell: UICollectionViewCell {

    @IBOutlet weak var cuisineView: UIView!
    @IBOutlet weak var cuisineName: UILabel!
    @IBOutlet weak var cuisineImage: UIImageView!
    override func awakeFromNib() {
           super.awakeFromNib()
           setupUI()
       }

       func setupUI() {
           cuisineView.layer.cornerRadius = 10
           cuisineView.layer.shadowColor = UIColor.black.cgColor
           cuisineView.layer.shadowOpacity = 0.2
           cuisineView.layer.shadowOffset = CGSize(width: 0, height: 1)
           cuisineView.layer.shadowRadius = 4

           cuisineImage.layer.cornerRadius = 10
           cuisineImage.layer.masksToBounds = true
           cuisineImage.contentMode = .scaleAspectFill
       }

       func configure(data: Menu) {
           cuisineName.text = data.cuisineName
           if let photoName = data.cuisinePhoto {
               cuisineImage.image = UIImage(named: photoName)
           } else {
               cuisineImage.image = nil
           }
       }
   }
