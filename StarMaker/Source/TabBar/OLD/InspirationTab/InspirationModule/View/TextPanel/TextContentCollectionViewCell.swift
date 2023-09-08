//
//  TextContentCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 20/07/23.
//

import UIKit
import MarqueeLabel
class TextContentCollectionViewCell: UICollectionViewCell {

//    @IBOutlet weak var headingLabel: MarqueeLabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textContentTableView: UITableView!
    var textContentResponse: GetVideoData?
    var searchContentResponse: SearchCategoryDatum?
    var similarTextContentResponse: SimilarVideoData?
    var languageText = ""
    var languageStatus = false
    var similarStatus = false
    var searchStatus = false
    override func awakeFromNib() {
        super.awakeFromNib()
        textContentTableView.register(UINib(nibName: "ContentTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTextTableViewCell")
        textContentTableView.delegate = self
        textContentTableView.dataSource = self
        textContentTableView.reloadData()
        // Initialization code
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    func cellConfig(_ data: GetVideoData,_ langStatus: Bool,_ language: String){
        
        self.textContentResponse = data
        self.headingLabel.text = data.videoTitle
        self.languageStatus = langStatus
        self.textSelection(language, data)
        self.textContentTableView.reloadData()
        
    }
    func cellSimilarConfig(_ data: SimilarVideoData, _ langStatus: Bool, _ language: String){
        self.similarStatus = true
        self.similarTextContentResponse = data
        self.headingLabel.text = data.videoTitle
        self.languageStatus = langStatus
       
//        self.languageText = language
        self.similarTextSelection(language, data)
        self.textContentTableView.reloadData()
    }
    func cellSearchConfig(_ data: SearchCategoryDatum,_ langStatus: Bool, _ language: String){
        self.searchStatus = true
        self.searchContentResponse = data
        self.headingLabel.text = data.titleEn
        self.languageStatus = langStatus
        self.textSelection(language, data)
        self.textContentTableView.reloadData()
    }

}
extension TextContentCollectionViewCell: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTextTableViewCell", for: indexPath) as? ContentTextTableViewCell else{return UITableViewCell()}
        if languageStatus{
            cell.configureCell(with: self.languageText)
        }else{
            if similarStatus{
                cell.configureCell(with: similarTextContentResponse?.summary ?? "")
            }else if searchStatus{
                cell.configureCell(with: searchContentResponse?.summaryEn ?? "")
            } else{
                cell.configureCell(with: textContentResponse?.summary ?? "")
            }
            
        }
        
        return cell
    }
    
    func textSelection(_ textLanguage: String,_ textResponse: GetVideoData){
        switch textLanguage {
        case "English":
            self.languageText = textResponse.summary ?? ""
        case "Hindi":
            self.languageText = textResponse.hindi ?? ""
        case "Tamil":
            self.languageText = textResponse.tamil ?? ""
        case "Bengali":
            self.languageText = textResponse.bengali ?? ""
        case "Telugu":
            self.languageText = textResponse.telugu ?? ""
        case "Marathi":
            self.languageText = textResponse.marathi ?? ""
        case "Gujarathi":
            self.languageText = textResponse.gujarathi ?? ""
        case "Kannada":
            self.languageText = textResponse.kannada ?? ""
        case "Malayalam":
            self.languageText = textResponse.malayalam ?? ""
        default:
            break
        }
    }
    func textSelection(_ textLanguage: String,_ textResponse: SearchCategoryDatum){
        switch textLanguage {
        case "English":
            self.languageText = textResponse.summaryEn ?? ""
//        case "Hindi":
//            self.languageText = textResponse.hindi ?? ""
//        case "Tamil":
//            self.languageText = textResponse.tamil ?? ""
//        case "Bengali":
//            self.languageText = textResponse.bengali ?? ""
//        case "Telugu":
//            self.languageText = textResponse.telugu ?? ""
//        case "Marathi":
//            self.languageText = textResponse.marathi ?? ""
//        case "Gujarathi":
//            self.languageText = textResponse.gujarathi ?? ""
//        case "Kannada":
//            self.languageText = textResponse.kannada ?? ""
//        case "Malayalam":
//            self.languageText = textResponse.malayalam ?? ""
        default:
            break
        }
    }
    func similarTextSelection(_ textLanguage: String,_ textResponse: SimilarVideoData){
        switch textLanguage {
        case "English":
            self.languageText = textResponse.summary ?? ""
        case "Hindi":
            self.languageText = textResponse.summaryHi ?? ""
        case "Tamil":
            self.languageText = textResponse.summaryTa ?? ""
        case "Bengali":
            self.languageText = textResponse.summaryBn ?? ""
        case "Telugu":
            self.languageText = textResponse.summaryTe ?? ""
        case "Marathi":
            self.languageText = textResponse.summaryMr ?? ""
        case "Gujarathi":
            self.languageText = textResponse.summaryGu ?? ""
        case "Kannada":
            self.languageText = textResponse.summaryKn ?? ""
        case "Malayalam":
            self.languageText = textResponse.summaryMl ?? ""
        default:
            break
        }
    }
}
