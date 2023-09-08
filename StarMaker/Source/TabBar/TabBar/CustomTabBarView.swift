//
//  CustomTabBarView.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import UIKit
import SDWebImage

protocol CustomTabBarViewDelegate {
    func tabSelectedAtIndex(tabIndex: Int)
}

class CustomTabBarView: UIView
{
    //MARK: - All outlets
    
    @IBOutlet var btnTabs: [UIButton]!
    @IBOutlet var imgTabs: [UIImageView]!
    @IBOutlet weak var btnTabHeightConstraint: NSLayoutConstraint!
    @IBOutlet var lblTitle: [UILabel]!
    @IBOutlet var viwTabs: [UIView]!
    
    //MARK: - All variables
    var delegate: CustomTabBarViewDelegate?
    
    var selectedIndex: Int = 0
    var normalColor = #colorLiteral(red: 0.5803921569, green: 0.5803921569, blue: 0.5803921569, alpha: 1)
    var selectedColor = #colorLiteral(red: 0.07843137255, green: 0.2588235294, blue: 0.3647058824, alpha: 1)
    
    //MARK: -
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    
    }
    
    //MARK: - All methods
//    func selectTabAt(index: Int) {
//        selectedIndex = index
//
//        for btn in btnTabs {
//            if(btn.tag == index){
//                btn.isSelected = true
//
//            }
//            else {
//                btn.isSelected = false
//            }
//        }
//
//        for img in imgTabs {
//            if(img.tag == index){
//                img.isHighlighted = true
//            }
//            else {
//                img.isHighlighted = false
//            }
//        }
//
////        imgTabs[].image = UIImage(named: "serviceReport")?.sd_tintedImage(with: UIColor.white)
////        imgTabs[4].highlightedImage = UIImage(named: "serviceReport")?.sd_tintedImage(with: UIColor.white)
//
//        if selectedIndex == 0 || lblTitle[index].text!.lowercased() == "More".lowercased() {
//            hideButtonForFacilitySelection(isHidden: true)
//        } else {
//            hideButtonForFacilitySelection(isHidden: false)
//        }
//
//        delegate?.tabSelectedAtIndex(tabIndex: selectedIndex)
//    }
    
//    func hideButtonForFacilitySelection(isHidden : Bool) {
//        viwTabs[1].isHidden = isHidden
//        viwTabs[2].isHidden = isHidden
////        viwTabs[4].isHidden = isHidden
//        viwTabs[3].isHidden = !isHidden
//
//
////        if isHidden == true {
////            lblTitle[3].text = "More"
////            imgTabs[3].image = UIImage(named: "more")
////            imgTabs[3].highlightedImage = UIImage(named: "more")
////        } else {
////            lblTitle[3].text = "Service Report"
////
////        }
//
//    }
    
    //MARK: - All button click events
    @IBAction func onBtnTab(_ sender: UIButton)
    {
//        selectedIndex = sender.tag
//
//        selectTabAt(index: selectedIndex)
    }


}
