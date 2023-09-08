//
//  HomeCategoriesViewController.swift
//  StarMaker
//
//  Created by Raghu on 01/08/23.
//

import UIKit

class HomeCategoriesViewController: BaseVC, UITextFieldDelegate {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var globalTxtField: UITextField!
    var viewModel = HomeTabViewModel()
    var categoryType = ""
    var displayName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        globalTxtField.delegate = self
        globalTxtField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
        self.apiCallCategories()
        self.viewModel.registerCollectionNib(collectionview: categoriesCollectionView) {
            self.categoriesCollectionView.delegate = self
            self.categoriesCollectionView.dataSource = self
            self.categoriesCollectionView.reloadData()
        }
    }
    @IBAction func searchBtnAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "InspirationViewController") as? InspirationViewController
        vc?.searchCategory = true
        vc?.searchText = self.globalTxtField.text ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCallCategories()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        globalTxtField.resignFirstResponder()
        return true
    }
    
}
extension HomeCategoriesViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categoriesModelData?.data?.category?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCategoriesCollectionViewCell", for: indexPath) as? MainCategoriesCollectionViewCell else { return UICollectionViewCell() }
       

        
        cell.cellConfig(self.viewModel.categoriesModelData?.data?.category?[indexPath.item] ?? Category())
     
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoriesCollectionView:
            self.categoryType = self.viewModel.categoriesModelData?.data?.category?[indexPath.item].name ?? ""
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CategoriesDetailViewController") as? CategoriesDetailViewController
            vc?.requestCategories = self.categoryType
            vc?.headerText = self.viewModel.categoriesModelData?.data?.category?[indexPath.item].displayName ?? ""
            vc?.categroyType = self.viewModel.categoriesModelData?.data?.category?[indexPath.item].searchType ?? 0
            vc?.isSubCategory = self.viewModel.categoriesModelData?.data?.category?[indexPath.item].isSubcategory ?? false
            vc?.bannerImage = self.viewModel.categoriesModelData?.data?.category?[indexPath.item].bannerImage ?? ""
            self.navigationController?.pushViewController(vc!, animated: true)
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = categoriesCollectionView.bounds.width / 4
        let screenHeight = screenWidth
        return CGSize(width: screenWidth, height: screenHeight + 13)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25.0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension HomeCategoriesViewController{
    func apiCallCategories(){
        DispatchQueue.main.async {
            self.startSpinnerLoading()
            self.viewModel.apicallCategories { status, data, message in
                if status == .Success{
                    self.categoriesCollectionView.reloadData()
                }
                self.stopSpinnerLoading()
            }
        }
        
    }
    
}
