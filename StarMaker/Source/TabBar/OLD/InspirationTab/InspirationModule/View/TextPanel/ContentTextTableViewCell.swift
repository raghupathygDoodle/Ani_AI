//
//  ContentTextTableViewCell.swift
//  StarMaker
//
//  Created by Raghu on 20/07/23.
//

import UIKit

class ContentTextTableViewCell: UITableViewCell {

    @IBOutlet weak var labelContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(with text: String) {
            // Create a custom paragraph style
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 08 // Set the desired line spacing value here (adjust as needed)

            // Create an attributed string with the custom paragraph style
            let attributedString = NSAttributedString(
                string: text,
                attributes: [
                    .font: labelContent.font ?? "", // Use the same font as your label
                    .paragraphStyle: paragraphStyle
                ]
            )

            // Set the attributed text to the label
            labelContent.attributedText = attributedString
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
