//
//  CategoryListCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 01/07/23.
//

import UIKit

class CategoryListCollectionViewCell: UICollectionViewCell {

    var closureSelectCategory:((_ index: Int)->())?
    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet weak var labelCategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonSelectCategory(_ sender: UIButton) {
        closureSelectCategory?(sender.tag)
        
    }
}
