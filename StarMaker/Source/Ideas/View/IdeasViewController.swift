//
//  IdeasViewController.swift
//  StarMaker
//
//  Created by Raghu on 05/08/23.
//

import UIKit
import DropDown
import AVFAudio

class IdeasViewController: UIViewController {

    @IBOutlet weak var heightDropDownConstraint: NSLayoutConstraint!
    @IBOutlet weak var audioSelectTableview: UITableView!
    @IBOutlet weak var viewAudioDD: UIView!
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var imageAudioPanel: UIImageView!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var ideasTableview: UITableView!
    var audioIndex = Int()
    var viewModel = IdeasViewModel()
    var dropDown = DropDown()
    var textaudioLanguage = ["English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var audioLanguage = ["Male","Female","English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var textContent = ""
    var audioUrl = ""
    var audioPlayer: AVAudioPlayer?
    var audioPanelStatus = false
    var getListData: GetVideoData?
    var audioVoiceLanguage = "English"
    var audioVoice = "Male"
    var audioBool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightDropDownConstraint.constant = 230
        self.viewAudioDD.isHidden = true
        self.imageAudioPanel.isHidden = true
        self.viewModel.registerTableviewNib(tableview: ideasTableview) {
            self.ideasTableview.delegate = self
            self.ideasTableview.dataSource = self
            self.ideasTableview.reloadData()
        }
        self.viewModel.registerTableviewNib(tableview: self.audioSelectTableview) {
            self.audioSelectTableview.delegate = self
            self.audioSelectTableview.dataSource = self
            self.audioSelectTableview.reloadData()
        }
    }
    
    @IBAction func textPanelBtnAction(_ sender: UIButton) {
        self.heightDropDownConstraint.constant = 230
        self.audioPanelStatus = false
        self.btnText.setImage(Constants.Images.textSelect, for: .normal)
        self.btnAudio.setImage(Constants.Images.audioUnselect, for: .normal)
        self.ideasTableview.isHidden = false
        self.imageAudioPanel.isHidden = true
        self.audioPlayer?.pause()
        self.audioSelectTableview.reloadData()
    }
    @IBAction func audioBtnAction(_ sender: UIButton) {
        self.heightDropDownConstraint.constant = 280
        self.audioPanelStatus = true
        self.lblLanguage.text = "\(self.audioVoice) - \(self.audioVoiceLanguage)"
        self.btnText.setImage(Constants.Images.textUnselect, for: .normal)
        self.btnAudio.setImage(Constants.Images.audioSelect, for: .normal)
        self.ideasTableview.isHidden = false
        self.imageAudioPanel.isHidden = true
        self.loadAudio(self.audioVoiceLanguage, false)
        self.audioSelectTableview.reloadData()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
                if sender.isSelected {
                    // set selected
                    self.viewAudioDD.isHidden = true
                    sender.isSelected = false
                } else {
                    self.viewAudioDD.isHidden = false
                    // set deselected
                    sender.isSelected = true
                }
    }
}
extension IdeasViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case ideasTableview:
            return 1
        case audioSelectTableview:
            if audioPanelStatus{
                return audioLanguage.count
            }else{
                return textaudioLanguage.count
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case ideasTableview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTextTableViewCell", for: indexPath) as? ContentTextTableViewCell else { return UITableViewCell() }
            cell.configureCell(with: self.getListData?.videoIdea1_En ?? "")
            return cell
        case audioSelectTableview:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioDropDownTableViewCell", for: indexPath) as? AudioDropDownTableViewCell else { return UITableViewCell() }
            cell.viewBorder.isHidden = true
            if audioPanelStatus{
                if indexPath.row == 0{
                    if audioVoice == "Male"{
                            cell.lblDropDown.textColor = .red
                    }else{
                        cell.lblDropDown.textColor = .white
                    }
                }else if indexPath.row == 1{
                    if audioVoice == "Female"{
                        cell.lblDropDown.textColor = .red
                    }else{
                        cell.lblDropDown.textColor = .white
                    }
                }else if indexPath.row == self.audioIndex{
                    cell.lblDropDown.textColor = .red
                }else{
                    cell.lblDropDown.textColor = .white
                }
               

                if indexPath.row == 1{
                    cell.viewBorder.isHidden = false
                }
                cell.cellConfig(audioLanguage[indexPath.row])
            }else{

                cell.cellConfig(textaudioLanguage[indexPath.row])
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case audioSelectTableview:
            if let cell = tableView.cellForRow(at: indexPath) as? AudioDropDownTableViewCell {
                if indexPath.row == 0{
                    audioBool = false
                    self.audioVoice = "Male"
                    self.lblLanguage.text = "Male - \(self.audioVoiceLanguage)"
                }else if indexPath.row == 1{
                    audioBool = true
                    self.audioVoice = "Female"
                    self.lblLanguage.text = "Female - \(self.audioVoiceLanguage)"
                }else{
                    self.audioIndex = indexPath.row
//                    cell.lblDropDown.textColor = .red
                    self.audioVoiceLanguage = cell.lblDropDown.text ?? ""
                }
                self.lblLanguage.text = "\(self.audioVoice) - \(self.audioVoiceLanguage)"
                self.loadAudio(self.audioVoiceLanguage, audioBool)
                self.viewAudioDD.isHidden = true
                self.audioSelectTableview.reloadData()
               
                }
            
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case ideasTableview:
            return UITableView.automaticDimension
        case audioSelectTableview:
            return 25
        default:
            return UITableView.automaticDimension
        }
    }
    
    
}
extension IdeasViewController: AVAudioPlayerDelegate{
//    func dropDownConfig(data: [String],viewDropDown: UIView,buttonDropDown: UIButton,lblDropDown: UILabel,controlPanel: Int){
//        dropDown.backgroundColor = Constants.Color.dropDownBG
//        dropDown.textColor = .white
//        dropDown.dataSource = data
//            dropDown.anchorView =  viewDropDown//5
//        dropDown.direction = .any
//            dropDown.bottomOffset = CGPoint(x: 80, y: buttonDropDown.frame.size.height) //6
//            dropDown.show() //7
//            dropDown.selectionAction = { [weak self] (index: Int, item: String) in //8
//              guard let _ = self else { return }
//                lblDropDown.text = item
//            }
//    }
//
    func loadAudio(_ languageSelect: String,_ selectAudio: Bool){
        var aud = ""
        
        switch languageSelect {
        case "English":
            if selectAudio == false {
                aud = self.getListData?.videoIdea1_EnAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_EnAudioFemale ?? ""
            }
        case "Hindi":
            if selectAudio == false {
                aud = self.getListData?.videoIdea1_HiAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_HiAudioFemale ?? ""
            }
        case "Tamil":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_TaAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_TaAudioFemale ?? ""
            }
        case "Bengali":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_BnAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_BnAudioFemale ?? ""
            }
        case "Telugu":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_TeAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_TeAudioFemale ?? ""
            }
        case "Marathi":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_MrAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_MrAudioFemale ?? ""
            }
        case "Gujarathi":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_GuAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_GuAudioFemale ?? ""
            }
        case "Kannada":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_KnAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_KnAudioFemale ?? ""
            }
        case "Malayalam":
            if selectAudio == false{
                aud = self.getListData?.videoIdea1_MlAudioMale ?? ""
            }else{
                aud = self.getListData?.videoIdea1_MlAudioFemale ?? ""
            }
        default:
             break
        }
        DispatchQueue.main.async {
            do {
//                let aud = self.audioUrl
                let url = NSURL(string: aud)!
                let data = try Data(contentsOf: url as URL)
                self.audioPlayer = try AVAudioPlayer(data: data)
                guard let player = self.audioPlayer else { return }
                player.prepareToPlay()
                player.play()
                
            } catch let error as NSError {
                print(error.description)
            }
            
        }
    }
    
}
