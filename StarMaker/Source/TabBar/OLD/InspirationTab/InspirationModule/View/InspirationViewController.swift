//
//  InspirationViewController.swift
//  StarMaker
//
//  Created by Raghu on 13/07/23.
//

import UIKit
import JJFloatingActionButton
import GSPlayer
import MarqueeLabel
import AVFAudio
import AVFoundation
import youtube_ios_player_helper
import SafariServices
import YoutubePlayer_in_WKWebView

class InspirationViewController: BaseVC, AVAudioPlayerDelegate {
    
    var valueee = [String]()
    
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var imageLogoHeader: UIImageView!
    @IBOutlet weak var imageDropDown: UIImageView!
    @IBOutlet weak var btnSimilar: UIButton!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var thumbImageCollectionview: UICollectionView!
  
    @IBOutlet weak var ytPlayer: WKYTPlayerView!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var dropDownTableView: UITableView!
    var playerSwitch = false
    var currentInstaIndex = 0
    @IBOutlet weak var progressSlider: UISlider!
    var searchCategory = false
//    @IBOutlet weak var ytPlayer: YTPlayerView!
    var currentYtIndex = 0
    @IBOutlet weak var viewTextPanel: UIView!
    var closurr: (()->())?
    var indexValue = 0
    var selectedInd: Int?
    var indexItem = 0
    var ur = [String]()
    var viURL = URL(string: "")
    var _selectedCells = [IndexPath]()
    var subCatIndex = 0
    var audioPlayer: AVAudioPlayer?
    var keywordArray = [String]()
    var emotionArray = [String]()
    var keywordStatus = false
    var primaryCategories = ""
    var keyworkSelection = false
    var textSelection = false
    var videoSelection = false
    var instaSelection = false
    var isSubCategory = false
    var stringg = ""
    var categoryType = -1
    var categories = [String]()
    var audiosLanguage = ["Male","Female","English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var textaudioLanguage = ["English","Hindi","Tamil","Bengali","Telugu","Marathi","Gujarathi","Kannada","Malayalam"]
    var audioPanelStatus = false
    var dropDownSelected = false
    var arraySubtop = [SubCategoryType]()

    @IBOutlet weak var viewAudioDropDown: UIView!
    @IBOutlet weak var btnAudioBack: UIButton!
    @IBOutlet weak var lblDropDown: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var btnVideo: UIButton!
    @IBOutlet weak var btnAudio: UIButton!
    @IBOutlet weak var btnText: UIButton!
    @IBOutlet weak var textContentCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryView: UIView!
    @IBOutlet weak var labelSubCategoryTitle: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var viewAudioPanel: UIView!
    @IBOutlet weak var audioPanelCollectionView: UICollectionView!
    
    @IBOutlet weak var subCategoryHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewYT: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblAudioRunTIme: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var lblAudioDuration: UILabel!
    var categoryViewModel = HomeTabViewModel()
    var searchRequestModel = GlobalSearchRequestModel()
    var searchText = ""
    var videoURLCategory = false
    var categoriesModel: Categories?
    var categoriesList: [CategoryList]?
    var subCategories = [Subcategory]()
    var subTopicCategory = [SubCategoryType]()
    var sutopicCategory = SubCategoryType()
    var subCategory = SubCategoryType()
    var totalCollection = [String]()
    var collectionString: String?
    var viewModel = InspirationViewModel()
    var getVideoRequestModel = GetVideoDataRequestModel()
    var videoRequestModel = TopicVideoRequestModel()
    var selectCategories = SelectedCategory()
    var selectedCategoriesArray = [SelectedCategory]()
    
    var mainTopic = [String]()
    var subTopic = [String]()
    var selectedIndex = Int()
   var panelControl = 0
    var textIndexContent = Int()
    var videoIndexContent = Int()
    var texvalue = ""
    var audioVoice = "Male"
    var audioLanguage = "English"
    var audioLanIndex = 2
    var textLanIndex = 0
    var langSelect = false
    var audioSelect = false
    var audioPause = false
    var audioVoiceSelect = false
    var closurepause:(()->())?
    var closureNext:(()-> Void)?
    var audioIndex = Int()
    var currentVideoIndex = 0
    var audioSelection = false
    var videoPageNo = 1
    var apiIsLoading = false
    var loadingStatus = false
    var isMuted = false
    var selectedString: String?
    var audioBool = false
    var bookMarkFlow = false
    
    private var numberOfItemsInRow = 2

    private var minimumSpacing = 5

    private var edgeInsetPadding = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let encoder = JSONEncoder()
//              encoder.outputFormatting = .prettyPrinted // For pretty-printed JSON
//
//              do {
//                  let jsonData = try encoder.encode(self.getVideoRequestModel)
//
//                  if let jsonString = String(data: jsonData, encoding: .utf8) {
//                      print(jsonString)
//                  }
//              } catch {
//                  print("Error encoding to JSON: \(error)")
//              }
//        print("categoriessss ===> \(self.subTopicCategory)")
        self.categories.insert(self.primaryCategories, at: 0)
        if categoryType == 1{
//            self.btnInstagram.isHidden = true
            print("print emotion Array ==>\(self.emotionArray)")
        }else if categoryType == 2{
//            self.btnInstagram.isHidden = true
        } else{
            self.btnInstagram.isHidden = false
            for i in self.getVideoRequestModel.mainTopic{
                if i.subCatTwo.isEmpty{
                    self.categories.append(i.subCatOne)
                    let file = self.categories.uniqued()
                    self.categories = file
                }else{
                    for j in i.subCatTwo{

                        if j.isSelect == true{
                            self.categories.append(i.subCatOne+" - "+j.subCategoryTwo)
                            let file = self.categories.uniqued()
                            self.categories = file
                        }


                    }
                }
            }
        }

        print("itesmmssss= ====== > \(self.categories)")
        if searchCategory{
            self.subCategoryHeight.constant = 0
            self.categoryHeightConstraint.constant = 0
            self.imageDropDown.isHidden = true
            self.btnText.isHidden = false
            self.btnAudio.isHidden = true
            self.btnInstagram.isHidden = true
            self.btnYoutube.isHidden = true
        }else{
            if isSubCategory{
                self.btnText.isHidden = false
                self.btnAudio.isHidden = false
                self.btnInstagram.isHidden = false
            }else{
                self.btnText.isHidden = false
                self.btnAudio.isHidden = false
                self.btnInstagram.isHidden = true
            }
            
            
        }
        self.imageLogoHeader.image = UIImage(named: "Logos")
        self.ytPlayer.webView?.configuration.allowsInlineMediaPlayback = true
        self.btnAudioBack.isHidden = false
        self.viewBorder.backgroundColor = .black
        view.backgroundColor = .black
        self.menuBtnColor(.white)
        self.viewAudioDropDown.isHidden = true
        self.btnDropDown.isHidden = true
        self.lblDropDown.isHidden = true
        self.viewHeader.backgroundColor = .black
        self.btnAudioBack.setImage(UIImage(named: "backWhite"), for: .normal)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray)
        print("keyword arrya =====> \(self.keywordArray)")
        
        self.btnVideo.isHidden = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .up
        self.viewYT.addGestureRecognizer(swipeRight)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.viewYT.addGestureRecognizer(swipeDown)
//
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewYT.addGestureRecognizer(tap)
        
        self.thumbImageCollectionview.isHidden = true
        viewAudioPanel.isHidden = true
        viewModel.registerCollectionViewNib(collectionview: thumbImageCollectionview) {
            self.thumbImageCollectionview.delegate = self
            self.thumbImageCollectionview.dataSource = self
            self.thumbImageCollectionview.reloadData()
        }
        self.videoSelection = true
        categoryCollectionView.isHidden = false
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        subCategoryView.isHidden = true
        subCategoryCollectionView.isHidden = true
        self.viewModel.registerCollectionViewNib(collectionview: audioPanelCollectionView) {
            self.audioPanelCollectionView.delegate = self
            self.audioPanelCollectionView.dataSource = self
            self.audioPanelCollectionView.reloadData()
        }
        self.viewModel.registerCollectionViewNib(collectionview: textContentCollectionView) {
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.audioPlayer?.stop()
        
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                
                self.navigationController?.popViewController(animated: true)
                print("Swiped right")
            case .down:
                playsPreviousVideo()
                print("Swiped down")
            case .left:
               
                print("Swiped left")
            case .up:
                playsNextVideo()
                print("Swiped up")
            default:
                break
            }
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        isMuted = !isMuted
       
        let jsCode = isMuted ? "player.mute();" : "player.unMute();"
               ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initCategory()
        self.thumbImageCollectionview.isHidden = false
        check()
        apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
    }
    //MARK: - Menu Button Color Func
    func menuBtnColor(_ color: UIColor){
        self.btnText.tintColor = color
        self.btnVideo.tintColor = color
        self.btnAudio.tintColor = color
        self.btnBookmark.tintColor = color
        self.btnSimilar.tintColor = color
        self.viewBorder.backgroundColor = color
       
        
    }
    func apiCall(pageNo: Int,_ mainTopic: [String]?,_ subTopic: [String]?,_ keywordsTopic: [String]?,_ emotionsTopics: [String]?,_ searchCategory: Bool){
        if searchCategory{
            self.searchRequestModel.searchQuery = self.searchText
            self.searchRequestModel.currentPage = pageNo
            self.categoryViewModel.apicallGlobalSearch(pageNO: pageNo, params: self.searchRequestModel) { status, data, message in
                if status == .Success{
                    if data?.data?.data?.count == 0{
                        self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                    self.ytPlayer.delegate = self
                    
                    self.loadsFirstVideo()
                    self.thumbImageCollectionview.reloadData()
                    self.subCategoryCollectionView.reloadData()
                    self.textContentCollectionView.reloadData()
                    self.audioPanelCollectionView.reloadData()
                    print("Response is hitted successfully")
                    self.apiIsLoading = true
                }
            }
        }else{
            if keywordStatus || categoryType == 2{
                self.getVideoRequestModel.primaryCategory = self.primaryCategories
                self.getVideoRequestModel.platform = "youtube"
                self.getVideoRequestModel.keywords = keywordsTopic
                self.getVideoRequestModel.currentPage = pageNo
            }else{
                if categoryType == 0{
                    videoRequestModel.primaryCategory = self.primaryCategories
                    self.videoRequestModel.currentPage = pageNo
                    self.videoRequestModel.platform = "youtube"
                    print("posss === \(self.getVideoRequestModel.platform)")
                }else if categoryType == 1{
                    self.getVideoRequestModel.platform = "youtube"

                 self.getVideoRequestModel.primaryCategory = self.primaryCategories
                self.getVideoRequestModel.keywords = emotionsTopics
                self.getVideoRequestModel.currentPage = pageNo
                    
                }
               
                
            }
            if self.loadingStatus{
                self.stopSpinnerLoading()
            }else{
                self.startSpinnerLoading()
            }
            if categoryType == 0 {
                self.viewModel.getTopicsVideoDataApi(page: pageNo, params: self.videoRequestModel) { status, data, message in
                    if status == .Success{
                        if data?.data?.data?.count == 0{
                            self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                        self.ytPlayer.delegate = self
                        
                        self.loadsFirstVideo()
                        self.thumbImageCollectionview.reloadData()
                        self.subCategoryCollectionView.reloadData()
                        self.textContentCollectionView.reloadData()
                        self.audioPanelCollectionView.reloadData()
                        print("Response is hitted successfully")
                        self.apiIsLoading = true
                    }
                }
            }else if categoryType == 2 || keywordStatus{
                self.viewModel.getVideoDataApi(page: pageNo, params: self.getVideoRequestModel) { status, data, message in
                    if status == .Success{
                        if data?.data?.data?.count == 0{
                            self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                        self.ytPlayer.delegate = self
                        
                        self.loadsFirstVideo()
                        self.thumbImageCollectionview.reloadData()
                        self.subCategoryCollectionView.reloadData()
                        self.textContentCollectionView.reloadData()
                        self.audioPanelCollectionView.reloadData()
                        print("Response is hitted successfully")
                        self.apiIsLoading = true
                    }
                }
            }else if categoryType == 1{
                self.viewModel.getEmotionVideoDataApi(page: pageNo, params: self.getVideoRequestModel) { status, data, message in
                    if status == .Success{
                        if data?.data?.data?.count == 0{
                            self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                self.navigationController?.popViewController(animated: true)
                            })
                        }
                        self.ytPlayer.delegate = self
                        
                        self.loadsFirstVideo()
                        self.thumbImageCollectionview.reloadData()
                        self.subCategoryCollectionView.reloadData()
                        self.textContentCollectionView.reloadData()
                        self.audioPanelCollectionView.reloadData()
                        print("Response is hitted successfully")
                        self.apiIsLoading = true
                    }
                }
            }
                
            

                if self.loadingStatus{
                    self.stopSpinnerLoading()
                } else{
                    self.stopSpinnerLoading()}
            
            self.apiIsLoading = false
        }
        
    }
    func scrollToIndex(_ index: Int,_ collectionVIew: UICollectionView) {
            // Ensure that the index is within the valid range of items in the collection view
        if searchCategory{
            guard index >= 0, index < self.categoryViewModel.searchcategoriesData?.data?.count ?? 0 else {
                    return
                }
        }else{
            guard index >= 0, index < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
                    return
                }
        }
      

            // Create an index path with the desired index
            let indexPath = IndexPath(item: index, section: 0)

            // Scroll the collection view to the desired index with animation
        collectionVIew.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func bookmarkBtnAction(_ sender: UIButton) {
        if bookMarkFlow{
            self.btnBookmark.setImage(UIImage(named: "BookmarkIcon"), for: .normal)
            bookMarkFlow = false
        }else{
            self.btnBookmark.setImage(UIImage(named: "BookMarkSelect"), for: .normal)
            bookMarkFlow = true
        }
        
    }
    @IBAction func dropDownBtnAction(_ sender: UIButton) {
        if dropDownSelected{
            self.viewAudioDropDown.isHidden = true
            self.dropDownSelected = false
        }else{
            self.viewAudioDropDown.isHidden = false
            self.dropDownSelected = true
        }
    }
    
    @IBAction func instagramBtnAction(_ sender: UIButton) {
        self.ytPlayer.stopVideo()
        guard let vc = Constants.StoryBoards.main.instantiateViewController(withIdentifier: Constants.ViewController.instaVC) as? InstagramPanelViewController else{return}
        if keywordStatus{
            vc.categories = self.keywordArray
        }
        vc.keywordStatus = self.keywordStatus
        vc.isSubCategory = self.isSubCategory
        vc.instaRequestModel = self.videoRequestModel
        vc.primaryCategory = self.primaryCategories
        vc.subCategoryRequest = self.getVideoRequestModel.mainTopic
        vc.tublarCategory = self.getVideoRequestModel.primaryCategory ?? ""
//        vc.videoId = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
//        self.instaSelection = true
//        self.btnInstagram.isHidden = true
//        self.thumbImageCollectionview.isHidden = false
//        self.viewYT.isHidden = true
//
//        self.thumbImageCollectionview.reloadData()

    }
    @IBAction func audioFrwdBtnAction(_ sender: UIButton) {
        self.playNextVideo()
        self.scrollToIndex(self.currentVideoIndex, self.audioPanelCollectionView)
        self.audioPanelCollectionView.reloadData()
    }
    @IBAction func similarButtonAction(_ sender: UIButton) {
        guard let vc = Constants.StoryBoards.main.instantiateViewController(withIdentifier: Constants.ViewController.similarVC) as? SimilarCategoryViewController else{return}
        if searchCategory{
            vc.videoId = self.categoryViewModel.searchcategoriesData?.data?[currentYtIndex].videoID ?? ""
        }else{
            vc.videoId = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? ""
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ideasBtnAction(_ sender: UIButton) {
        guard let vc = Constants.StoryBoards.main.instantiateViewController(withIdentifier: "IdeasViewController") as? IdeasViewController else{return}
        self.audioPlayer?.pause()
        vc.audioUrl = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoIdea1_HiAudioMale ?? ""
        vc.getListData = self.viewModel.getVideoResponseData?.data?[currentYtIndex]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func audioBkwrdButtonAction(_ sender: UIButton) {
        self.playPreviousVideo()
        self.scrollToIndex(self.currentVideoIndex, self.audioPanelCollectionView)
        self.audioPanelCollectionView.reloadData()
    }
    
    @IBAction func textBtnAction(_ sender: UIButton) {
        self.imageLogoHeader.image = UIImage(named: "Logo1")
        self.viewHeader.backgroundColor = .white
        self.btnAudioBack.setImage(UIImage(named: "Back 1"), for: .normal)
        self.btnBack.isHidden = true
        self.btnAudioBack.isHidden = false
        self.categoryCollectionView.backgroundColor = .white
//        self.viewBorder.backgroundColor = Constants.Color.menuColor
        self.menuBtnColor(Constants.Color.menuColor ?? UIColor.white)
        view.backgroundColor = .white
        self.lblDropDown.text = self.audioLanguage
        self.viewHeader.backgroundColor = .white
        self.lblDropDown.isHidden = false
        self.btnDropDown.isHidden = false
        self.audioPanelStatus = false
        self.btnVideo.isHidden = false
        self.btnText.isHidden = true
        self.btnAudio.isHidden = false
        self.audioPlayer?.stop()
        self.ytPlayer.pauseVideo()
        self.viewTextPanel.isHidden = false
        self.viewAudioPanel.isHidden = true
        self.panelControl = 2
        if self.audioSelection{
            self.textIndexContent = self.currentVideoIndex
        }else if self.videoSelection{
            self.textIndexContent = self.currentYtIndex
        }
        self.textSelection = true
        self.audioSelection = false
        self.videoSelection = false
        self.dropDownTableView.reloadData()
        self.scrollToIndex(self.textIndexContent, self.textContentCollectionView)
        if searchCategory{
            self.lblDropDown.text = ""
            self.imageDropDown.isHidden = true
            self.btnAudio.isHidden = true
            
        }
        self.categoryCollectionView.reloadData()
    }
    
    @IBAction func audioBtnAction(_ sender: UIButton) {
        self.imageLogoHeader.image = UIImage(named: "Logo1")
        self.btnAudioBack.setImage(UIImage(named: "Back 1"), for: .normal)
        self.viewHeader.backgroundColor = .white
        self.btnAudioBack.isHidden = false
        self.btnBack.isHidden = true
        self.categoryCollectionView.backgroundColor = .white
//        self.viewBorder.backgroundColor = Constants.Color.menuColor
        self.menuBtnColor(Constants.Color.menuColor ?? .white)
        view.backgroundColor = .white
        self.lblDropDown.text = "\(self.audioVoice) - \(self.audioLanguage)"
        self.viewHeader.backgroundColor = .white
        self.lblDropDown.isHidden = false
        self.btnDropDown.isHidden = false
        self.audioPanelStatus = true
        self.btnVideo.isHidden = false
        self.btnText.isHidden = false
        self.btnAudio.isHidden = true
        self.ytPlayer.pauseVideo()
        self.audioSelection = true
        self.panelControl = 1
        if self.textSelection{
            self.currentVideoIndex = self.textIndexContent
        }else if self.videoSelection{
            self.currentVideoIndex = self.currentYtIndex
        }
       
        self.loadFirstVideo()
        self.scrollToIndex(self.currentVideoIndex, self.audioPanelCollectionView)
        self.viewAudioPanel.isHidden = false
        self.audioSelection = true
        self.videoSelection = false
        self.textSelection = false
        self.dropDownTableView.reloadData()
        self.audioPanelCollectionView.reloadData()
        self.categoryCollectionView.reloadData()
    }
    //MARK: - VIDEO BUTTON ACTION
    @IBAction func videoBtnAction(_ sender: UIButton) {
        self.imageLogoHeader.image = UIImage(named: "Logos")
        self.btnAudioBack.setImage(UIImage(named: "backWhite"), for: .normal)
        self.viewHeader.backgroundColor = .black
        self.btnBack.isHidden = false
        self.btnAudioBack.isHidden = false
        self.categoryCollectionView.backgroundColor = .black
//        self.viewBorder.backgroundColor = .black
        self.menuBtnColor(.white)
        view.backgroundColor = .black
        self.lblDropDown.isHidden = true
        self.btnDropDown.isHidden = true
        self.btnVideo.isHidden = true
        self.btnText.isHidden = false
        self.btnAudio.isHidden = false
        self.ytPlayer.playVideo()
        self.audioPlayer?.stop()
        
        if self.audioSelection{
            self.currentYtIndex = self.currentVideoIndex
        }else if self.textSelection{
            self.currentYtIndex = self.textIndexContent
        }
        
        self.loadsFirstVideo()
        self.panelControl = 0
        self.viewTextPanel.isHidden = true
        self.viewAudioPanel.isHidden = true
        self.videoSelection = true
        self.audioSelection = false
        self.textSelection = false
        self.scrollToIndex(self.currentYtIndex, self.thumbImageCollectionview)
        if searchCategory{
            self.btnAudio.isHidden = true
        }
        self.categoryCollectionView.reloadData()
    }
    
    //MARK: - MORE BUTTON ACTION
//
}
//MARK: - TABLEVIEW DELEGATE & DAtASOURCE
extension InspirationViewController: UITableViewDelegate, UITableViewDataSource{
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
            }else if indexPath.row == self.audioLanIndex{
                cell.lblDropDown.textColor = .red
            }else{
                cell.lblDropDown.textColor = .black
            }
           

            if indexPath.row == 1{
                cell.viewBorder.isHidden = false
            }
            cell.cellConfig(audiosLanguage[indexPath.row])
        }else{

            if indexPath.row == self.textLanIndex{
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
                    self.audioLanIndex = indexPath.row
    //                    cell.lblDropDown.textColor = .red
                    self.audioLanguage = cell.lblDropDown.text ?? ""
                }
                self.lblDropDown.text = "\(self.audioVoice) - \(self.audioLanguage)"
                self.loadFirstVideo()
    //            self.loadAudio(self.audioVoiceLanguage, audioBool)
                self.viewAudioDropDown.isHidden = true
                self.dropDownTableView.reloadData()
               
                }else{
                    self.textLanIndex = indexPath.row
                    self.audioLanguage = self.textaudioLanguage[indexPath.row]
                    self.lblDropDown.text = self.audioLanguage
                    self.texvalue = self.audioLanguage
                    self.langSelect = true
                    self.textContentCollectionView.reloadData()
                    self.dropDownTableView.reloadData()
                    self.viewAudioDropDown.isHidden = true
                    self.dropDownSelected = false
                    
                }
        }
    }
}

//MARK: - UICOLLECTIONVIEW DELEGATE & DATASOURCE
extension InspirationViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case thumbImageCollectionview:
            if searchCategory{
                return self.categoryViewModel.searchcategoriesData?.data?.count ?? 0
            }else{
                return self.viewModel.getVideoResponseData?.data?.count ?? 0
            }
        case categoryCollectionView:
            if categoryType == 2 || keywordStatus {
               return self.categories.count
            }else if categoryType == 0{
                return self.selectedCategoriesArray.count
            }else{
                return self.categories.count
            }
            
        case textContentCollectionView:
            if searchCategory{
                return self.categoryViewModel.searchcategoriesData?.data?.count ?? 0
            }else{
                return self.viewModel.getVideoResponseData?.data?.count ?? 0
            }
            
        case audioPanelCollectionView:
            return self.viewModel.getVideoResponseData?.data?.count ?? 0
        default:
            return 0
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if instaSelection{
            return CGFloat(10)
        }
        return CGFloat(0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if instaSelection{
           return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        }
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch collectionView {
        case thumbImageCollectionview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbNailCollectionViewCell", for: indexPath) as? ThumbNailCollectionViewCell else{return UICollectionViewCell()}
            if searchCategory{
                cell.btnPlayInsta.isHidden = true
                cell.cellConfig(self.categoryViewModel.searchcategoriesData?.data?[indexPath.item].videoID ?? "")
                return cell
            }else{
                if instaSelection{
                    cell.btnPlayInsta.isHidden = false
                    cell.imageThumbNail.contentMode = .scaleAspectFill
                    cell.cellConfig(self.viewModel.getVideoResponseData?.data?[indexPath.item].videoID ?? "")
                    cell.closureInstaPlay = {
                        guard let url = URL(string: "https://www.instagram.com/reel/CwHwyq-KhIU/?igshid=MzRlODBiNWFlZA==") else {
                          return //be safe
                        }

                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }else{
                    cell.btnPlayInsta.isHidden = true
                    cell.cellConfig(self.viewModel.getVideoResponseData?.data?[indexPath.item].videoID ?? "")
                }
                return cell
            }
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else{
                return UICollectionViewCell()
            }
            if videoSelection{
                cell.imageClose.image = UIImage(named: "CloseVideo")
                cell.categoriesLable.textColor = .white
                cell.viewBorder.borderColor = .white
            }else{
                cell.imageClose.image = UIImage(named: "close")
                cell.categoriesLable.textColor = Constants.Color.menuColor
                cell.viewBorder.borderColor = Constants.Color.menuColor
            }

            if categoryType == 2 || keywordStatus || categoryType == 1{
                cell.categoriesLable.text = self.categories[indexPath.item]
            }else if categoryType == 0{
                cell.categoriesLable.text = self.selectedCategoriesArray[indexPath.item].displayName
            }
            
            return cell
        case textContentCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextContentCollectionViewCell", for: indexPath) as? TextContentCollectionViewCell else{return UICollectionViewCell()}
            if searchCategory{
                cell.cellSearchConfig(self.categoryViewModel.searchcategoriesData?.data?[indexPath.item] ?? SearchCategoryDatum(), self.langSelect, self.audioLanguage)
            }else{
                cell.cellConfig(self.viewModel.getVideoResponseData?.data?[indexPath.item] ?? GetVideoData(), self.langSelect, self.texvalue)
            }
           
            
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
                cell.labelAudioTitle.text = self.viewModel.getVideoResponseData?.data?[indexPath.item].videoTitle
            }
           
            return cell
        default:
            return UICollectionViewCell()
        }
           
       
       
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        audioIndex = indexPath.item
        if collectionView == textContentCollectionView{
            textIndexContent = indexPath.item
            if searchCategory{
                if textIndexContent + 1 == self.categoryViewModel.searchcategoriesData?.data?.count{
                    if self.videoPageNo < self.categoryViewModel.searchTotalPageNo{
                        self.videoPageNo += 1
                        self.apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                    }
                }
            }else{
                if textIndexContent + 1 == self.viewModel.getVideoResponseData?.data?.count{
                    if self.videoPageNo < self.viewModel.TotalVideoPageNo{
                        self.videoPageNo += 1
                        self.apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                    }
                }
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            
            self.loadingStatus = true
            if indexPath.item != 0{
                if keywordStatus || categoryType == 2{
                    if self.keywordArray.count > -1{
                        if self.keywordArray.contains(selectedString ?? ""){
                            let removeKeyword = self.keywordArray.index(of: selectedString ?? "aa") ?? 0
                            self.keywordArray.remove(at: removeKeyword)
                        }
                    }
                    self.apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                    self.thumbImageCollectionview.reloadData()
                   
                    self.textContentCollectionView.reloadData()
                    self.subCategoryCollectionView.reloadData()
                    self.audioPanelCollectionView.reloadData()
                    self.categoryCollectionView.reloadData()
                }else{
                    if categoryType == 0{
                        selectedString = self.selectedCategoriesArray[indexPath.item].displayName
                        if indexPath.item == 0{
                            if let viewControllers = navigationController?.viewControllers {
                                if viewControllers.count >= 3 {
                                    let targetViewController = viewControllers[viewControllers.count - 3]

                                    // Use the popToViewController method to navigate back
                                    navigationController?.popToViewController(targetViewController, animated: true)
                                }
                            }
                        }else{
                            var tempSubCatIndex = -1
                            for i in 0..<self.videoRequestModel.mainTopic.count{
                                if self.videoRequestModel.mainTopic[i].subCatOne == self.selectedCategoriesArray[indexPath.item].subCatOne{
                                    tempSubCatIndex = i
                                    break
                                }
                            }
                            if tempSubCatIndex != -1{
                                if self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo.isEmpty{
                                    self.videoRequestModel.mainTopic.remove(at: tempSubCatIndex)
                                }else{
                                    print("beforeee array ===> \(self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo)")
                                    if self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo.contains(self.selectedCategoriesArray[indexPath.item].subCatTwo){
                                        let removeSubTopic = self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo.index(of: self.selectedCategoriesArray[indexPath.item].subCatTwo) ?? 0
                                        self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo.remove(at: removeSubTopic)
                                        print("aftre ==== array ===> \(self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo)")
                                                                }
                                    if self.videoRequestModel.mainTopic[tempSubCatIndex].subCatTwo.isEmpty{
                                        self.videoRequestModel.mainTopic.remove(at: tempSubCatIndex)
                                    }
                                    print("aftre ==== array ===> \(self.videoRequestModel.mainTopic)")
                                }
                            }
                        }
                        self.apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                        self.selectedCategoriesArray.remove(at: indexPath.item)
                        self.thumbImageCollectionview.reloadData()
                        self.textContentCollectionView.reloadData()
                        self.subCategoryCollectionView.reloadData()
                        self.audioPanelCollectionView.reloadData()
                        self.categoryCollectionView.reloadData()
                    }else if categoryType == 1{
                        selectedString = self.categories[indexPath.item]
                        if self.emotionArray.count > -1{
                            if self.emotionArray.contains(selectedString ?? ""){
                                let removeKeyword = self.emotionArray.index(of: selectedString ?? "aa") ?? 0
                                self.emotionArray.remove(at: removeKeyword)
                            }
                        }
                        self.apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                        self.categories.remove(at: indexPath.item)
                        self.thumbImageCollectionview.reloadData()
                       
                        self.textContentCollectionView.reloadData()
                        self.subCategoryCollectionView.reloadData()
                        self.audioPanelCollectionView.reloadData()
                        self.categoryCollectionView.reloadData()
                    }
                }
            }else{
                if let viewControllers = navigationController?.viewControllers {
                    if viewControllers.count >= 3 {
                        let targetViewController = viewControllers[viewControllers.count - 3]

                        // Use the popToViewController method to navigate back
                        navigationController?.popToViewController(targetViewController, animated: true)
                    }
                }
            }
            self.indexItem = indexPath.item
            categoryCollectionView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? VideosListCollectionViewCell{

            self.closurr = {
                cell.pause()
            }
            cell.pause()

        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case thumbImageCollectionview:
            if instaSelection{
                return CGSize(width: self.thumbImageCollectionview.frame.size.width / 2 - 10, height: 350)
            }else{
                return collectionView.bounds.size
            }
           
        case categoryCollectionView:
            if categoryType == 2 || keywordStatus{
                return CGSize(width: (categories[indexPath.item].size(withAttributes: nil).width ) + 65, height: 35)
            }else if categoryType == 0{
                return CGSize(width: (selectedCategoriesArray[indexPath.item].displayName.size(withAttributes: nil).width ) + 65, height: 35)
            }else{
                return CGSize(width: (categories[indexPath.item].size(withAttributes: nil).width ) + 65, height: 35)
            }
            
        case textContentCollectionView:
            return collectionView.bounds.size
        case audioPanelCollectionView:
            return collectionView.bounds.size
        default:
            return CGSize(width: 100, height: 100)
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{check()}
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        check()
    }
    
    func check() {
        DispatchQueue.main.async {
            if self.panelControl == 1{
                if self.currentVideoIndex < self.audioIndex{
                    self.playNextVideo()
                }else if self.currentVideoIndex > self.audioIndex{
                    self.playPreviousVideo()
                }
                
            }
           
         
        }
       
    }
}

extension InspirationViewController {

    func addAudioPlayerTimeObserver(for player: AVAudioPlayer?, progressView: UISlider) {
        if currentVideoIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0{

            let interval = 0.1
            audioPlayer?.addObserver(self, forKeyPath: "currentTime", options: .new, context: nil)

            Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
                guard let strongSelf = self else { return }

                let currentTime = Float(self?.audioPlayer?.currentTime ?? 0.0)
                let duration = Float(self?.audioPlayer?.duration ?? 0.0)
                let endtime = duration / 10000
                self?.lblAudioDuration.text = "0.\(Int(duration))"
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
        if currentVideoIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0{
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
extension InspirationViewController{
    func loadFirstVideo() {
                guard currentVideoIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
//         Handle end of video array
                    return
                }
        var aud = ""
        switch self.audioLanguage {
        case "English":
            if self.audioVoice == "Male" {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audEngML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audEngFML ?? ""
            }
        case "Hindi":
            if self.audioVoice == "Male" {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audHindiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audHindiFML ?? ""
            }
        case "Tamil":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTamML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTamFML ?? ""
            }
        case "Bengali":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audBengaliML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audBengaliFML ?? ""
            }
        case "Telugu":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTeluguML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTeluguFML ?? ""
            }
        case "Marathi":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMarathiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMarathiFML ?? ""
            }
        case "Gujarathi":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audGujarathiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audGujarathiFML ?? ""
            }
        case "Kannada":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audKannadaML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audKannadaFML ?? ""
            }
        case "Malayalam":
            if self.audioVoice == "Male"{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMalayalamML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMalayalamFML ?? ""
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
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                player.prepareToPlay()
                self.addAudioPlayerTimeObserver(for: self.audioPlayer, progressView: self.progressSlider)
                player.play()
                
            } catch let error as NSError {
                print(error.description)
            }
            
        }
        
    }
    func playNextVideo() {
                currentVideoIndex += 1
                guard currentVideoIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
                    // Handle end of video array
                    return
                }
        var aud = ""
        switch self.audioLanguage {
        case "English":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audEngML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audEngFML ?? ""
            }
        case "Hindi":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audHindiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audHindiFML ?? ""
            }
        case "Tamil":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTamML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTamFML ?? ""
            }
        case "Bengali":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audBengaliML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audBengaliFML ?? ""
            }
        case "Telugu":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTeluguML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTeluguFML ?? ""
            }
        case "Marathi":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMarathiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMarathiFML ?? ""
            }
        case "Gujarathi":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audGujarathiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audGujarathiFML ?? ""
            }
        case "Kannada":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audKannadaML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audKannadaFML ?? ""
            }
        case "Malayalam":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMalayalamML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMalayalamFML ?? ""
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
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                player.prepareToPlay()
                self.addAudioPlayerTimeObserver(for: self.audioPlayer, progressView: self.progressSlider)
                player.play()
                
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
    
    func playPreviousVideo() {
        currentVideoIndex -= 1
        guard currentVideoIndex >= 0 && currentVideoIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
            // Handle end of video array
            return
        }
        var aud = ""
        switch self.audioLanguage {
        case "English":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audEngML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audEngFML ?? ""
            }
        case "Hindi":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audHindiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audHindiFML ?? ""
            }
        case "Tamil":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTamML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTamFML ?? ""
            }
        case "Bengali":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audBengaliML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audBengaliFML ?? ""
            }
        case "Telugu":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTeluguML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audTeluguFML ?? ""
            }
        case "Marathi":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMarathiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMarathiFML ?? ""
            }
        case "Gujarathi":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audGujarathiML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audGujarathiFML ?? ""
            }
        case "Kannada":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audKannadaML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audKannadaFML ?? ""
            }
        case "Malayalam":
            if self.audioVoice == "Male"  {
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMalayalamML ?? ""
            }else{
                aud = self.viewModel.getVideoResponseData?.data?[currentVideoIndex].audMalayalamFML ?? ""
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
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                player.prepareToPlay()
                player.play()
                
            } catch let error as NSError {
                print(error.description)
            }
        }
        
    }
}
extension InspirationViewController: WKYTPlayerViewDelegate{
   
    
  func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
      debugPrint("playerdidBecome Ready ======> ")
//        if currentYtIndex == 0{
//                   DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400), execute: {
//                       if self.isMuted{
//                           let jsCode = "player.mute();"
//                           self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                           self.ytPlayer.playVideo()
//                       }else{
//                           let jsCode = "player.unMute();"
//                           self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                           self.ytPlayer.playVideo()
//                       }
//                       self.thumbImageCollectionview.isHidden = false
//                   })
//               }else{
//
//                   if self.isMuted{
//                       let jsCode = "player.mute();"
//                       self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                       self.ytPlayer.playVideo()
//                   }else{
//                       let jsCode = "player.unMute();"
//                       self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                       self.ytPlayer.playVideo()
//                   }
//
//                   self.thumbImageCollectionview.isHidden = false
//               }
     
      self.ytPlayer.playVideo()
//      self.thumbImageCollectionview.isHidden = false
    }
//    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
//
//        if currentYtIndex == 0{
//            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400), execute: {
//                if self.isMuted{
//                    let jsCode = "player.mute();"
//                    self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                    self.ytPlayer.playVideo()
//                }else{
//                    let jsCode = "player.unMute();"
//                    self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                    self.ytPlayer.playVideo()
//                }
//                self.thumbImageCollectionview.isHidden = false
//            })
//        }else{
//
//            if self.isMuted{
//                let jsCode = "player.mute();"
//                self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                self.ytPlayer.playVideo()
//            }else{
//                let jsCode = "player.unMute();"
//                self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                self.ytPlayer.playVideo()
//            }
//
//            self.thumbImageCollectionview.isHidden = false
//        }
//    }
   
    func loadsFirstVideo() {
        if searchCategory{
            guard currentYtIndex < self.categoryViewModel.searchcategoriesData?.data?.count ?? 0 else{
                // Handle end of video array
                return
            }
            let videoId = self.categoryViewModel.searchcategoriesData?.data?[currentYtIndex].videoID ?? ""
            print("=======ID",videoId,"=======", Date().timeIntervalSince1970)
            
                self.ytPlayer.load(withVideoId: videoId, playerVars: ["start": 0.2,"controls": 0,"iv_load_policy": 3])
          
            print("=======ID",videoId,"=======", Date().timeIntervalSince1970)
        }else{
            guard currentYtIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
                // Handle end of video array
                return
            }
            let videoId = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? ""
            print("=======ID",videoId,"=======", Date().timeIntervalSince1970)
            
                self.ytPlayer.load(withVideoId: videoId, playerVars: ["start": 0.2,"controls": 0,"iv_load_policy": 3])
          
            print("=======ID",videoId,"=======", Date().timeIntervalSince1970)
        }
       
        
        
    }
    func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
        debugPrint("playerdidBecome Ready ======> Stateeee ",state)
        print("=======ID","\(String(describing:state))=======", Date().timeIntervalSince1970)
        switch state {
        case .buffering:
            self.thumbImageCollectionview.isHidden = false
        case .playing:
            self.thumbImageCollectionview.isHidden = true
        case .ended:
            self.ytPlayer.playVideo()
        default:
            break
        }
        
    }
//     func playerView(_ playerView: WKYTPlayerView, didChangeTo state: WKYTPlayerState) {
//        if state == .buffering{
//            self.ytPlayer.isHidden = true
//           self.thumbImageCollectionview.isHidden = false
//        } else if state == .playing{
//            self.viewYT.backgroundColor = .clear
////            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2), execute: {
//                self.thumbImageCollectionview.isHidden = true
//                self.ytPlayer.isHidden = false
////            })
//
//       }else if state == .ended{
//           if self.isMuted{
//               let jsCode = "player.mute();"
//               self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//               self.ytPlayer.playVideo()
//           }else{
//               let jsCode = "player.unMute();"
//               self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//               self.ytPlayer.playVideo()
//           }
//
//       }
//    }
//    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
//         if state == .buffering{
//             self.ytPlayer.isHidden = true
//            self.thumbImageCollectionview.isHidden = false
//         }else if state == .unstarted{
//             self.ytPlayer.isHidden = true
//            self.thumbImageCollectionview.isHidden = false
//         } else if state == .playing{
//             self.viewYT.backgroundColor = .clear
//             DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(8), execute: {
//                 self.thumbImageCollectionview.isHidden = true
//                 self.ytPlayer.isHidden = false
//             })
//
//        }else if state == .ended{
//            if self.isMuted{
//                let jsCode = "player.mute();"
//                self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                self.ytPlayer.playVideo()
//            }else{
//                let jsCode = "player.unMute();"
//                self.ytPlayer.webView?.evaluateJavaScript(jsCode, completionHandler: nil)
//                self.ytPlayer.playVideo()
//            }
//
//        }
//    }
//
//    func playerReady(_ videoPlayer: YTPlayerView) {
//        // Video player is ready
//        loadsFirstVideo()
//    }

    func playsNextVideo() {
 
        currentYtIndex += 1
        scrollToIndex(currentYtIndex, self.thumbImageCollectionview)
        if searchCategory{
           
            guard currentYtIndex < self.categoryViewModel.searchcategoriesData?.data?.count ?? 0 else {
                // Handle end of video array
                
                return
            }
            self.thumbImageCollectionview.isHidden = false
            if ((self.categoryViewModel.searchcategoriesData?.data?.count ?? 0) - self.currentYtIndex == 5) && videoPageNo != self.categoryViewModel.searchTotalPageNo && self.apiIsLoading == true{
                self.loadingStatus = true
                videoPageNo += 1
                apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                let videoId = self.categoryViewModel.searchcategoriesData?.data?[currentYtIndex].videoID ?? ""
                DispatchQueue.main.async {
                    
                    self.ytPlayer.cueVideo(byId: (self.categoryViewModel.searchcategoriesData?.data?[self.currentYtIndex].videoID ?? ""), startSeconds: 0.0, suggestedQuality: .auto)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.ytPlayer.playVideo()
                    }
                }
            }else{
               
                    let videoId = self.categoryViewModel.searchcategoriesData?.data?[currentYtIndex].videoID ?? ""
                    DispatchQueue.main.async {
                        
                        self.ytPlayer.cueVideo(byId: (self.categoryViewModel.searchcategoriesData?.data?[self.currentYtIndex].videoID ?? ""), startSeconds: 0.0, suggestedQuality: .auto)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.ytPlayer.playVideo()
                        }
                    }
                
               
            }
//            DispatchQueue.main.async {
//
//                self.ytPlayer.cueVideo(byId: (self.categoryViewModel.searchcategoriesData?.data?[self.currentYtIndex].videoID ?? ""), startSeconds: 0.0, suggestedQuality: .auto)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    self.ytPlayer.playVideo()
//                }
//            }
//
//            print("=======ID",(self.categoryViewModel.searchcategoriesData?.data?[currentYtIndex].videoID ?? ""),"=======", Date().timeIntervalSince1970)
        }else{
            
            guard currentYtIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
                // Handle end of video array
                
                return
            }
            self.thumbImageCollectionview.isHidden = false
    //        self.ytPlayer.load(withVideoId: self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? "", playerVars: ["start": 0.2,"controls": 0,"iv_load_policy": 3])
            if ((self.viewModel.getVideoResponseData?.data?.count ?? 0) - self.currentYtIndex == 5) && videoPageNo != self.viewModel.TotalVideoPageNo && self.apiIsLoading == true{
                self.loadingStatus = true
                videoPageNo += 1
                apiCall(pageNo: self.videoPageNo, self.mainTopic, self.subTopic, self.keywordArray, self.emotionArray, self.searchCategory)
                let videoId = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? ""
                DispatchQueue.main.async {
                    
                    self.ytPlayer.cueVideo(byId: (self.viewModel.getVideoResponseData?.data?[self.currentYtIndex].videoID ?? ""), startSeconds: 0.0, suggestedQuality: .auto)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.ytPlayer.playVideo()
                    }
                }
            }else{
               
                    let videoId = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? ""
                    DispatchQueue.main.async {
                        
                        self.ytPlayer.cueVideo(byId: (self.viewModel.getVideoResponseData?.data?[self.currentYtIndex].videoID ?? ""), startSeconds: 0.0, suggestedQuality: .auto)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.ytPlayer.playVideo()
                        }
                    }
            }
          
        }
        
      

        
    }
    func playsPreviousVideo() {

        currentYtIndex -= 1
        scrollToIndex(currentYtIndex, self.thumbImageCollectionview)
        if searchCategory{
            guard currentYtIndex >= 0 && currentYtIndex < self.categoryViewModel.searchcategoriesData?.data?.count ?? 0 else {
                // Handle beginning of video array
                return
            }
            let videoId = self.categoryViewModel.searchcategoriesData?.data?[currentYtIndex].videoID ?? ""
           
    //            self.ytPlayer.load(withVideoId: videoId, playerVars: ["start": 0.1,"controls": 0,"iv_load_policy": 3])
            DispatchQueue.main.async{
                self.ytPlayer.cueVideo(byId: videoId, startSeconds: 0.0, suggestedQuality: .small)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.ytPlayer.playVideo()
                }
            }
            print("=======ID",videoId,"=======", Date().timeIntervalSince1970)
            self.thumbImageCollectionview.isHidden = false
            
        }else{
            guard currentYtIndex >= 0 && currentYtIndex < self.viewModel.getVideoResponseData?.data?.count ?? 0 else {
                // Handle beginning of video array
                return
            }
            let videoId = self.viewModel.getVideoResponseData?.data?[currentYtIndex].videoID ?? ""
           
    //            self.ytPlayer.load(withVideoId: videoId, playerVars: ["start": 0.1,"controls": 0,"iv_load_policy": 3])
            DispatchQueue.main.async{
                self.ytPlayer.cueVideo(byId: videoId, startSeconds: 0.0, suggestedQuality: .small)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.ytPlayer.playVideo()
                }
            }
            print("=======ID",videoId,"=======", Date().timeIntervalSince1970)
            self.thumbImageCollectionview.isHidden = false
        }
    
        
    }
    func initCategory(){
        self.selectCategories.displayName = self.primaryCategories
        self.selectedCategoriesArray.append(self.selectCategories)
        for i in self.videoRequestModel.mainTopic{
            if i.subCatTwo.isEmpty{
                self.selectCategories.displayName = i.subCatOne
                self.selectCategories.subCatOne = i.subCatOne
                self.selectedCategoriesArray.append(self.selectCategories)
            }else{
                for j in i.subCatTwo{
                    self.selectCategories.displayName = i.subCatOne + " - " + j
                    self.selectCategories.subCatOne = i.subCatOne
                    self.selectCategories.subCatTwo = j
                    self.selectedCategoriesArray.append(self.selectCategories)
                    
                }
            }
        }
        self.categoryCollectionView.reloadData()
        print("selected categoriess ===> \(self.selectedCategoriesArray)")
    }
//    @IBAction func moreButtonAction(_ sender: UIButton) {
   //        self.thumbImageCollectionview.isHidden = false
   //        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
   //        guard let vc = storyBoard.instantiateViewController(withIdentifier: "MoreDescriptionPresentViewController") as? MoreDescriptionPresentViewController else { return  }
   //
   //        self.ytPlayer.pauseVideo()
   //        vc.instaSelection = self.playerSwitch
   //        vc.getVideoData = self.viewModel.getVideoResponseData?.data?[videoIndexContent] ?? GetVideoData()
   //        vc.controlPanel = self.panelControl
   //        vc.closureTextContent = {[unowned self] textContent in
   //            self.texvalue = textContent
   //            self.langSelect = true
   //            self.textContentCollectionView.reloadData()
   //
   //        }
   //        vc.closureAudioML = {[unowned self] maleContent in
   //            self.audioLanguage = vc.audioLanguages
   //            self.audioVoiceSelect = true
   //            self.audioVoice = vc.audioVoice
   //            self.loadFirstVideo()
   //            self.audioPanelCollectionView.reloadData()
   //        }
   //        vc.closureAudioLan = {[unowned self] maleContent in
   //
   //            self.audioLanguage = vc.audioLanguages
   //            self.audioVoiceSelect = true
   //            self.audioVoice = vc.audioVoice
   //            self.currentVideoIndex = self.currentYtIndex
   //            self.loadFirstVideo()
   //            self.audioPanelCollectionView.reloadData()
   //        }
   //        vc.closureTextAction = {
   //            self.audioPlayer?.stop()
   //            self.ytPlayer.pauseVideo()
   //            self.viewTextPanel.isHidden = false
   //            self.viewAudioPanel.isHidden = true
   //            self.panelControl = 2
   //            if self.audioSelection{
   //                self.currentYtIndex = self.currentVideoIndex
   //            }else if self.videoSelection{
   //                self.currentYtIndex = self.currentYtIndex
   //            }else{
   //                self.currentYtIndex = self.textIndexContent
   //            }
   //            self.textSelection = true
   //            self.audioSelection = false
   //            self.videoSelection = false
   //            self.scrollToIndex(self.currentYtIndex, self.textContentCollectionView)
   //
   //        }
   //        vc.closureVideoAction = {
   //            self.ytPlayer.playVideo()
   //            self.audioPlayer?.stop()
   //
   //            if self.audioSelection{
   //                self.currentYtIndex = self.currentVideoIndex
   //            }else if self.textSelection{
   //                self.currentYtIndex = self.textIndexContent
   //            }else{
   //                self.currentYtIndex = self.currentYtIndex
   //            }
   //
   //            self.loadsFirstVideo()
   //            self.panelControl = 0
   //            self.viewTextPanel.isHidden = true
   //            self.viewAudioPanel.isHidden = true
   //            self.videoSelection = true
   //            self.audioSelection = false
   //            self.textSelection = false
   //            self.scrollToIndex(self.currentYtIndex, self.thumbImageCollectionview)
   //        }
   //        vc.closureAudioAction = {
   //            self.ytPlayer.pauseVideo()
   //            self.audioSelection = true
   //            self.audioLanguage = vc.audioLanguages
   //            self.audioVoice = vc.audioVoice
   //            self.panelControl = 1
   //            if self.textSelection{
   //                self.currentVideoIndex = self.textIndexContent
   //            }else if self.videoSelection{
   //                self.currentVideoIndex = self.currentYtIndex
   //            }else{
   //                self.currentVideoIndex = self.currentVideoIndex
   //            }
   //
   //            self.loadFirstVideo()
   //            self.scrollToIndex(self.currentVideoIndex, self.audioPanelCollectionView)
   //            self.viewAudioPanel.isHidden = false
   //            self.audioSelection = true
   //            self.videoSelection = false
   //            self.textSelection = false
   //            self.audioPanelCollectionView.reloadData()
   //        }
   //        vc.closureDismiss = {
   //            if self.panelControl == 0{
   //                self.ytPlayer.playVideo()
   //            }else if self.panelControl == 1{
   //                self.ytPlayer.pauseVideo()
   //            }else if self.panelControl == 2{
   //                self.ytPlayer.pauseVideo()
   //            }
   //            self.thumbImageCollectionview.isHidden = true
   //        }
   //        vc.audioLanguages = self.audioLanguage
   //        vc.audioVoice = self.audioVoice
   //        vc.modalPresentationStyle = .overCurrentContext
   //        self.present(vc, animated: true)
   //    }
}
