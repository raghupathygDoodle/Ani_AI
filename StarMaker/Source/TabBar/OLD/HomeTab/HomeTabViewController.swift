////
////  HomeTabViewController.swift
////  StarMaker
////
////  Created by Raghu on 13/07/23.
////
//
//import UIKit
//
//class HomeTabViewController: BaseVC {
//    
//    @IBOutlet weak var categoryListCollectionView: UICollectionView!
//    var categoriesModel: Categories?
//    var categoriesList: [CategoryList]?
//    var collectionString: String?
//    var ur = [String]()
//    var subCategories = [Subcategory]()
//    var totalCollection = [String]()
//    var selectedCategory = 0
//    var viewModel = HomeTabViewModel()
//    let categoryList = ["Beauty","Food And Drinks", "Business", "Entertainment" , "Auto(Cars,Trucks,Racing)", "Health And Fitness", "Family And Parenting", "Animals And Pets", "Science And Tech", "Fashion And Lifestyle"]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        apiCall()
//        
//        self.viewModel.registerCollectionNib(collectionview: categoryListCollectionView) {
//            self.categoryListCollectionView.delegate = self
//            self.categoryListCollectionView.dataSource = self
//            self.categoryListCollectionView.reloadData()
//        }
//       
//      
//        // Do any additional setup after loading the view.
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
////        self.showTabBar()
//        apiCall()
//        
//    }
//
//    @IBAction func seeInspirationButtonAction(_ sender: UIButton) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "InspirationViewController") as? InspirationViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
//}
//extension HomeTabViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.viewModel.categoriesModelData?.data?.category?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryListCollectionViewCell", for: indexPath) as? CategoryListCollectionViewCell else{
//            return UICollectionViewCell()
//        }
//        cell.selectCategoryButton.tag = indexPath.item
//        cell.closureSelectCategory = { [unowned self] index in
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "CategorySelectionViewController") as? CategorySelectionViewController
////            vc?.categoriess = self.viewModel.categoriesModelData?.data?.category
//            vc?.selectCategory = index
//            vc?.categoryType = cell.labelCategoryName.text ?? ""
//            self.navigationController?.pushViewController(vc!, animated: true)
//        }
//        cell.labelCategoryName.text = self.viewModel.categoriesModelData?.data?.category?[indexPath.item].name
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedCategory = indexPath.item
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (self.viewModel.categoriesModelData?.data?.category?[indexPath.item].name?.size(withAttributes: nil).width ?? 0) + 65
//                        , height: 38)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 6
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
//    }
//        func apiCall(){
//            DispatchQueue.main.async {
//                self.viewModel.apicallCategories { status, data, message in
//                    if status == .Success{
//                        print(" API call  hitted successs  \(self.viewModel.categoriesModelData)")
//                        self.categoryListCollectionView.reloadData()
//                    }
//                }
//            }
//
//    }
//}
