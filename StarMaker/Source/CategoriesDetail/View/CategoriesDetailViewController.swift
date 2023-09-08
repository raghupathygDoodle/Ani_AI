//
//  CategoriesDetailViewController.swift
//  StarMaker
//
//  Created by Raghu on 02/08/23.
//

import UIKit

class CategoriesDetailViewController: UIViewController {
    
    @IBOutlet weak var subCategoryHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewSelectType: UIView!
    @IBOutlet weak var imageHeaderBanner: UIImageView!
    @IBOutlet weak var subCategoryCollectionview: UICollectionView!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet weak var detailSubCateCollectionView: UICollectionView!
    @IBOutlet weak var lblKeyword: UILabel!
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var labelHeaderDescption: UILabel!
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var viewTopic: UIView!
    @IBOutlet weak var viewKeyword: UIView!
    var isSubCategory = false
    var bgSelect = UIColor()
    var bgUnselect = UIColor()
    var selectedSubCategory = Int()
    var requestCategories = ""
    var headerText = ""
    var bannerImage = ""
    var viewModel = CategoriesSelectionViewModel()
    var requestSubCategory = SubCategoriesRequestModel()
    
    var topicRequest = TopicVideoRequestModel()
    var topicRequestArray = [TopicVideoRequestModel]()
    
    var subType = false
    var detailType = false
    var videoRequest = SubCategoryType()    
 var arrayVideoReq = [SubCategoryType]()
    var arraySubType = SubCategoriesRequest()
    var subCategoryTwo = [SubCatTwoData]()
    var subCatIndex = -1
    
    var subCategoryRequest = GetVideoDataRequestModel()
    var subCategories = SubCategoryType()
    
    var keywordRequestModel = KeywordRequestModel()
    var emotionRequestModel = KeywordRequestModel()
    var keywordPageNo = 1
    var emotionPageNo = 1
    
    var arrSelectedIndex = [IndexPath]() // This is selected cell Index array
    var arrSelectedData = [String]() // This is selected cell data array
    var arrDetailsData = [String]()
    
    var arrMainCategory = [String]()
    var arrSubCategory = [String]()
    var arrSelectedSub2Index = [IndexPath]()
    
    
    var arrKeyword = [String]()
    var arrSelectedKeywrdIndex = [IndexPath]()
    
    var arrEmotions = [String]()
    var arrSelectedEmotionIndex = [IndexPath]()
    var categroyType = 0
    
    var keywordSelection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI(self.requestCategories)
        print("boold value ==> \(isSubCategory)")
        
        if categroyType == 0{
            self.lblTopic.text = "Topics"
            self.subCategoryCollectionview.isHidden = false
        }else if categroyType == 1{
            self.lblTopic.text = "Tones"
            self.subCategoryCollectionview.isHidden = true
        }else if categroyType == 2{
            self.viewTopic.isHidden = true
            self.keywordCollectionView.isHidden = false
            self.subCategoryCollectionview.isHidden = true
        }
        self.keywordCollectionView.isHidden = true
        getSubCategoriesAPICALL(self.requestCategories,pageNo: 1)
        getKeywordAPICall(self.requestCategories, pageNo: 1)
        if let urlString = self.bannerImage.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString) {
              
                self.imageHeaderBanner.sd_setImage(with: url)
                }
            }
        self.setUI()
        self.viewModel.registerCollectionViewNib(collectionView: self.subCategoryCollectionview) {
            self.subCategoryCollectionview.delegate = self
            self.subCategoryCollectionview.dataSource = self
            self.subCategoryCollectionview.reloadData()
        }
        self.viewModel.registerCollectionViewNib(collectionView: self.detailSubCateCollectionView) {
            self.detailSubCateCollectionView.delegate = self
            self.detailSubCateCollectionView.dataSource = self
            self.detailSubCateCollectionView.reloadData()
        }
        self.viewModel.registerCollectionViewNib(collectionView: self.keywordCollectionView) {
            self.keywordCollectionView.delegate = self
            self.keywordCollectionView.dataSource = self
            self.keywordCollectionView.reloadData()
        }
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .right
        self.keywordCollectionView.addGestureRecognizer(swipeLeft)
        let swipesLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .right
        self.detailSubCateCollectionView.addGestureRecognizer(swipesLeft)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func KeywordButtonAction(_ sender: UIButton) {
        self.keywordSelection = true
        self.categroyType = 2
        self.arrDetailsData.removeAll()
        self.arrMainCategory.removeAll()
        self.arrSelectedIndex.removeAll()
        self.arrSelectedSub2Index.removeAll()
        self.arrSubCategory.removeAll()
        self.keywordCollectionView.isHidden = false
        self.lblTopic.backgroundColor = .white
        self.lblKeyword.backgroundColor = bgSelect
        self.lblTopic.textColor = bgSelect
        self.lblKeyword.textColor = .white
        self.subCategoryCollectionview.reloadData()
        self.detailSubCateCollectionView.reloadData()
    }
    @IBAction func topicButtonAction(_ sender: UIButton) {
        self.keywordSelection = false
        self.arrKeyword.removeAll()
        self.arrSelectedKeywrdIndex.removeAll()
        self.keywordCollectionView.isHidden = true
        self.lblTopic.backgroundColor = bgSelect
        self.lblKeyword.backgroundColor = .white
        self.lblTopic.textColor = .white
        self.lblKeyword.textColor = bgSelect
        self.keywordCollectionView.reloadData()
    }
    func setUI(){
        if categroyType == 0 || categroyType == 1{
            self.labelHeader.text = self.headerText
            self.lblKeyword.textColor = self.bgSelect
            self.lblTopic.textColor = UIColor.white
            self.lblTopic.backgroundColor = self.bgSelect
            self.lblKeyword.backgroundColor = UIColor.white
            self.viewSelectType.borderColor = self.bgSelect
        }else{
            self.keywordSelection = true
            self.labelHeader.text = self.headerText
            self.detailSubCateCollectionView.isHidden = true
            self.keywordCollectionView.isHidden = false
            self.lblKeyword.textColor = .white
            self.viewKeyword.backgroundColor = .clear
            self.viewSelectType.backgroundColor = self.bgSelect
            self.lblKeyword.backgroundColor = self.bgSelect
            self.viewSelectType.borderColor = self.bgSelect
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func inspirationBtnAction(_ sender: UIButton) {
//
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                guard let vc = storyBoard.instantiateViewController(withIdentifier: "InspirationViewController") as? InspirationViewController else { return  }
        vc.isSubCategory = self.isSubCategory
                if keywordSelection || categroyType == 2{
                    vc.keywordStatus = true
                    vc.primaryCategories = self.requestCategories
                    vc.keywordArray = self.arrKeyword
                    vc.categories = self.arrKeyword
                    vc.categoryType = categroyType
                }else{
                    if categroyType == 0{
                        self.topicRequest.primaryCategory = self.requestCategories
                        self.topicRequest.mainTopic.removeAll()
                        for i in 0..<subCategoryRequest.mainTopic.count{
                            var categoryTwo = [String]()
                            for j in subCategoryRequest.mainTopic[i].subCatTwo{
                                if j.isSelect == true{
                                    categoryTwo.append(j.subCategoryTwo)
                                }
                            }
                            var subCatOne = TopicSubCategoryType()
                            subCatOne.subCatOne = subCategoryRequest.mainTopic[i].subCatOne
                            subCatOne.subCatTwo = categoryTwo
                            self.topicRequest.mainTopic.append(subCatOne)
                        }
                        let encoder = JSONEncoder()
                              encoder.outputFormatting = .prettyPrinted // For pretty-printed JSON
                      
                              do {
                                  let jsonData = try encoder.encode(self.topicRequest)
                      
                                  if let jsonString = String(data: jsonData, encoding: .utf8) {
                                      print(jsonString)
                                  }
                              } catch {
                                  print("Error encoding to JSON: \(error)")
                              }
                        
                        
                        vc.videoRequestModel = self.topicRequest
                        vc.getVideoRequestModel = self.subCategoryRequest
                        vc.primaryCategories = self.requestCategories
                        print("jkladfkljlkasfjlk === > \(vc.getVideoRequestModel)")
                        vc.categoryType = categroyType
                        vc.isSubCategory = true
                        vc.mainTopic = self.arrMainCategory
                        vc.subTopic = self.arrSubCategory
                        self.arrSelectedData.insert(self.requestCategories, at: 0)
                        vc.categories.insert(self.requestCategories, at: 0)

                    }else if categroyType == 1{
                        vc.categoryType = categroyType
                        vc.isSubCategory = false
                        vc.primaryCategories = self.requestCategories
                        vc.emotionArray = self.arrEmotions
                        self.arrEmotions.insert(self.headerText, at: 0)
                        vc.categories = self.arrEmotions
                    }

                }
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension CategoriesDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case subCategoryCollectionview:
            return self.viewModel.subCategoriesLvl.data?.count ?? 0
        case detailSubCateCollectionView:
            if categroyType == 0{
                if subType{
                    return self.subCategoryTwo.count
                }else{
                    return 0
                }
                
            }else{
                return self.viewModel.emotionsResponseData?.keywords?.count ?? 0
            }
           
        case keywordCollectionView:
            return self.viewModel.keywordResponseData?.keywords?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case subCategoryCollectionview:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewCell", for: indexPath) as? SubCategoryCollectionViewCell else { return UICollectionViewCell() }

            let data = self.viewModel.subCategoriesLvl.data?[indexPath.item]
            if data?.isOpen == true && data?.isSelected == true{
                cell.imageTick.backgroundColor = bgSelect
                cell.viewTick.backgroundColor = .white
                cell.backgroudsView.backgroundColor = bgSelect
            }else if data?.isOpen == false && data?.isSelected == true{
                cell.backgroudsView.backgroundColor = bgSelect
                cell.imageTick.backgroundColor = .clear
                cell.viewTick.backgroundColor = .clear
            }else{
                cell.layoutSubviews()
                cell.imageTick.backgroundColor = .clear
                cell.viewTick.backgroundColor = .clear
                cell.backgroudsView.backgroundColor = bgUnselect
                
            }
            cell.cellConfig(self.viewModel.subCategoriesLvl.data?[indexPath.item] ?? SubCategoriesData())
            return cell
        case detailSubCateCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailSubCategoryCollectionViewCell", for: indexPath) as? DetailSubCategoryCollectionViewCell else { return UICollectionViewCell() }
            if categroyType == 0{

                if subType{
           
                    if subCategoryTwo[indexPath.item].isSelect == true{
                        cell.viewDescriptionBG.backgroundColor = bgSelect
                        cell.lblCategory.textColor = .white
                    }else{
                        cell.viewDescriptionBG.backgroundColor = bgUnselect
                                          cell.lblCategory.textColor = Constants.Color.subTextColor
                    }
                    
                    cell.lblCategory.text =  self.subCategoryTwo[indexPath.item].subCategoryTwo
                    }else{
                        cell.viewDescriptionBG.backgroundColor = bgUnselect
                                          cell.lblCategory.textColor = Constants.Color.subTextColor
                    }
                
            }else{
                if arrSelectedEmotionIndex.contains(indexPath){
                    cell.viewDescriptionBG.backgroundColor = bgSelect
                    cell.lblCategory.textColor = .white
                }else{
                    cell.viewDescriptionBG.backgroundColor = bgUnselect
                    cell.lblCategory.textColor = bgSelect

                }
                cell.lblCategory.text = self.viewModel.emotionsResponseData?.keywords?[indexPath.item]
            }
           
            return cell
        case keywordCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailSubCategoryCollectionViewCell", for: indexPath) as? DetailSubCategoryCollectionViewCell else { return UICollectionViewCell() }
            if arrSelectedKeywrdIndex.contains(indexPath){
                cell.viewDescriptionBG.backgroundColor = bgSelect
                cell.lblCategory.textColor = .white
            }else{
                cell.viewDescriptionBG.backgroundColor = bgUnselect
                cell.lblCategory.textColor = Constants.Color.subTextColor
            }
            cell.lblCategory.text = self.viewModel.keywordResponseData?.keywords?[indexPath.item]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case detailSubCateCollectionView:
            if categroyType != 0{
                if indexPath.item + 1 == viewModel.emotionsResponseData?.keywords?.count{
                    debugPrint("You reached end of Notification and lastPage indexPath.row = \(indexPath.row) ")
                    if emotionPageNo < self.viewModel.TotalKeywordPageNo{
                        emotionPageNo += 1
                        self.getSubCategoriesAPICALL(self.requestCategories, pageNo: emotionPageNo)
                    }
                }
            }
            
        case keywordCollectionView:
            if indexPath.item + 1 == viewModel.keywordResponseData?.keywords?.count{
                debugPrint("You reached end of Notification and lastPage indexPath.row = \(indexPath.row) ")
                if keywordPageNo < self.viewModel.TotalKeywordPageNo{
                    keywordPageNo += 1
                    self.getKeywordAPICall(self.requestCategories, pageNo: keywordPageNo)
                }
            }
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case subCategoryCollectionview:
            print("selected index ===> \(self.viewModel.subCategoriesLvl.data?[indexPath.item].subcategory1)")
            
            let subCatString = self.viewModel.subCategoriesLvl.data?[indexPath.item].subcategory1
            var data = self.viewModel.subCategoriesLvl.data?[indexPath.item]
            if subCatIndex != -1 && subCatIndex != indexPath.item{
                self.viewModel.subCategoriesLvl.data?[self.subCatIndex].isOpen = false
               
            }
            if data?.isOpen == true && data?.isSelected == true{
                self.subCatIndex = -1
                self.subType = false
                self.viewModel.subCategoriesLvl.data?[indexPath.item].isOpen = false
                self.viewModel.subCategoriesLvl.data?[indexPath.item].isSelected = false
                print("main topic data count ===> \(self.subCategoryRequest.mainTopic.count)")
                for i in 0..<self.subCategoryRequest.mainTopic.count{
                    print("dataaaa ===>\(i)")
                    if self.subCategoryRequest.mainTopic[i].subCatOne == subCatString{
                        self.subCategoryRequest.mainTopic.remove(at: i)
                        break
                    }
                }
                print("printeddd ====> \(self.subCategoryRequest.mainTopic)")
                self.subCategoryCollectionview.reloadData()
            }else if data?.isOpen != true && data?.isSelected != true{
                self.subType = true
                self.subCatIndex = indexPath.item
                self.viewModel.subCategoriesLvl.data?[indexPath.item].isOpen = true
                self.viewModel.subCategoriesLvl.data?[indexPath.item].isSelected = true
                var tempSubCatTwo = [SubCatTwoData]()
                for i in self.viewModel.subCategoriesLvl.data?[indexPath.item].subCategory2 ?? [""]{
                    var tempSubCat = SubCatTwoData()
                    tempSubCat.subCategoryTwo = i
                    tempSubCatTwo.append(tempSubCat)
                }
                
                self.subCategories.subCatOne = subCatString ?? ""
                self.subCategories.subCatTwo = tempSubCatTwo
                self.subCategoryRequest.mainTopic.append(self.subCategories)
                print("printeddd ====> \(self.subCategoryRequest.mainTopic)")
                
                
                
            }else if data?.isOpen == false && data?.isSelected == true{
                print("value duplicated")
                self.subType = true
                self.subCatIndex = indexPath.item
                self.viewModel.subCategoriesLvl.data?[indexPath.item].isOpen = true
            }
            self.initSubCategoryTwo()
            self.subCategoryCollectionview.reloadData()
            self.detailSubCateCollectionView.reloadData()
        case detailSubCateCollectionView:
         
            if categroyType == 0{
                
                self.subCategoryTwo[indexPath.item].isSelect = !self.subCategoryTwo[indexPath.item].isSelect
                if self.subCatIndex != -1{
                    var openedIndex = -1
                    for i in 0..<self.subCategoryRequest.mainTopic.count{
                        if self.subCategoryRequest.mainTopic[i].subCatOne == self.viewModel.subCategoriesLvl.data?[self.subCatIndex].subcategory1{
                            openedIndex = i
                            break
                        }
                    }
                    if openedIndex != -1{
                        self.subCategoryRequest.mainTopic[openedIndex].subCatTwo[indexPath.item].isSelect = self.subCategoryTwo[indexPath.item].isSelect
                    }
                }
                subCategoryCollectionview.reloadData()
                detailSubCateCollectionView.reloadData()
            }else{
                let strData = self.viewModel.emotionsResponseData?.keywords?[indexPath.item]
                if arrSelectedEmotionIndex.contains(indexPath){
                    arrSelectedEmotionIndex = arrSelectedEmotionIndex.filter { $0 != indexPath}
                    arrEmotions = arrEmotions.filter{ $0 != strData}
                }else{
                    arrSelectedEmotionIndex.append(indexPath)
                    arrEmotions.append(strData ?? "")
                }
                detailSubCateCollectionView.reloadData()
            }
            
        case keywordCollectionView:
            let strData = self.viewModel.keywordResponseData?.keywords?[indexPath.item]
            if arrSelectedKeywrdIndex.contains(indexPath){
                arrSelectedKeywrdIndex = arrSelectedKeywrdIndex.filter { $0 != indexPath}
                arrKeyword = arrKeyword.filter{ $0 != strData}
            }else{
                arrSelectedKeywrdIndex.append(indexPath)
                arrKeyword.append(strData ?? "")
            }
            keywordCollectionView.reloadData()
        
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case subCategoryCollectionview:
            let screenWidth = subCategoryCollectionview.bounds.width / 4
            let screenHeight = subCategoryCollectionview.bounds.height
            return CGSize(width: screenWidth, height: screenHeight)
        case detailSubCateCollectionView:
            let screenWidth = detailSubCateCollectionView.bounds.width / 3
            let screenHeight = screenWidth - 65
            return CGSize(width: screenWidth - 15 , height: screenHeight)
        case keywordCollectionView:
            let screenWidth = keywordCollectionView.bounds.width / 3
            let screenHeight = screenWidth - 65
            return CGSize(width: screenWidth - 14 , height: screenHeight)
        default:
            return CGSize(width: 0, height: 0 )
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case subCategoryCollectionview:
            return 0
        case detailSubCateCollectionView:
            return 8
        case keywordCollectionView:
            return 8
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case subCategoryCollectionview:
            return 0
        case detailSubCateCollectionView:
            return 4
        case keywordCollectionView:
            return 4
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case subCategoryCollectionview:
            if self.viewModel.subCategoriesLvl.data?.count ?? 0 == 2{
                let totalCellWidth = 0 * collectionView.numberOfItems(inSection: 0)
                let totalSpacingWidth = 0 * (collectionView.numberOfItems(inSection: 0) - 1)

                let leftInset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 4
                let rightInset = leftInset

                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            }else if self.viewModel.subCategoriesLvl.data?.count ?? 0 == 3{
                let totalCellWidth = 0 * collectionView.numberOfItems(inSection: 0)
                let totalSpacingWidth = 0 * (collectionView.numberOfItems(inSection: 0) - 1)

                let leftInset = (collectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 6
                let rightInset = leftInset

                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
            }else{
                return UIEdgeInsets.zero
            }
            
        case detailSubCateCollectionView:
            return UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        case keywordCollectionView:
            return UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        default:
            return UIEdgeInsets.zero
        }
    }
    func initSubCatoryTwo(){
        self.arrDetailsData.removeAll()
        let temp = self.viewModel.subCategoriesLvl.data?.filter{$0.isSelected == true}
        for i in (temp ?? [SubCategoriesData]()).reversed(){
            self.arrDetailsData.append(contentsOf: i.subCategory2 ?? [String]())
        }
        self.detailSubCateCollectionView.reloadData()
    }
}
extension CategoriesDetailViewController{
    func getSubCategoriesAPICALL(_ category: String,pageNo: Int){
        if categroyType == 0{
            self.requestSubCategory.category = category
            self.viewModel.apicallSubCategories(params: requestSubCategory) { status, data, message in
                if status == .Success{
                    
                    self.subCategoryCollectionview.reloadData()
                    self.detailSubCateCollectionView.reloadData()
                    
                    for i in 0..<(self.viewModel.subCategoriesLvl.data?.count ?? 0){
                        self.viewModel.subCategoriesLvl.data?[i].isOpen = false
                        self.viewModel.subCategoriesLvl.data?[i].isSelected = false
                    }
                }
            }
        }else{
            self.emotionRequestModel.category = category
            self.emotionRequestModel.currentPage = pageNo
            DispatchQueue.main.async {
                self.viewModel.apicallEmotionsCategory(page: pageNo, params: self.emotionRequestModel, completion: { status, data, message in
                    if status == .Success{
                        if category != self.requestCategories{
                            self.arrDetailsData = data?.data?.keywords ?? [String]()
                            self.viewModel.emotionsResponseData = data?.data
                            self.detailSubCateCollectionView.reloadData()
                        }
                        self.detailSubCateCollectionView.reloadData()
                    }
                })
            }
        }
      
    }
    func getKeywordAPICall(_ category: String,pageNo: Int){
        self.keywordRequestModel.category = category
        self.keywordRequestModel.currentPage = pageNo
        DispatchQueue.main.async {
            self.viewModel.apicallKeywordCategory(page: pageNo, params: self.keywordRequestModel, completion: { status, data, message in
                if status == .Success{
                    if category != self.requestCategories{
                        self.viewModel.keywordResponseData = data?.data
                        self.keywordCollectionView.reloadData()
                    }
                    self.keywordCollectionView.reloadData()
                }
            })
        }
    }
    func updateUI(_ categoryColor: String){
        switch categoryColor {
        case Constants.Category.beauty:
            self.bgSelect = Constants.Color.beautyColor ?? UIColor.white
            self.bgUnselect = Constants.Color.beautyUnselect ?? UIColor.gray
        case Constants.Category.fashion:
            self.bgSelect = Constants.Color.fashionStlSD ?? UIColor.white
            self.bgUnselect = Constants.Color.fashionStlDSD ?? UIColor.gray
        case Constants.Category.familyPrnt:
            self.bgSelect = Constants.Color.familyPrntSD ?? UIColor.white
            self.bgUnselect = Constants.Color.familyPrntDSD ?? UIColor.gray
        case Constants.Category.businessFin:
            self.bgSelect = Constants.Color.businessSD ?? UIColor.white
            self.bgUnselect = Constants.Color.businessDSD ?? UIColor.gray
        case Constants.Category.carVehicle:
            self.bgSelect = Constants.Color.automativeSD ?? UIColor.white
            self.bgUnselect = Constants.Color.automativeDSD ?? UIColor.gray
        case Constants.Category.scienceTech:
            self.bgSelect = Constants.Color.scienceTechSD ?? UIColor.white
            self.bgUnselect = Constants.Color.scienceTechDSD ?? UIColor.gray
        case Constants.Category.foodDrink:
            self.bgSelect = Constants.Color.foodDrinkSD ?? UIColor.white
            self.bgUnselect = Constants.Color.foodDrinkDSD ?? UIColor.gray
        case Constants.Category.animalPets:
            self.bgSelect = Constants.Color.animalPetsSD ?? UIColor.white
            self.bgUnselect = Constants.Color.animalPetsDSD ?? UIColor.gray
        case Constants.Category.healthFitness:
            self.bgSelect = Constants.Color.healthFtnSD ?? UIColor.white
            self.bgUnselect = Constants.Color.healthFtnDSD ?? UIColor.gray            
        case Constants.Category.entertainment:
            self.bgSelect = Constants.Color.entertainmentSD ?? UIColor.white
            self.bgUnselect = Constants.Color.entertainmentDSD ?? UIColor.gray
        case Constants.Category.home:
            self.bgSelect = Constants.Color.homeSD ?? UIColor.white
//
            self.bgUnselect = Constants.Color.homeDSD ?? UIColor.gray
//
        case Constants.Category.people:
            self.bgSelect = Constants.Color.peopleSD ?? UIColor.white
            
            self.bgUnselect = Constants.Color.peopleDSD ?? UIColor.gray
          
        case Constants.Category.games:
            self.bgSelect = Constants.Color.gamingSD ?? UIColor.white
           
            self.bgUnselect = Constants.Color.gamingDSD ?? UIColor.gray
           
        case Constants.Category.sports:
            self.bgSelect = Constants.Color.sportSD ?? UIColor.white
          
            self.bgUnselect = Constants.Color.sportDSD ?? UIColor.gray
           
        case Constants.Category.kids:
            self.bgSelect = Constants.Color.kidSD ?? UIColor.white
          
            self.bgUnselect = Constants.Color.kidDSD ?? UIColor.gray
          
        case Constants.Category.education:
            self.bgSelect = Constants.Color.educationSD ?? UIColor.white
         
            self.bgUnselect = Constants.Color.educationDSD ?? UIColor.gray
          
        case Constants.Category.travel:
            self.bgSelect = Constants.Color.travelSD ?? UIColor.white
          
            self.bgUnselect = Constants.Color.travelDSD ?? UIColor.gray
          
        case Constants.Category.music:
            self.bgSelect = Constants.Color.musicSD ?? UIColor.white
            self.bgUnselect = Constants.Color.musicDSD ?? UIColor.gray
        case Constants.Category.movie:
            self.bgSelect = Constants.Color.movieSD ?? UIColor.white
         
            self.bgUnselect = Constants.Color.movieDSD ?? UIColor.gray
            
        default:
            
            self.bgSelect = UIColor.white
            self.bgUnselect = UIColor.gray
        }
      
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                
                self.navigationController?.popViewController(animated: true)
                print("Swiped right")
            case .down:
               
                print("Swiped down")
            case .left:
               
                print("Swiped left")
            case .up:
               
                print("Swiped up")
            default:
                break
            }
        }
    }
    func initSubCategoryTwo(){
        self.subCategoryTwo.removeAll()
        if self.subCatIndex != -1{
            var openedIndex = -1
            for i in 0..<self.subCategoryRequest.mainTopic.count{
                if subCategoryRequest.mainTopic[i].subCatOne == self.viewModel.subCategoriesLvl.data?[self.subCatIndex].subcategory1{
                    openedIndex = i
                    break
                }
            }
            if openedIndex != -1{
                for i in self.subCategoryRequest.mainTopic[openedIndex].subCatTwo{
                    var tempSubCatTwo = SubCatTwoData()
                    tempSubCatTwo.subCategoryTwo = i.subCategoryTwo
                    tempSubCatTwo.isSelect = i.isSelect
                    self.subCategoryTwo.append(tempSubCatTwo)
                    
                }
            }
        }
        print("printed value in subcategory ===> \(self.subCategoryRequest)")
    }
}
