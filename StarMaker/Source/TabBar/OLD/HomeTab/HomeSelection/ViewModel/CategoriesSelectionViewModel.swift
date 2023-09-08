//
//  CategoriesSelectionViewModel.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import UIKit

class CategoriesSelectionViewModel: NSObject {

//    var subCategoriesLvl:SubCategoriesData?
    var subCategoriesLvl = SubCategoriesModelData()
    var subCatResponseData = SubCategoriesModelData()
    var keywordResponseData: KeywordResponseData?
    var emotionsResponseData: KeywordResponseData?
    var subRequestModel: SubCategoryType?
    var TotalKeywordPageNo = 0
    
    func registerCollectionViewNib(collectionView: UICollectionView,completion: @escaping()->()){
        collectionView.register(UINib(nibName: "SubCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoryCollectionViewCell")
        collectionView.register(UINib(nibName: "DetailSubCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailSubCategoryCollectionViewCell")
        
        completion()
    }
    func apicallSubCategories(params: SubCategoriesRequestModel?,completion: @escaping(_ status: ApiStatus,  _ data: SubCategoriesModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getSubCategories , parameter: params?.dictionary ?? [:], method: .post) { (status: Result<SubCategoriesModel>) in
                     switch status{
                     case .success(data: let data):
                         self.subCategoriesLvl = data.data ?? SubCategoriesModelData()
                         self.subCatResponseData = data.data ?? SubCategoriesModelData()
                         print("sub categoriesssss ===> \(self.subCategoriesLvl)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }
    }
    func apicallEmotionsCategory(page: Int,params: KeywordRequestModel?,completion: @escaping(_ status: ApiStatus,  _ data: KeywordResponseModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getListEmotion , parameter: params?.dictionary ?? [:], method: .post) { (status: Result<KeywordResponseModel>) in
                     switch status{
                     case .success(data: let data):
//                         self.keywordResponseData = data.data
                         if page != 1{
                             self.emotionsResponseData?.keywords?.append(contentsOf: data.data?.keywords ?? [String]())
                         }else{
                             self.emotionsResponseData = data.data
                             self.TotalKeywordPageNo = data.data?.totalPages ?? 1
                         }
//                         print("keywords data ====> \(self.keywordResponseData)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }
    }
    func apicallKeywordCategory(page: Int,params: KeywordRequestModel?,completion: @escaping(_ status: ApiStatus,  _ data: KeywordResponseModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getKeywordsData , parameter: params?.dictionary ?? [:], method: .post) { (status: Result<KeywordResponseModel>) in
                     switch status{
                     case .success(data: let data):
//                         self.keywordResponseData = data.data
                         if page != 1{
                             self.keywordResponseData?.keywords?.append(contentsOf: data.data?.keywords ?? [String]())
                         }else{
                             self.keywordResponseData = data.data
                             self.TotalKeywordPageNo = data.data?.totalPages ?? 1
                         }
//                         print("keywords data ====> \(self.keywordResponseData)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }
    }
}
