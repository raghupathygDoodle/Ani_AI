//
//  SubCategoryCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 02/08/23.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var viewTick: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var imageTick: UIImageView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var imageSubCategory: UIImageView!
    @IBOutlet weak var backgroudsView: UIView!
    var closureSelect:((_ selectIndex: Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroudsView.layer.cornerRadius = self.backgroudsView.bounds.height / 2
        self.viewTick.layer.cornerRadius = self.viewTick.bounds.height / 2
        self.imageTick.layer.cornerRadius = self.imageTick.bounds.height / 2
        // Initialization code
    }

//    func cellConfig(_ data: Datum){
//        if data.thumbnail == nil{
//            self.imageSubCategory.isHidden = true
//            self.lblPlaceholder.isHidden = false
//            let stringValue: String = data.name ?? ""
//            let stringPlaceholder = Array(stringValue)
//            self.lblPlaceholder.text = "\(stringPlaceholder.first ?? "A")"
//            print("array \(stringPlaceholder.first)")
//
//        }else{
//            self.lblPlaceholder.isHidden = true
//            self.imageSubCategory.isHidden = false
//            self.imageSubCategory.sd_setImage(with: URL(string: data.thumbnail ?? ""))
//        }
//
//        self.lblSubCategory.text = data.name
//
//    }
    @IBAction func selectBtnAction(_ sender: UIButton) {
        if let action = self.closureSelect{
            action(sender.tag)
        }
    }
    func cellConfig(_ data: SubCategoriesData){
        if data.thumbnail == nil{
            self.imageSubCategory.isHidden = true
            self.lblPlaceholder.isHidden = false
            let stringValue: String = data.subcategory1 ?? ""
            let stringPlaceholder = Array(stringValue)
            self.lblPlaceholder.text = "\(stringPlaceholder.first ?? "A")"
            print("array \(stringPlaceholder.first)")
            
        }else{
            self.lblPlaceholder.isHidden = true
            self.imageSubCategory.isHidden = false
            if let urlString = data.thumbnail?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: urlString) {
                  
                    self.imageSubCategory.sd_setImage(with: url)
                    }
                }
        }
        
        self.lblSubCategory.text = data.subcategory1
        
    }
}
