//
//  SubCategoryListCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 02/07/23.
//

import UIKit

class SubCategoryListCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var labelDetailSubCategory: UILabel!
    @IBOutlet weak var viewDetailSubCategory: UIView!
    @IBOutlet weak var labelTitleSubCategory: UILabel!
    @IBOutlet weak var selectCategoryButton: UIButton!
    var closureSelectCategory:((_ index: Int)->())?
//    @IBOutlet weak var viewTitleSubcategory: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func buttonSelectSubCategory(_ sender: UIButton) {
        if let action = closureSelectCategory{
            action(sender.tag)
        }
    }
    
}
