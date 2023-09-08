//
//  SimilarCategoryViewController.swift
//  StarMaker
//
//  Created by Raghu on 27/07/23.
//

import UIKit
import youtube_ios_player_helper
import GSPlayer
import AVFAudio

class SimilarCategoryViewController: BaseVC{

   
    @IBOutlet weak var imageHeaderLogo: UIImageView!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var lblDropDown: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var viewAudioPanel: UIView!
    @IBOutlet weak var viewTextPanel: UIView!
    @IBOutlet weak var viewYT: UIView!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    @IBOutlet weak var playerView: VideoPlayerView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var textContentCollectionView: UICollectionView!
    @IBOutlet weak var btnAudioBack: UIButton!
    @IBOutlet weak var lblAudioRunTIme: UILabel!
    @IBOutlet weak var audioPanelCollectionView: UICollectionView!
    
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var thumbImageCollectionview: UICollectionView!
    @IBOutlet weak var labelAudioDuration: UILabel!
    var viewModel = SimilarCategoryViewModel()
    var similarVideoRequestModel = SimilarVideoRequestModel()
    var videoId = ""
    var currentContentIndex = 0
    var currentTextIndex = 0
    var currentYtIndex = 0
    var currentAudioIndex = 0
    var panelControl = 0
    var langSelect = false
    var texvalue = ""
    var audioSelection = false
    var audioLanguage = "English"
    var audioVoice = "Male"
    var audioPlayer: AVAudioPlayer?
    var audioIndex = 0
    var textSelection = false
    var videoSelection = false
    var audioInSection = false
    var currentSimilarPageNo = 1
    var apiIsLoading = false
    var loadingStatus = false
    var audioPanelStatus = false
    var dropDownSelected = false
    var audioBool = false
    var instaSelection = false
    var bookMarkFlow = false
    var audiosLanguage = ["Male","Female","English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var textaudioLanguage = ["English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnAudioBack.isHidden = false
        self.btnAudioBack.setImage(UIImage(named: "backWhite"), for: .normal)
        self.imageHeaderLogo.image = UIImage(named: "Logos")
        self.menuBtnColor(.white)
        self.viewHeader.backgroundColor = .black
        self.viewDropDown.isHidden = true
        self.btnDropDown.isHidden = true
        self.lblDropDown.isHidden = true
        getSimilarDataAPICall(self.videoId, pageNo: self.currentSimilarPageNo)
        self.btnVideo.isHidden = true
        self.viewTextPanel.isHidden = true
        self.viewAudioPanel.isHidden = true
        self.thumbImageCollectionview.isHidden = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .up
        self.viewYT.addGestureRecognizer(swipeRight)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.viewYT.addGestureRecognizer(swipeDown)
        
        self.viewModel.registerCollectionviewNib(collectionview: self.thumbImageCollectionview) {
            self.thumbImageCollectionview.delegate = self
            self.thumbImageCollectionview.dataSource = self
            self.thumbImageCollectionview.reloadData()
        }
        self.viewModel.registerCollectionviewNib(collectionview: self.audioPanelCollectionView) {
            self.audioPanelCollectionView.delegate = self
            self.audioPanelCollectionView.dataSource = self
            self.audioPanelCollectionView.reloadData()
        }
        
        self.viewModel.registerCollectionviewNib(collectionview: self.textContentCollectionView) {
            self.textContentCollectionView.delegate = self
            self.textContentCollectionView.dataSource = self
            self.textContentCollectionView.reloadData()
        }
        self.viewModel.registerTableviewNib(tableview: dropDownTableView) {
            self.dropDownTableView.delegate = self
            self.dropDownTableView.dataSource = self
            self.dropDownTableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.instaSelection = false
        self.viewYT.isHidden = false
        self.thumbImageCollectionview.isHidden = false
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                
                print("Swiped right")
            case .down:
                playPreviousVideo()
                print("Swiped down")
            case .left:
                print("Swiped left")
            case .up:
                playNextVideo()
                print("Swiped up")
            default:
                break
            }
        }
    }
    func menuBtnColor(_ color: UIColor){
        self.btnText.tintColor = color
        self.btnVideo.tintColor = color
        self.btnAudio.tintColor = color
        self.btnBookmark.tintColor = color
    }
    @IBAction func bookMarkBtnAction(_ sender: UIButton) {
        if bookMarkFlow{
            self.btnBookmark.setImage(UIImage(named: "BookmarkIcon"), for: .normal)
            self.bookMarkFlow = false
        }else{
            self.bookMarkFlow = true
            self.btnBookmark.setImage(UIImage(named: "BookMarkSelect"), for: .normal)
        }
    }
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
        if dropDownSelected{
            self.viewDropDown.isHidden = true
            self.dropDownSelected = false
        }else{
            self.viewDropDown.isHidden = false
            self.dropDownSelected = true
        }
    }
    
    
    @IBAction func moreButtonAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "MoreDescriptionPresentViewController") as? MoreDescriptionPresentViewController else { return  }

        vc.similarStatus = true
        self.thumbImageCollectionview.isHidden = false
        self.ytPlayer.pauseVideo()
//        vc.instaSelection = self.playerSwitch
        vc.getSimilarVideoData = self.viewModel.getSimilarVideoData?.data?[self.currentContentIndex] ?? SimilarVideoData()
        
        vc.controlPanel = self.panelControl
        vc.closureTextContent = {[unowned self] textContent in
            self.texvalue = textContent
            self.langSelect = true
            self.textContentCollectionView.reloadData()

        }
        vc.closureAudioML = {[unowned self] maleContent in
            self.audioLanguage = vc.audioLanguages
//            self.audioVoiceSelect = true
            self.audioVoice = vc.audioVoice
            self.loadFirstAudio()
            self.audioPanelCollectionView.reloadData()
        }
        vc.closureAudioLan = {[unowned self] maleContent in
            self.audioLanguage = vc.audioLanguages
//            self.audioVoiceSelect = true
            self.audioVoice = vc.audioVoice
//            self.currentVideoIndex = self.currentYtIndex
            self.loadFirstAudio()
            self.audioPanelCollectionView.reloadData()
        }
        vc.closureTextAction = {
//            self.currentContentIndex = self.currentContentIndex
            self.textSelection = true
            self.audioPlayer?.stop()
            self.ytPlayer.pauseVideo()
            self.viewTextPanel.isHidden = false
            self.viewAudioPanel.isHidden = true
            self.panelControl = 2
            if self.audioSelection{
                self.currentContentIndex = self.audioIndex
            }else if self.videoSelection{
                self.currentContentIndex = self.currentContentIndex
            }else{
                self.currentContentIndex = self.currentContentIndex
            }
            self.scrollToIndex(self.currentContentIndex, self.textContentCollectionView)
            self.textContentCollectionView.reloadData()
        }
        vc.closureVideoAction = {
            self.videoSelection = true
            self.ytPlayer.playVideo()
            self.audioPlayer?.stop()
            if self.audioSelection{
                self.currentContentIndex = self.audioIndex
            }else if self.textSelection{
                self.currentContentIndex = self.currentTextIndex
            }else{
                self.currentContentIndex = self.currentContentIndex
            }

            self.loadFirstVideo()
            self.panelControl = 0
            self.viewTextPanel.isHidden = true
            self.viewAudioPanel.isHidden = true
//            self.scrollToIndex(self.currentContentIndex, self.videoPlayingCollectionView)
        }
        vc.closureAudioAction = {
            self.audioSelection = true
            self.ytPlayer.pauseVideo()
            self.audioLanguage = vc.audioLanguages
            self.audioVoice = vc.audioVoice
            self.panelControl = 1
            if self.textSelection{
                self.currentContentIndex = self.currentTextIndex
            }else if self.videoSelection{
                self.currentContentIndex = self.currentContentIndex
            }else{
                self.currentContentIndex = self.currentContentIndex
            }
//            self.currentContentIndex = self.currentContentIndex
            self.loadFirstAudio()
            self.scrollToIndex(self.currentContentIndex, self.audioPanelCollectionView)
            self.viewAudioPanel.isHidden = false
            self.audioPanelCollectionView.reloadData()
        }
//        vc.closureInstaAction = {
//
//            vc.lblYT.textColor = .white
//            vc.lblInsta.textColor = .red
//            self.playerSwitch = true
//            self.ytPlayer.isHidden = true
//            self.playerView.isHidden = false
//            self.playerView.pause()
//
//        }
//        vc.closureYTAction = {
//
//            vc.lblYT.textColor = .red
//            vc.lblInsta.textColor = .white
//            self.playerSwitch = false
//            self.playerView.isHidden = true
//            self.ytPlayer.isHidden = false
//            self.playerView.pause(reason: .hidden)
//
//
//            self.ytPlayer.pauseVideo()
//        }
//        vc.closureDismiss = {
//            if self.playerSwitch{
//                self.loadFirstInstaView()
//            }else{
//                self.playerView.pause(reason: .hidden)
//                self.loadsFirstVideo()
//            }
//            self.ytPlayer.playVideo()
//        }
        vc.audioLanguages = self.audioLanguage
        vc.audioVoice = self.audioVoice
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
     
    @IBAction func textBtnAction(_ sender: UIButton) {
        self.btnAudioBack.setImage(UIImage(named: "Back 1"), for: .normal)
        self.imageHeaderLogo.image = UIImage(named: "Logo1")
        self.btnAudioBack.isHidden = false
        self.btnBack.isHidden = true
        view.backgroundColor = .white
        self.menuBtnColor(Constants.Color.menuColor ?? UIColor.white)
        self.viewHeader.backgroundColor = .white
        self.lblDropDown.text = self.audioLanguage
        self.viewDropDown.backgroundColor = .white
        self.lblDropDown.isHidden = false
        self.btnDropDown.isHidden = false
        self.audioPanelStatus = false
        self.btnText.isHidden = true
        self.btnAudio.isHidden = false
        self.btnVideo.isHidden = false
        self.textSelection = true
        self.audioPlayer?.stop()
        self.ytPlayer.pauseVideo()
        self.viewTextPanel.isHidden = false
        self.viewAudioPanel.isHidden = true
        self.panelControl = 2
        if self.audioSelection{
            self.currentTextIndex = self.audioIndex
        }else if self.videoSelection{
            self.currentTextIndex = self.currentContentIndex
        }
        self.audioSelection = false
        self.videoSelection = false
        self.textSelection = true
        self.scrollToIndex(self.currentTextIndex, self.textContentCollectionView)
        self.dropDownTableView.reloadData()
        self.textContentCollectionView.reloadData()
    }
    
    @IBAction func audioBtnAction(_ sender: UIButton) {
        self.btnAudioBack.setImage(UIImage(named: "Back 1"), for: .normal)
        self.imageHeaderLogo.image = UIImage(named: "Logo1")
        self.btnAudioBack.isHidden = false
        self.btnBack.isHidden = true
        view.backgroundColor = .white
        self.menuBtnColor(Constants.Color.menuColor ?? UIColor.white)
        self.viewHeader.backgroundColor = .white
        self.lblDropDown.text = "Male - \(self.audioLanguage)"
        self.viewDropDown.backgroundColor = .white
        self.lblDropDown.isHidden = false
        self.btnDropDown.isHidden = false
        self.audioPanelStatus = true
        self.btnText.isHidden = false
        self.btnAudio.isHidden = true
        self.btnVideo.isHidden = false
        self.audioSelection = true
        self.ytPlayer.pauseVideo()
        self.panelControl = 1
        if self.textSelection{
            self.currentContentIndex = self.currentTextIndex
        }

        self.loadFirstAudio()
        self.audioSelection = true
        self.videoSelection = false
        self.textSelection = false
        self.scrollToIndex(self.currentContentIndex, self.audioPanelCollectionView)
        self.viewAudioPanel.isHidden = false
        self.dropDownTableView.reloadData()
        self.audioPanelCollectionView.reloadData()
    }
    
    @IBAction func videoBtnAction(_ sender: UIButton) {
        self.btnAudioBack.setImage(UIImage(named: "backWhite"), for: .normal)
        self.imageHeaderLogo.image = UIImage(named: "Logos")
        self.btnAudioBack.isHidden = false
        self.btnBack.isHidden = true
        view.backgroundColor = .black
        self.menuBtnColor(.white)
        self.viewHeader.backgroundColor = .clear
        self.viewDropDown.backgroundColor = .white
        self.lblDropDown.isHidden = true
        self.btnDropDown.isHidden = true
        self.btnText.isHidden = false
        self.btnAudio.isHidden = false
        self.btnVideo.isHidden = true
        self.videoSelection = true
        self.ytPlayer.playVideo()
        self.audioPlayer?.stop()
        if self.audioSelection{
            self.currentContentIndex = self.audioIndex
        }else if self.textSelection{
            self.currentContentIndex = self.currentTextIndex
        }

        self.loadFirstVideo()
        self.panelControl = 0
        self.viewTextPanel.isHidden = true
        self.viewAudioPanel.isHidden = true
        self.audioSelection = false
        self.videoSelection = true
        self.textSelection = false
            self.scrollToIndex(self.currentContentIndex, self.thumbImageCollectionview)
        self.thumbImageCollectionview.reloadData()
    }
    @IBAction func audioFwdBtnAction(_ sender: UIButton) {
        self.playNextAudio()
    }
    @IBAction func audioBackBtnAction(_ sender: UIButton) {
        self.playPreviousAudio()
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.audioPlayer?.stop()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func instaBtnAction(_ sender: UIButton) {
        self.thumbImageCollectionview.isHidden = false
        self.viewYT.isHidden = true
        self.instaSelection = true
        self.btnInstagram.isHidden = true
        self.ytPlayer.stopVideo()
        self.thumbImageCollectionview.reloadData()
    }
}
//MARK: - UITABLEVIEW DELEGATE & DATASOURCE
extension SimilarCategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if audioPanelStatus{
            return audiosLanguage.count
        }else{
            return textaudioLanguage.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AudioDropDownTableViewCell", for: indexPath) as? AudioDropDownTableViewCell else { return UITableViewCell() }
        cell.viewBorder.isHidden = true
        if audioPanelStatus{
            if indexPath.row == 0{
                if audioVoice == "Male"{
                        cell.lblDropDown.textColor = .red
                }else{
                    cell.lblDropDown.textColor = .black
                }
            }else if indexPath.row == 1{
                if audioVoice == "Female"{
                    cell.lblDropDown.textColor = .red
                }else{
                    cell.lblDropDown.textColor = .black
                }
            }else if indexPath.row == self.audioIndex{
                cell.lblDropDown.textColor = .red
            }else{
                cell.lblDropDown.textColor = .black
            }
           

            if indexPath.row == 1{
                cell.viewBorder.isHidden = false
            }
            cell.cellConfig(audiosLanguage[indexPath.row])
        }else{

            if self.textaudioLanguage[indexPath.row] == self.audioLanguage{
                cell.lblDropDown.textColor = .red
            }else{
                cell.lblDropDown.textColor = .black
            }
            cell.cellConfig(textaudioLanguage[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AudioDropDownTableViewCell {
            if audioPanelStatus{
                if indexPath.row == 0{
                    audioBool = false
                    self.audioVoice = "Male"
                    self.lblDropDown.text = "Male - \(self.audioLanguage)"
                }else if indexPath.row == 1{
                    audioBool = true
                    self.audioVoice = "Female"
                    self.lblDropDown.text = "Female - \(self.audioLanguage)"
                }else{
                    self.audioIndex = indexPath.row
    //                    cell.lblDropDown.textColor = .red
                    self.audioLanguage = cell.lblDropDown.text ?? ""
                }
                self.lblDropDown.text = "\(self.audioVoice) - \(self.audioLanguage)"
                self.loadFirstAudio()
    //            self.loadAudio(self.audioVoiceLanguage, audioBool)
                self.viewDropDown.isHidden = true
                self.dropDownTableView.reloadData()
               
                }else{
                    self.audioLanguage = self.textaudioLanguage[indexPath.row]
                    self.lblDropDown.text = self.audioLanguage
                    self.texvalue = self.audioLanguage
                    self.langSelect = true
                    self.textContentCollectionView.reloadData()
                    self.dropDownTableView.reloadData()
                    self.viewDropDown.isHidden = true
                    self.dropDownSelected = false
                    
                }
        }
    }
    
    
}
extension SimilarCategoryViewController{
    func getSimilarDataAPICall(_ videoID: String?,pageNo: Int){
        self.similarVideoRequestModel.videoId = videoID
        self.similarVideoRequestModel.currentPage = pageNo
        if self.loadingStatus{
            self.stopSpinnerLoading()
        }else{
            self.startSpinnerLoading()
        }
        
        self.viewModel.getSimilarVideoListAPI(page: pageNo, params: self.similarVideoRequestModel) { status, data, message in
            if status == .Success{
                if data?.data?.data?.count == 0{
                    self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(8), execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }
                self.ytPlayer.delegate = self
                self.loadFirstVideo()
                self.textContentCollectionView.reloadData()
                self.audioPanelCollectionView.reloadData()
                self.thumbImageCollectionview.reloadData()
                print("similar video data response ======> \(data)")
                self.apiIsLoading = true
            }
            if self.loadingStatus{
                self.stopSpinnerLoading()
            }else{
                self.stopSpinnerLoading()
            }
        }
        
    }
}
extension SimilarCategoryViewController: YTPlayerViewDelegate{
    func loadFirstVideo() {
        
        
        guard currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            // Handle end of video array
            return
        }
        let videoId = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].videoID ?? ""
        
        DispatchQueue.main.async {
            self.ytPlayer.load(withVideoId: videoId,playerVars: ["start": 0.3,"controls": 0,"iv_load_policy": 3])
            self.thumbImageCollectionview.isHidden = false
        }
        
    }
    func loadFirstAudio() {
        
        guard currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            //         Handle end of video array
            return
        }
        self.loadAudio()
        
    }
    func playNextAudio(){
        currentContentIndex += 1
        guard currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            // Handle end of video array
            return
        }
        self.loadAudio()
    }
    func playPreviousAudio(){
        currentContentIndex -= 1
        guard currentContentIndex >= 0 && currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            // Handle beginning of video array
            return
        }
        self.loadAudio()
    }
    func loadAudio(){
        var aud = ""
        switch self.audioLanguage {
            
        case "English":
            if self.audioVoice == "Male" {
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioEnMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioEnFmale ?? ""
            }
        case "Hindi":
            if self.audioVoice == "Male" {
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioHiMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioHiFemale ?? ""
            }
        case "Tamil":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioTaMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioTaFemale ?? ""
            }
        case "Bengali":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioBnMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioBnFemale ?? ""
            }
        case "Telugu":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioTeMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioTeFemale ?? ""
            }
        case "Marathi":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioMrMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioMrFemale ?? ""
            }
        case "Gujarathi":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioGuMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioGuFemale ?? ""
            }
        case "Kannada":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioKnMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioKnFemale ?? ""
            }
        case "Malayalam":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioMlMale ?? ""
            }else{
                aud = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].audioMlFemale ?? ""
            }
        default:
            break
        }
        DispatchQueue.main.async {
            do {
                
                let url = NSURL(string: aud)!
                let data = try Data(contentsOf: url as URL)
                self.audioPlayer = try AVAudioPlayer(data: data)
                guard let player = self.audioPlayer else { return }
                
                player.prepareToPlay()
                self.addAudioPlayerTimeObserver(for: self.audioPlayer, progressView: self.progressSlider)
                player.play()
                
            } catch let error as NSError {
                print(error.description)
            }
            
        }
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
        self.ytPlayer.playVideo()
        self.thumbImageCollectionview.isHidden = false
    }
    
    func playNextVideo() {
        
        currentContentIndex += 1
        scrollToIndex(currentContentIndex, self.thumbImageCollectionview)
        guard currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            // Handle end of video array
            return
        }
        if ((self.viewModel.getSimilarVideoData?.data?.count ?? 0) - self.currentContentIndex == 5) && currentSimilarPageNo != self.viewModel.TotalSimilarPageNo && self.apiIsLoading == true{
            self.loadingStatus = true
            currentSimilarPageNo += 1
            getSimilarDataAPICall(self.videoId, pageNo: self.currentSimilarPageNo)
            let videoId = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].videoID ?? ""
            DispatchQueue.main.async {
                self.thumbImageCollectionview.isHidden = false
                self.ytPlayer.load(withVideoId: videoId, playerVars: ["start": 0.3,"controls": 0,"iv_load_policy": 3])
            }
        }else{
            let videoId = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].videoID ?? ""
            DispatchQueue.main.async {
                self.thumbImageCollectionview.isHidden = false
                self.ytPlayer.load(withVideoId: videoId, playerVars: ["start": 0.3,"controls": 0,"iv_load_policy": 3])
            }
        }

        
    }
    func playPreviousVideo() {
       
        currentContentIndex -= 1
        scrollToIndex(currentContentIndex, self.thumbImageCollectionview)
        guard currentContentIndex >= 0 && currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            // Handle beginning of video array
            return
        }
        let videoId = self.viewModel.getSimilarVideoData?.data?[currentContentIndex].videoID ?? ""
        DispatchQueue.main.async {
            self.ytPlayer.load(withVideoId: videoId,playerVars: ["start": 0.3,"controls": 0,"iv_load_policy": 3])
            self.thumbImageCollectionview.isHidden = false
        }
        
    }
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .buffering{
            self.ytPlayer.isHidden = true
            self.thumbImageCollectionview.isHidden = false
        }else if state == .playing{
            self.thumbImageCollectionview.isHidden = true
            self.ytPlayer.isHidden = false
        }else if state == .ended{
            self.ytPlayer.playVideo()
        }
    }
    func scrollToIndex(_ index: Int,_ collectionVIew: UICollectionView) {
        // Ensure that the index is within the valid range of items in the collection view
        guard index >= 0, index < self.viewModel.getSimilarVideoData?.data?.count ?? 0 else {
            return
        }
        
        // Create an index path with the desired index
        let indexPath = IndexPath(item: index, section: 0)
        
        // Scroll the collection view to the desired index with animation
        collectionVIew.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    func addAudioPlayerTimeObserver(for player: AVAudioPlayer?, progressView: UISlider) {
        if currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0{

            let interval = 0.1
            audioPlayer?.addObserver(self, forKeyPath: "currentTime", options: .new, context: nil)

            Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
                guard let strongSelf = self else { return }

                let currentTime = Float(self?.audioPlayer?.currentTime ?? 0.0)
                let duration = Float(self?.audioPlayer?.duration ?? 0.0)
                let endtime = duration / 10000
                self?.labelAudioDuration.text = "0.\(Int(duration))"
                if duration > 0 {
                    let progress = currentTime / duration
                    progressView.value = progress
                    self?.lblAudioRunTIme.text = "0.\(Int(currentTime))"
                } else {
                    progressView.value = 0
                }

                if currentTime >= duration {
                    // Audio has finished playing
                    self?.audioPlayer?.stop()
                    timer.invalidate()
                }
            }
        }

    }

//     Observe the AVAudioPlayer's "currentTime" to update the progress bar
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if currentContentIndex < self.viewModel.getSimilarVideoData?.data?.count ?? 0{
            if keyPath == "currentTime" {

                let currentTime = Float(audioPlayer?.currentTime ?? 0.0)
                let duration = Float(audioPlayer?.duration ?? 0.0)

                    if duration > 0 {
                        let progress = currentTime / duration
                        
                        self.progressSlider.value = progress
                        
                    } else {
                        self.progressSlider.value = 0
                    }

            }
        }

    }
}
extension SimilarCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getSimilarVideoData?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case thumbImageCollectionview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbNailCollectionViewCell", for: indexPath) as? ThumbNailCollectionViewCell else{return UICollectionViewCell()}
            if instaSelection{
                cell.btnPlayInsta.isHidden = false
                cell.cellConfig(self.viewModel.getSimilarVideoData?.data?[indexPath.item].videoID ?? "")
                cell.closureInstaPlay = {
                    guard let vc = Constants.StoryBoards.main.instantiateViewController(withIdentifier: Constants.ViewController.instaVC) as? InstagramPanelViewController else{return}
                    vc.headerText = "Similar"
                    vc.instaImage = "https://www.instagram.com/reel/CwHwyq-KhIU/?igshid=MzRlODBiNWFlZA=="
                    self.navigationController?.pushViewController(vc, animated: true)
                }
             
                
            }else{
                cell.btnPlayInsta.isHidden = true
                cell.cellConfig(self.viewModel.getSimilarVideoData?.data?[indexPath.item].videoID ?? "")
            }
            
        return cell
        case textContentCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextContentCollectionViewCell", for: indexPath) as? TextContentCollectionViewCell else{return UICollectionViewCell()}
            
            cell.cellSimilarConfig(self.viewModel.getSimilarVideoData?.data?[indexPath.item] ?? SimilarVideoData(), self.langSelect, self.texvalue)
            return cell
        case audioPanelCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioPanelCollectionViewCell", for: indexPath) as? AudioPanelCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.closurePause = {
                if cell.isPlaying{
                    self.audioPlayer?.play()
                    cell.isPlaying = false
                    cell.btnPausePlay.setImage(Constants.Images.pauseButton, for: .normal)
                }else{
                    self.audioPlayer?.pause()
                    cell.isPlaying = true
                    cell.btnPausePlay.setImage(Constants.Images.playButton, for: .normal)
                
                }
            }
            if panelControl == 1{
                cell.labelAudioTitle.text = self.viewModel.getSimilarVideoData?.data?[indexPath.item].videoTitle

            }
           
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.audioIndex = indexPath.item
        if collectionView == textContentCollectionView{
            self.currentTextIndex = indexPath.item
        }
//        if collectionView == audioPanelCollectionView{
//            self.currentContentIndex = indexPath.item
//        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == thumbImageCollectionview{
            return collectionView.bounds.size
        }else if collectionView == textContentCollectionView{
            return collectionView.bounds.size
        }else if collectionView == audioPanelCollectionView{
            return collectionView.bounds.size
        }
        return CGSize(width: 100, height: 100)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{check()}
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.check()
    }
    func check() {
        DispatchQueue.main.async {
            if self.panelControl == 1{
                if self.currentContentIndex < self.audioIndex{
                    self.playNextAudio()
                }else if self.currentContentIndex > self.audioIndex{
                    self.playPreviousAudio()
                }
                
            }
           
//            self.checkPreload()
//            self.checkPlay()
        }
       
    }
}
