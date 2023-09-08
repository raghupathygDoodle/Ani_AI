//
//  InstagramPanelViewController.swift
//  Ani
//
//  Created by Raghu on 22/08/23.
//

import UIKit
import WebKit

class InstagramPanelViewController: BaseVC{

    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var heightCategoryConstraint: NSLayoutConstraint!
    @IBOutlet weak var textSynopsisTableview: UITableView!
    @IBOutlet weak var lblHeaderSynopsis: UILabel!
    @IBOutlet weak var viewSynopsis: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var InstaThumbnailCollection: UICollectionView!

    var instaImage = ""
    var headerText = ""
    var tublarCategory = ""
    var bookmarkSelect = false
    var subCategoryRequest = [SubCategoryType]()
    var similarVideo = false
    var similarId = ""
    var primaryCategory = ""
    var synopsisFlow = false
    var contentIndex = Int()
    var isSubCategory = false
    var keywordStatus = false
    var selectedString = ""
    var totalPage = 1
    
    var viewModel = InspirationViewModel()
    var instaRequestModel = TopicVideoRequestModel()
    var similarViewModel = SimilarCategoryViewModel()
    var similarRequestModel = SimilarVideoRequestModel()
    var getVideoRequestModel = GetVideoDataRequestModel()
    var categories = [String]()
    var selectCategories = SelectedCategory()
    var selectedCategoriesArray = [SelectedCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDetails.isHidden = true
        self.categories.insert(self.primaryCategory, at: 0)
        print("catgoruees====> \(self.categories)")
        self.initCategorys()
        self.viewSynopsis.isHidden = true
        if keywordStatus{
            self.apiCallInstaByKeyword(page: 1)
        }else{
            self.apiCallInsta(page: 1)

        }
        self.InstaThumbnailCollection.delegate = self
        self.InstaThumbnailCollection.dataSource = self
        self.InstaThumbnailCollection.register(UINib(nibName: "InstaThumbCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InstaThumbCollectionViewCell")
        
        self.textSynopsisTableview.delegate = self
        self.textSynopsisTableview.dataSource = self
        self.textSynopsisTableview.register(UINib(nibName: "ContentTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTextTableViewCell")
        
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        
        self.categoryCollectionView.reloadData()
        self.textSynopsisTableview.reloadData()
        self.InstaThumbnailCollection.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func backBtnAction(_ sender: UIButton) {
        if synopsisFlow{
            self.lblDetails.isHidden = true
            self.viewSynopsis.isHidden = true
            self.synopsisFlow = false
        }else if similarVideo{
            self.similarVideo = false
            if keywordStatus{
                self.apiCallInstaByKeyword(page: 1)
            }else{
                self.apiCallInsta(page: 1)
            }
          
            self.heightCategoryConstraint.constant = 65
            self.InstaThumbnailCollection.reloadData()
        } else{
            self.navigationController?.popViewController(animated: true)
        }
       
    }

    @IBAction func youtubeBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension InstagramPanelViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            if keywordStatus{
                return self.categories.count
            }else{
                return self.selectedCategoriesArray.count
            }
            
        case InstaThumbnailCollection:
            if similarVideo{
                return self.similarViewModel.getInstaSimilarVideoData?.data?.count ?? 0
            }else{
                return self.viewModel.getVideoResponseData?.data?.count ?? 0
            }
        default:
            return 0
        }
       
       
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if similarVideo{
            if indexPath.row + 1 == similarViewModel.getInstaSimilarVideoData?.data?.count {
                //                debugPrint("You reached end of notification collectionView and lastPage indexPath.row = \(indexPath.row) ")
                if similarViewModel.instaPageNo < similarViewModel.totalInstaPageNo{
                    similarViewModel.instaPageNo += 1
                    apiCallInstaSimilar(similarId, self.similarViewModel.instaPageNo)
                }
            }
        }else{
            if keywordStatus{
                if indexPath.row + 1 == viewModel.getVideoResponseData?.data?.count {
                    //                debugPrint("You reached end of notification collectionView and lastPage indexPath.row = \(indexPath.row) ")
                    if viewModel.pageNo < viewModel.totalInstaPage{
                        viewModel.pageNo += 1
                        apiCallInstaByKeyword(page: viewModel.pageNo)
                    }
                }
            }else{
                if indexPath.row + 1 == viewModel.getVideoResponseData?.data?.count {
                    //                debugPrint("You reached end of notification collectionView and lastPage indexPath.row = \(indexPath.row) ")
                    if viewModel.pageNo < viewModel.totalInstaPage{
                        viewModel.pageNo += 1
                        apiCallInsta(page: viewModel.pageNo)
                    }
                }
            }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
           
                cell.imageClose.image = UIImage(named: "close")
                cell.categoriesLable.textColor = Constants.Color.menuColor
                cell.viewBorder.borderColor = Constants.Color.menuColor

            if keywordStatus{
                cell.categoriesLable.text = self.categories[indexPath.item]
            }else{
                cell.categoriesLable.text = self.selectedCategoriesArray[indexPath.item].displayName
            }
            
            return cell
        case InstaThumbnailCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstaThumbCollectionViewCell", for: indexPath) as? InstaThumbCollectionViewCell else { return UICollectionViewCell() }
            cell.btnSummary.tag = indexPath.item
            cell.btnBookMark.tag = indexPath.item
            cell.instaImageView.contentMode = .scaleAspectFill
            cell.closureSummary = { [unowned self] text in
                self.viewSynopsis.isHidden = false
                self.lblDetails.isHidden = false
                self.synopsisFlow = true
                self.contentIndex = text
                self.textSynopsisTableview.reloadData()
            }
            cell.closureBookMark = { [unowned self] bookMark in
             
                    if bookmarkSelect{
                        self.bookmarkSelect = false
                        cell.btnBookMark.setImage(UIImage(named: "BookmarkIcon"), for: .normal)
                    }else{
                        self.bookmarkSelect = true
                        cell.btnBookMark.setImage(UIImage(named: "BookMarkSelect"), for: .normal)
                    }
                
            }
            cell.closureSimilar = { [unowned self] similar in
                self.similarVideo = true
                self.heightCategoryConstraint.constant = 0
                self.similarId = self.viewModel.getVideoResponseData?.data?[similar].videoID ?? ""
                self.apiCallInstaSimilar(self.similarId, 1)
                
                self.InstaThumbnailCollection.reloadData()
                
                
            }
            if similarVideo{
                cell.cellConfig(self.similarViewModel.getInstaSimilarVideoData?.data?[indexPath.item].videoID ?? "")
            }else{
                cell.cellConfig(self.viewModel.getVideoResponseData?.data?[indexPath.item].videoID ?? "")
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case InstaThumbnailCollection:
            return 2
        default:
            return 0
        }
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case categoryCollectionView:
            return 8
        case InstaThumbnailCollection:
            return 2
        default:
            return 0
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case categoryCollectionView:
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        case InstaThumbnailCollection:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        default:
            return UIEdgeInsets.zero
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoryCollectionView:
            if keywordStatus{
                return CGSize(width: (categories[indexPath.item].size(withAttributes: nil).width ) + 65, height: 35)
            }else{
                return CGSize(width: (selectedCategoriesArray[indexPath.item].displayName.size(withAttributes: nil).width ) + 65, height: 35)
            }
          
        case InstaThumbnailCollection:
            return CGSize(width: self.InstaThumbnailCollection.frame.size.width / 2 - 6, height: 350)
        default:
            return CGSize(width: 0, height: 0)
            
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            if indexPath.item == 0{
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "HomeCategoriesViewController") as? HomeCategoriesViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                if keywordStatus{
                    self.selectedString = self.categories[indexPath.row]
                    if self.categories.count > -1{
                        if self.categories.contains(selectedString ?? ""){
                            let removeKeyword = self.categories.index(of: selectedString ?? "aa") ?? 0
                            self.categories.remove(at: removeKeyword)
                        }
                    }
                    self.apiCallInstaByKeyword(page: self.totalPage)
                    self.InstaThumbnailCollection.reloadData()
                    self.categoryCollectionView.reloadData()
                }else{
                    var tempSubCatIndex = -1
                    for i in 0..<self.instaRequestModel.mainTopic.count{
                        if self.instaRequestModel.mainTopic[i].subCatOne == self.selectedCategoriesArray[indexPath.item].subCatOne{
                            tempSubCatIndex = i
                            break
                        }
                    }
                    if tempSubCatIndex != -1{
                        if self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo.isEmpty{
                            self.instaRequestModel.mainTopic.remove(at: tempSubCatIndex)
                        }else{
                            print("beforeee array ===> \(self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo)")
                            if self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo.contains(self.selectedCategoriesArray[indexPath.item].subCatTwo){
                                let removeSubTopic = self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo.index(of: self.selectedCategoriesArray[indexPath.item].subCatTwo) ?? 0
                                self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo.remove(at: removeSubTopic)
                                print("aftre ==== array ===> \(self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo)")
                                                        }
                            if self.instaRequestModel.mainTopic[tempSubCatIndex].subCatTwo.isEmpty{
                                self.instaRequestModel.mainTopic.remove(at: tempSubCatIndex)
                            }
                            print("aftre ==== array ===> \(self.instaRequestModel.mainTopic)")
                        }
                    }
                
                    apiCallInsta(page: viewModel.pageNo)
                    self.selectedCategoriesArray.remove(at: indexPath.item)
                    self.InstaThumbnailCollection.reloadData()
                }
            }
            
            
        self.categoryCollectionView.reloadData()
        case InstaThumbnailCollection:
            var instaURL = URL(string: "")
            if similarVideo{
                guard let url = URL(string: "https://www.instagram.com/reel/\(self.similarViewModel.getInstaSimilarVideoData?.data?[indexPath.item].videoID ?? "")") else {
                  return //be safe
                }
             instaURL = url
            }else{
                guard let url = URL(string: "https://www.instagram.com/reel/\(self.viewModel.getVideoResponseData?.data?[indexPath.item].videoID ?? "")") else {
                  return //be safe
                }
                instaURL = url
            }
            

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(instaURL!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(instaURL!)
            }

        default:
            break
        }
    }

}
extension InstagramPanelViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTextTableViewCell", for: indexPath) as? ContentTextTableViewCell else { return UITableViewCell() }
        self.lblHeaderSynopsis.text = self.viewModel.getVideoResponseData?.data?[contentIndex].videoTitle ?? ""
        cell.configureCell(with: self.viewModel.getVideoResponseData?.data?[contentIndex].summary ?? "")
        return cell
    }
    
    
}
extension InstagramPanelViewController{
    func initCategorys(){
        self.selectCategories.displayName = self.primaryCategory
        self.selectedCategoriesArray.append(self.selectCategories)
        for i in self.instaRequestModel.mainTopic{
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
    func apiCallInstaByKeyword(page: Int){
        self.getVideoRequestModel.currentPage = page
        self.getVideoRequestModel.platform = "instagram"
        self.getVideoRequestModel.primaryCategory = self.primaryCategory
        self.getVideoRequestModel.keywords = self.categories
        self.viewModel.getVideoDataApi(page: page, params: self.getVideoRequestModel) { status, data, message in
            if status == .Success{
                self.InstaThumbnailCollection.reloadData()
            }
        }
    }
    func apiCallInsta(page: Int){

        self.instaRequestModel.currentPage = page
        self.instaRequestModel.platform = "instagram"
        self.viewModel.getTopicsVideoDataApi(page: page, params: self.instaRequestModel, completion: { status, data, message in
            if status == .Success{
                if data?.data?.data?.count == 0{
                    self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                self.InstaThumbnailCollection.reloadData()
                self.categoryCollectionView.reloadData()
            }
        })
    }
    func apiCallInstaSimilar(_ videoId: String, _ pageNo: Int){
        self.similarRequestModel.videoId = videoId
        self.similarViewModel.totalInstaPageNo = pageNo
        self.similarViewModel.getInstaSimilarVideoListAPI(page: pageNo, params: self.similarRequestModel) { status, data, message in
            if status == .Success{
                if data?.data?.data?.count == 0{
                    self.showToast(message: "Sorry..! we don't have the videos for selected category", font: .systemFont(ofSize: 17))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }
                self.InstaThumbnailCollection.reloadData()
            }
        }
    }
}
