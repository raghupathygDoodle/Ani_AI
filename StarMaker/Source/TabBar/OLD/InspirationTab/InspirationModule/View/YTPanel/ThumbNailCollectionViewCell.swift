//
//  ThumbNailCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 29/07/23.
//

import UIKit

class ThumbNailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnPlayInsta: UIButton!
    @IBOutlet weak var imageThumbNail: UIImageView!
    var closureInstaPlay: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func instaPlayBtnAction(_ sender: UIButton) {
        if let action = closureInstaPlay{
            action()
        }
    }
    func cellConfig(_ imageID: String){
        self.imageThumbNail.sd_setImage(with: URL(string: "https://storage.googleapis.com/animeta-images/videoThumbNails/\(imageID).jpg"))
    }
}
