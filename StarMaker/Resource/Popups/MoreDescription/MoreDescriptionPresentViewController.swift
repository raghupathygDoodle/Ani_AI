//
//  MoreDescriptionPresentViewController.swift
//  StarMaker
//
//  Created by Raghu on 18/07/23.
//

import UIKit
import DropDown


class MoreDescriptionPresentViewController: UIViewController {


    @IBOutlet weak var heightConstraintInsta: NSLayoutConstraint!
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var viewTextLanguage: UIView!
    @IBOutlet weak var viewVideoLanguage: UIView!
    @IBOutlet weak var viewAudioLanguage: UIView!
    let dropDown = DropDown()
    var videoLanguage = ["Male","Female"]
    var textaudioLanguage = ["English","hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var audioLanguage = ["English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var closureDismiss:(()->())?
    var closureTextAction:(()->())?
    var closureVideoAction:(()->())?
    var controlPanel = 0
    var getVideoData = GetVideoData()
    var getSimilarVideoData = SimilarVideoData()
    var textLanguage = TextLanguage()
    var languages = [TextLanguage]()
    var similarLang = [String]()
    var lang = [String]()
   
    var audioMLLang = [String]()
    var audioFMLLang = [String]()
    var closureTextContent:((_ content: String) ->())?
    var closureAudioML: ((_ contentML: String)->())?
    var closureAudioLan: ((_ audioLangs: String)->())?
    var closureInstaAction:(()->())?
    var closureYTAction:(()->())?
    var audioVoice = ""
    var similarStatus = false
    @IBOutlet weak var buttonVoiceLang: UIButton!
    
    @IBOutlet weak var buttonTextLang: UIButton!
    @IBOutlet weak var buttonAudioLang: UIButton!
    @IBOutlet weak var textsLabel: UILabel!
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var voiceLabel: UILabel!
    @IBOutlet weak var labelVideoLang: UILabel!
    @IBOutlet weak var labelTextLang: UILabel!
    @IBOutlet weak var labelAudioLang: UILabel!
    @IBOutlet weak var lblInsta: UILabel!
    @IBOutlet weak var lblYT: UILabel!
    
    var closureMLAudio:(()->())?
    var closureFMLAudio: (()->())?
    var textArray = [String]()
    var closureAudioAction:(()->())?
    var audioLanguages = ""
    var instaSelection = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightConstraintInsta.constant = 0
        if self.controlPanel == 0{
            self.videoButton.setImage(Constants.Images.videoSelect, for: .normal)
            self.audioButton.setImage(Constants.Images.audioUnselect, for: .normal)
            self.textButton.setImage(Constants.Images.textUnselect, for: .normal)
            self.buttonVoiceLang.isUserInteractionEnabled = false
            self.buttonTextLang.isUserInteractionEnabled = false
            self.buttonAudioLang.isUserInteractionEnabled = false
            self.textsLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
            self.voiceLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
            self.audioLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
            self.labelAudioLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
            self.labelVideoLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
            self.labelTextLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
           
        }else if self.controlPanel == 2{
            self.buttonTextLang.isUserInteractionEnabled = true
            self.buttonVoiceLang.isUserInteractionEnabled = false
            self.buttonAudioLang.isUserInteractionEnabled = false
            self.audioButton.setImage(Constants.Images.audioUnselect, for: .normal)
            self.videoButton.setImage(Constants.Images.videoUnselect, for: .normal)
            self.textButton.setImage(Constants.Images.textSelect, for: .normal)
            self.textsLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            self.voiceLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
            self.audioLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
            self.labelAudioLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
            self.labelVideoLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
            self.labelTextLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        }else if self.controlPanel == 1{
            self.buttonTextLang.isUserInteractionEnabled = false
            self.buttonAudioLang.isUserInteractionEnabled = true
            self.buttonVoiceLang.isUserInteractionEnabled =  true
            self.audioButton.setImage(Constants.Images.audioSelect, for: .normal)
            self.videoButton.setImage(Constants.Images.videoUnselect, for: .normal)
            self.textButton.setImage(Constants.Images.textUnselect, for: .normal)
            self.labelVideoLang.text = self.audioVoice
            self.labelAudioLang.text = self.audioLanguages
            self.textsLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
            self.voiceLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            self.audioLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
            self.labelAudioLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
            self.labelVideoLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
            self.labelTextLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
        }

        if similarStatus{
            self.lang.append(getSimilarVideoData.summary ?? "")
            self.lang.append(getSimilarVideoData.summaryHi ?? "")
            self.lang.append(getSimilarVideoData.summaryTa ?? "")
            self.lang.append(getSimilarVideoData.summaryBn ?? "")
            self.lang.append(getSimilarVideoData.summaryTe ?? "")
            self.lang.append(getSimilarVideoData.summaryMr ?? "")
            self.lang.append(getSimilarVideoData.summaryGu ?? "")
            self.lang.append(getSimilarVideoData.summaryKn ?? "")
            self.lang.append(getSimilarVideoData.summaryMl ?? "")
            
            self.audioMLLang.append(getSimilarVideoData.audioHiMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioHiMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioTaMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioBnMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioTeMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioMrMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioGuMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioKnMale ?? "")
            self.audioMLLang.append(getSimilarVideoData.audioMlMale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioHiMale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioHiMale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioTaFemale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioBnFemale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioTeFemale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioMrFemale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioGuFemale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioKnFemale ?? "")
            self.audioFMLLang.append(getSimilarVideoData.audioMlFemale ?? "")
           
        }else{
            self.audioMLLang.append(getVideoData.audHindiML ?? "")
            self.audioMLLang.append(getVideoData.audHindiML ?? "")
            self.audioMLLang.append(getVideoData.audTamML ?? "")
            self.audioMLLang.append(getVideoData.audBengaliML ?? "")
            self.audioMLLang.append(getVideoData.audTeluguML ?? "")
            self.audioMLLang.append(getVideoData.audMarathiML ?? "")
            self.audioMLLang.append(getVideoData.audGujarathiML ?? "")
            self.audioMLLang.append(getVideoData.audKannadaML ?? "")
            self.audioMLLang.append(getVideoData.audMalayalamML ?? "")
            self.audioFMLLang.append(getVideoData.audHindiFML ?? "")
            self.audioFMLLang.append(getVideoData.audHindiFML ?? "")
            self.audioFMLLang.append(getVideoData.audTamFML ?? "")
            self.audioFMLLang.append(getVideoData.audBengaliFML ?? "")
            self.audioFMLLang.append(getVideoData.audTeluguFML ?? "")
            self.audioFMLLang.append(getVideoData.audMarathiFML ?? "")
            self.audioFMLLang.append(getVideoData.audGujarathiFML ?? "")
            self.audioFMLLang.append(getVideoData.audKannadaFML ?? "")
            self.audioFMLLang.append(getVideoData.audMalayalamFML ?? "")
        
            self.lang.append(getVideoData.summary ?? "")
            self.lang.append(getVideoData.hindi ?? "")
            self.lang.append(getVideoData.tamil ?? "")
            self.lang.append(getVideoData.bengali ?? "")
            self.lang.append(getVideoData.telugu ?? "")
            self.lang.append(getVideoData.marathi ?? "")
            self.lang.append(getVideoData.gujarathi ?? "")
            self.lang.append(getVideoData.kannada ?? "")
            self.lang.append(getVideoData.malayalam ?? "")
        }
        
        
        
        
     
        
        
        
        if instaSelection{
            self.lblYT.textColor = .white
            self.lblInsta.textColor = .red
        }else{
            self.lblYT.textColor = .red
            self.lblInsta.textColor = .white
        }
        print("texts slangggggg========> \(self.lang)")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func audioButtonAction(_ sender: UIButton) {
        if let action = closureAudioAction{
            action()
        }
        self.buttonAudioLang.isUserInteractionEnabled = true
        self.buttonVoiceLang.isUserInteractionEnabled = true
        self.buttonTextLang.isUserInteractionEnabled = false
            self.audioButton.setImage(Constants.Images.audioSelect, for: .normal)
            self.videoButton.setImage(Constants.Images.videoUnselect, for: .normal)
            self.textButton.setImage(Constants.Images.textUnselect, for: .normal)
        self.textsLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        self.labelTextLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
        self.audioLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        self.labelAudioLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        self.voiceLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        self.labelVideoLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
               
    }
    @IBAction func textButtonAction(_ sender: UIButton) {
        if let action = closureTextAction{
            action()
        }
        self.buttonAudioLang.isUserInteractionEnabled = false
        self.buttonVoiceLang.isUserInteractionEnabled = false
        self.buttonTextLang.isUserInteractionEnabled = true
        self.videoButton.setImage(Constants.Images.videoUnselect, for: .normal)
        self.audioButton.setImage(Constants.Images.audioUnselect, for: .normal)
        self.textButton.setImage(Constants.Images.textSelect, for: .normal)
        self.voiceLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        self.audioLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        self.textsLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        self.labelAudioLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
        self.labelVideoLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
        self.labelTextLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        
    }
    
    @IBAction func videoButtonAction(_ sender: UIButton) {
        if let action = closureVideoAction{
            action()
        }
        self.buttonAudioLang.isUserInteractionEnabled = false
        self.buttonVoiceLang.isUserInteractionEnabled = false
        self.buttonTextLang.isUserInteractionEnabled = false
        self.videoButton.setImage(Constants.Images.videoSelect, for: .normal)
        self.audioButton.setImage(Constants.Images.audioUnselect, for: .normal)
        self.textButton.setImage(Constants.Images.textUnselect, for: .normal)
        self.textsLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        self.voiceLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        self.audioLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)
        self.labelAudioLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
        self.labelVideoLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
        self.labelTextLang.textColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.4)
    }
    
    
    
    @IBAction func ytButtonAction(_ sender: UIButton) {
        if let action = closureYTAction{
            action()
        }
    }
    
    @IBAction func instaButtonAction(_ sender: UIButton) {
        if let action = closureInstaAction{
            action()
        }
    }
    @IBAction func videoLangDropDown(_ sender: UIButton) {
        dropDownConfig(data: videoLanguage, viewDropDown: viewVideoLanguage, buttonDropDown: sender, lblDropDown: self.labelVideoLang, controlPanel: 0)
    }
    @IBAction func audioLangButtonAction(_ sender: UIButton) {
        dropDownConfig(data: textaudioLanguage, viewDropDown: viewAudioLanguage, buttonDropDown: sender, lblDropDown: self.labelAudioLang, controlPanel: 1)
    }
    
    @IBAction func textLangButtonAction(_ sender: UIButton) {
        dropDownConfig(data: audioLanguage, viewDropDown: self.viewTextLanguage, buttonDropDown: sender, lblDropDown: self.labelTextLang, controlPanel: 2)
    }
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        if let action = closureDismiss{
            action()
        }
        self.dismiss(animated: true)
    }
    
  

}
extension MoreDescriptionPresentViewController{
    func dropDownConfig(data: [String],viewDropDown: UIView,buttonDropDown: UIButton,lblDropDown: UILabel,controlPanel: Int){
        dropDown.dataSource = data
            dropDown.anchorView =  viewDropDown//5
        dropDown.direction = .any
            dropDown.bottomOffset = CGPoint(x: 80, y: buttonDropDown.frame.size.height) //6
            dropDown.show() //7
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
              guard let _ = self else { return }
                lblDropDown.text = item
                
                print("selected laguage ------> \(self?.lang[index])")
                if controlPanel == 2{
                    if let action = self?.closureTextContent{
                        action(self?.textaudioLanguage[index] ?? "")
                    }
                }
                if controlPanel == 0{
                    if item == "Male"{
                        self?.audioVoice = item
                        if let action = self?.closureAudioML{
                            action(self?.audioMLLang[index] ?? "")
                        }
                    }else if item == "Female"{
                        self?.audioVoice = item
                        if let action = self?.closureAudioML{
                            action(self?.audioFMLLang[index] ?? "")
                        }
                    }
                   
                 
                }
                if controlPanel == 1{
                    self?.audioLanguages = item
                    if self?.audioVoice == "Male" || self?.audioVoice == ""{
                        if let action = self?.closureAudioLan{
                            action(self?.audioMLLang[index] ?? "" )
                        }
                    }else if self?.audioVoice == "Female"{
                        if let action = self?.closureAudioLan{
                            action(self?.audioFMLLang[index] ?? "")
                        }
                    }
                }

            }
    }
}
