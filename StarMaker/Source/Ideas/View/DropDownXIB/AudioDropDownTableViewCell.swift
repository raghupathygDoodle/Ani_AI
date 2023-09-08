//
//  AudioDropDownTableViewCell.swift
//  StarMaker
//
//  Created by Raghu on 05/08/23.
//

import UIKit

class AudioDropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var lblDropDown: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfig(_ data: String){
        self.lblDropDown.text = data
    }
}
