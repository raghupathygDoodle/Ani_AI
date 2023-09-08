//
//  MainCategoriesCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 01/08/23.
//

import UIKit
import Kingfisher

class MainCategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfig(_ data: Category){
        self.categoriesLabel.text = data.displayName
        if let urlString = data.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString) {
              
                self.imageCategory.sd_setImage(with: url)
                }
            }
    }
}
