//
//  AboutRestaurantCell.swift
//  FudyeApp
//
//  Created by Fatya on 28.06.24.
//

import UIKit

class AboutRestaurantCell: UICollectionViewCell {

    @IBOutlet weak var aboutTextView: UITextView!
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }
      
      func configure(with text: String?) {
//          aboutTextField.text = text
          aboutTextView.text = text
      }
  }
