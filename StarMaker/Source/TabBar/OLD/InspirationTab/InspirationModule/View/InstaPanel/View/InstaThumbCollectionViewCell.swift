//
//  InstaThumbCollectionViewCell.swift
//  Ani AI
//
//  Created by Raghu on 01/09/23.
//

import UIKit

class InstaThumbCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnSummary: UIButton!
    @IBOutlet weak var btnSimilar: UIButton!
    @IBOutlet weak var btnBookMark: UIButton!
    @IBOutlet weak var instaImageView: UIImageView!
    var closureSummary: ((_ indexSummary: Int)->())?
    var closureBookMark: ((_ indexBookMark: Int)->())?
    var closureSimilar: ((_ indexSimilar: Int)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func similarBtnAction(_ sender: UIButton) {
        if let action = self.closureSimilar{
            action(sender.tag)
        }
    }
    @IBAction func bookMarkBtnAction(_ sender: UIButton) {
        if let action = closureBookMark{
            action(sender.tag)
        }
    }
    @IBAction func summaryBtnAction(_ sender: UIButton) {
        if let action = self.closureSummary{
            action(sender.tag)
        }
    }
    func cellConfig(_ imageID: String){
        self.instaImageView.sd_setImage(with: URL(string: "https://storage.googleapis.com/animeta-images/videoThumbNails/\(imageID).jpg"))
    }
}
