//
//  HomeTabViewModel.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import UIKit

class HomeTabViewModel: NSObject {
    
    var categoriesModelData:CategoriesModelData?
    var searchcategoriesData: SearchDataClass?
    var totalPageNo = 1
    var searchTotalPageNo = Int()
    func registerCollectionNib(collectionview: UICollectionView, completion: @escaping()->()){
        
        collectionview.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
      
            collectionview.register(UINib(nibName: "MainCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCategoriesCollectionViewCell")
        
            
        
        completion()
    }
    
    func apicallCategories(completion: @escaping(_ status: ApiStatus,  _ data: CategoriesModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getTaxonomy , parameter: [:], method: .post) { (status: Result<CategoriesModel>) in
                     switch status{
                     case .success(data: let data):
                         self.categoriesModelData = data.data
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }
    }
    func apicallGlobalSearch(pageNO: Int,params: GlobalSearchRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: SearchCategoriesResponseModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.globalSearch , parameter: params.dictionary ?? [:], method: .post) { (status: Result<SearchCategoriesResponseModel>) in
                     switch status{
                     case .success(data: let data):
                         if pageNO != 1{
                             self.searchcategoriesData?.data?.append(contentsOf: data.data?.data ?? [SearchCategoryDatum]())
                         }else{
                             self.searchcategoriesData = data.data
                             self.searchTotalPageNo = data.data?.totalPages ?? 0
                         }
                        
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }
    }
}
