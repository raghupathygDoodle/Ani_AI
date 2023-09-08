////
////  CategorySelectionViewController.swift
////  StarMaker
////
////  Created by Raghu on 14/07/23.
////
//
//import UIKit
//
//class CategorySelectionViewController: BaseVC {
//
////    @IBOutlet weak var viewTopicBG: UIView!
////    @IBOutlet weak var viewKeywordBG: UIView!
//    @IBOutlet weak var labelKeyword: UILabel!
//    @IBOutlet weak var labelTopic: UILabel!
//    @IBOutlet weak var categoryListCollectionView: UICollectionView!
//
//    @IBOutlet weak var categoryDetailsCollectionView: UICollectionView!
//    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
//    @IBOutlet weak var keywordCollectionView: UICollectionView!
//    var categoryModel = Categories()
//    var categoriess = [String]()
//    var categoryType = ""
//    var categories = ["Beauty","Food And Drinks", "Business", "Entertainment" , "Auto(Cars,Trucks,Racing)", "Health And Fitness", "Family And Parenting", "Animals And Pets", "Science And Tech", "Fashion And Lifestyle"]
//    let categoryDetail = ["Routine","Concerns","Treatment","GRWM","Teenage","Hacks/ Tips","Styling","Transformation", "Haul", "Home Remedies/ DIY", "Challenges", "My Go To/Must Have", "Tutorial", "Makeup", "Reviews"]
//    var keywordCategory = ["Routine","Treatment","Concern","Home Remedies/ DIY","Challenges", "My Go To/Must Have","Tutorial"]
//    var selectCategory = 0
//
//    var viewModel = CategoriesSelectionViewModel()
//    var subCategoriesRequestModel = SubCategoriesRequestModel()
//    var keywordRequestModel = KeywordRequestModel()
//
//    var arrData = [String]() // This is your data array
//    var arrSelectedSub1Index = [IndexPath]() // This is selected cell Index array
//    var arrSelectedSub2Index = [IndexPath]()
//    var arrSelectedData = [String]()
//    var arrMainCategory = [String]()
//    var arrSubCategory = [String]()
//    var arrKeyword = [String]()
//    var arrSelectedKeywrdIndex = [IndexPath]()
//    var keywordSelection = false
//    var keywordPageNo = 1
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.showTabBar()
////        self.showTabBar()
////        self.viewKeywordBG.isHidden = true
//        self.keywordCollectionView.isHidden = true
////        self.arrSelectedData.append(self.categoryType)
//
//        categoryListCollectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
//        categoryDetailsCollectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
//        subCategoryCollectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
//        keywordCollectionView.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
//
//        subCategoryCollectionView.layer.cornerRadius = 15
//        categoryDetailsCollectionView.layer.cornerRadius = 15
//        self.keywordCollectionView.layer.cornerRadius = 15
//
//        subCategoryCollectionView.clipsToBounds = true
//        subCategoryCollectionView.allowsMultipleSelection = true
//        keywordCollectionView.allowsMultipleSelection = true
//        self.categoryListCollectionView.delegate = self
//        self.categoryListCollectionView.dataSource = self
//        self.categoryDetailsCollectionView.delegate = self
//        self.categoryDetailsCollectionView.dataSource = self
//        self.subCategoryCollectionView.delegate = self
//        self.subCategoryCollectionView.dataSource = self
//        self.keywordCollectionView.delegate = self
//        self.keywordCollectionView.dataSource = self
//
//        self.categoryListCollectionView.reloadData()
//        self.subCategoryCollectionView.reloadData()
//        self.keywordCollectionView.reloadData()
//        getSubCategoriesApiCall(self.categoryType)
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        getKeywordAPICall(self.categoryType, pageNo: 1)
//
//    }
//    @IBAction func keywordButtonAction(_ sender: UIButton) {
//        self.labelTopic.backgroundColor = .black
//        self.labelKeyword.backgroundColor = .red
//        self.keywordSelection = true
//        self.keywordCollectionView.isHidden = false
////        self.viewKeywordBG.isHidden = false
////        self.viewTopicBG.isHidden = true
//    }
//    @IBAction func inspirationButtonAction(_ sender: UIButton) {
//        guard let dViewController = self.storyboard?.instantiateViewController(withIdentifier: "InspirationViewController") as? InspirationViewController,let thirdTabNavController = self.tabBarController?.viewControllers?[1] as? UINavigationController else {
//          return
//        }
//        self.tabBarController?.selectedIndex = 1
//        // here what you need
//        if keywordSelection{
//                  dViewController.keywordStatus = true
//                  dViewController.primaryCategories = self.categoryType
//                  dViewController.keywordArray = self.arrKeyword
//                  dViewController.categories = self.arrKeyword
//              }else{
//                  dViewController.keywordStatus = false
//                  self.arrSelectedData.insert(self.categoryType, at: 0)
//                  dViewController.categories = self.arrSelectedData
//                  dViewController.mainTopic = self.arrMainCategory
//                  dViewController.subTopic = self.arrSubCategory
//              }
//        thirdTabNavController.pushViewController(dViewController, animated: false)
//
////        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
////        guard let vc = storyBoard.instantiateViewController(withIdentifier: "InspirationViewController") as? InspirationViewController else { return  }
////        if keywordSelection{
////            vc.keywordStatus = true
////            vc.primaryCategories = self.categoryType
////            vc.keywordArray = self.arrKeyword
////            vc.categories = self.arrKeyword
////        }else{
////            vc.keywordStatus = false
////            vc.categories = self.arrSelectedData
////            vc.mainTopic = self.arrMainCategory
////            vc.subTopic = self.arrSubCategory
////        }
////        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func topicButtonAction(_ sender: UIButton) {
//        self.labelTopic.backgroundColor = .red
//        self.labelKeyword.backgroundColor = .black
//        self.keywordCollectionView.isHidden = true
////        self.viewKeywordBG.isHidden = true
////        self.viewTopicBG.isHidden = false
//        self.keywordSelection = false
//    }
//}
//extension CategorySelectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == categoryListCollectionView{
//            return categoriess.count
//        }else if collectionView == subCategoryCollectionView{
//            return self.viewModel.subCategoriesLvl?.subCategory1?.count ?? 0
//        }else if collectionView == categoryDetailsCollectionView{
//            return self.viewModel.subCategoriesLvl?.subCategory2?.count ?? 0
//        }else if collectionView == keywordCollectionView{
//            return self.viewModel.keywordResponseData?.keywords?.count ?? 0
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch collectionView.tag {
//        case 1:
//            guard let cell = categoryListCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else{return UICollectionViewCell()}
//            cell.selectCategoryButton.isHidden = true
//            cell.labelCategoryName.text = categoriess[indexPath.item]
//
//            if indexPath.item == selectCategory{
//                cell.contentView.backgroundColor = .red
//                cell.borderColor = .red
//                cell.borderWidth = 1
//            }else{
//                cell.contentView.backgroundColor = .clear
//                cell.borderColor = .white
//                cell.borderWidth = 1
//            }
//            return cell
//        case 2:
//            guard let cell = subCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else{return UICollectionViewCell()}
//            cell.selectCategoryButton.isHidden = true
//            if arrSelectedSub1Index.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
//                cell.borderColor = .red
//                cell.borderWidth = 1
//                        cell.contentView.backgroundColor = UIColor.red
//                    }
//                    else {
//                        cell.borderColor = .white
//                        cell.borderWidth = 1
//                        cell.contentView.backgroundColor = UIColor.clear
//                    }
//
//                    cell.layoutSubviews()
//            cell.labelCategoryName.text = self.viewModel.subCategoriesLvl?.subCategory1?[indexPath.item]
//            return cell
//        case 3:
//            guard let cell = categoryDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else{return UICollectionViewCell()}
//            cell.selectCategoryButton.isHidden = true
//            if arrSelectedSub2Index.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
//                cell.borderColor = .red
//                cell.borderWidth = 1
//                        cell.contentView.backgroundColor = UIColor.red
//                    }
//                    else {
//                        cell.borderColor = .white
//                        cell.borderWidth = 1
//                        cell.contentView.backgroundColor = UIColor.clear
//                    }
//            cell.labelCategoryName.text = self.viewModel.subCategoriesLvl?.subCategory2?[indexPath.item]
//
//            return cell
//        case 4:
//            guard let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else{return UICollectionViewCell()}
//            cell.selectCategoryButton.isHidden = true
//            if arrSelectedKeywrdIndex.contains(indexPath) { // You need to check wether selected index array contain current index if yes then change the color
//                cell.borderColor = .red
//                cell.borderWidth = 1
//                        cell.contentView.backgroundColor = UIColor.red
//                    }
//                    else {
//                        cell.borderColor = .white
//                        cell.borderWidth = 1
//                        cell.contentView.backgroundColor = UIColor.clear
//                    }
//            cell.labelCategoryName.text = self.viewModel.keywordResponseData?.keywords?[indexPath.item] ?? ""
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//
//
//    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if collectionView == keywordCollectionView{
//            if indexPath.item + 1 == viewModel.keywordResponseData?.keywords?.count{
//                debugPrint("You reached end of Notification and lastPage indexPath.row = \(indexPath.row) ")
//                if keywordPageNo < self.viewModel.TotalKeywordPageNo{
//                    keywordPageNo += 1
//                    self.getKeywordAPICall(self.categoryType, pageNo: keywordPageNo)
//                }
//            }
//        }
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == categoryListCollectionView{
//            return CGSize(width: (categoriess[indexPath.item].size(withAttributes: nil).width ) + 60, height: 40)
//        }else if collectionView == subCategoryCollectionView{
//            return CGSize(width: (self.viewModel.subCategoriesLvl?.subCategory1?[indexPath.item].size(withAttributes: nil).width ?? 0) + 50
//                            , height: 40)
//        }else if collectionView == categoryDetailsCollectionView{
//            return CGSize(width: (self.viewModel.subCategoriesLvl?.subCategory2?[indexPath.item].size(withAttributes: nil).width ?? 0) + 60, height: 40)
//        }else if collectionView == keywordCollectionView{
//            return CGSize(width: (self.viewModel.keywordResponseData?.keywords?[indexPath.item].size(withAttributes: nil).width ?? 0) + 65, height: 40)
//        }
//        return CGSize(width: 0, height: 0)
//       }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if collectionView == subCategoryCollectionView{
//            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        }else if collectionView == categoryDetailsCollectionView{
//            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        }else if collectionView == keywordCollectionView{
//            return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        }
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == categoryListCollectionView{
//
//            if keywordSelection{
//                self.arrKeyword.removeAll()
//            }else{
//                self.arrSelectedData.removeAll()
//                self.arrMainCategory.removeAll()
//                self.arrSubCategory.removeAll()
//            }
//            categoryType = self.categoriess[indexPath.item]
//            self.selectCategory = indexPath.item
//            self.getSubCategoriesApiCall(categoryType)
//            self.getKeywordAPICall(categoryType, pageNo: 1)
//            self.categoryListCollectionView.reloadData()
//            self.subCategoryCollectionView.reloadData()
//            self.keywordCollectionView.reloadData()
//            self.keywordCollectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
//            self.categoryDetailsCollectionView.reloadData()
//        }
//        if collectionView == subCategoryCollectionView{
//
//            let strData = self.viewModel.subCategoriesLvl?.subCategory1?[indexPath.item]
//
//                   if arrSelectedSub1Index.contains(indexPath) {
//                       arrMainCategory = arrMainCategory.filter { $0 != strData}
//                       arrSelectedSub1Index = arrSelectedSub1Index.filter { $0 != indexPath}
//                       arrSelectedData = arrSelectedData.filter { $0 != strData}
//                   }
//                   else {
//                       arrSelectedSub1Index.append(indexPath)
//                       arrSelectedData.append(strData ?? "")
//                       arrMainCategory.append(strData ?? "")
//                   }
//
//                   subCategoryCollectionView.reloadData()
//        }else if collectionView == categoryDetailsCollectionView{
//            let strData = self.viewModel.subCategoriesLvl?.subCategory2?[indexPath.item]
//
//                   if arrSelectedSub2Index.contains(indexPath) {
//                       arrSelectedSub2Index = arrSelectedSub2Index.filter { $0 != indexPath}
//                       arrSelectedData = arrSelectedData.filter { $0 != strData}
//                       arrSubCategory = arrSubCategory.filter{ $0 != strData }
//                   }
//                   else {
//                       arrSelectedSub2Index.append(indexPath)
//                       arrSelectedData.append(strData ?? "")
//                       arrSubCategory.append(strData ?? "")
//                   }
//
//                   categoryDetailsCollectionView.reloadData()
//        }else if collectionView == keywordCollectionView{
//            let strData = self.viewModel.keywordResponseData?.keywords?[indexPath.item]
//            if arrSelectedKeywrdIndex.contains(indexPath){
//                arrSelectedKeywrdIndex = arrSelectedKeywrdIndex.filter { $0 != indexPath}
//                arrKeyword = arrKeyword.filter{ $0 != strData}
//            }else{
//                arrSelectedKeywrdIndex.append(indexPath)
//                arrKeyword.append(strData ?? "")
//            }
//            keywordCollectionView.reloadData()
//        }
//
//           }
//
//}
//extension CategorySelectionViewController{
//    func getSubCategoriesApiCall(_ category: String){
//        self.subCategoriesRequestModel.category = category
//        DispatchQueue.main.async {
//            self.viewModel.apicallSubCategories(params: self.subCategoriesRequestModel) { status, data, message in
//                if status == .Success{
//                    print("Successss")
//                    self.categoryListCollectionView.reloadData()
//                    self.subCategoryCollectionView.reloadData()
//                    self.categoryDetailsCollectionView.reloadData()
//                    self.keywordCollectionView.reloadData()
//                    self.scrollToIndex(self.selectCategory, self.categoryListCollectionView)
//                }
//            }
//        }
//    }
//    func getKeywordAPICall(_ category: String,pageNo: Int){
//        self.keywordRequestModel.category = category
//        self.keywordRequestModel.currentPage = pageNo
//        DispatchQueue.main.async {
//            self.viewModel.apicallKeywordCategory(page: pageNo, params: self.keywordRequestModel, completion: { status, data, message in
//                if status == .Success{
//                    if category != self.categoryType{
//                        self.viewModel.keywordResponseData = data?.data
//                        self.keywordCollectionView.reloadData()
//                    }
//                    self.keywordCollectionView.reloadData()
//                    print("Keyword api hitted -----> \(self.viewModel.keywordResponseData?.keywords)")
//                }
//            })
//        }
//    }
//    func scrollToIndex(_ index: Int,_ collectionVIew: UICollectionView) {
//            // Ensure that the index is within the valid range of items in the collection view
//        guard index >= 0, index < self.categoriess.count else {
//                return
//            }
//
//            // Create an index path with the desired index
//            let indexPath = IndexPath(item: index, section: 0)
//
//            // Scroll the collection view to the desired index with animation
//        collectionVIew.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
//}
