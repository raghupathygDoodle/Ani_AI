//
//  InspirationViewModel.swift
//  StarMaker
//
//  Created by Raghu on 18/07/23.
//

import UIKit

class InspirationViewModel: NSObject {

    var getVideoResponseData: GetVideoResponseData?
    var getInstaVideoResponseData: CategoriesResponseModel?
    var TotalVideoPageNo = 1
    var pageNo = 1
    var totalInstaPage = Int()
    func registerCollectionViewNib(collectionview: UICollectionView,completion: @escaping()->()){
        collectionview.register(UINib(nibName: "TextContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TextContentCollectionViewCell")
        collectionview.register(UINib(nibName: "CategoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryListCollectionViewCell")
        collectionview.register(UINib(nibName: "AudioPanelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AudioPanelCollectionViewCell")
        collectionview.register(UINib(nibName: "ThumbNailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThumbNailCollectionViewCell")
        completion()
    }
    func registerTableviewNib(tableview: UITableView,completion: @escaping()->()){
        tableview.register(UINib(nibName: "ContentTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTextTableViewCell")
        tableview.register(UINib(nibName: "AudioDropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioDropDownTableViewCell")
        completion()
    }
    
    
    
    func getTopicsVideoDataApi(page: Int,params: TopicVideoRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: GetVideoResponse?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getVideoData , parameter: params.dictionary ?? [:], method: .post) { (status: Result<GetVideoResponse>) in
                     switch status{
                     case .success(data: let data):
                         if page != 1{
                             self.getVideoResponseData?.data?.append(contentsOf: data.data?.data ?? [GetVideoData]())
                         }else{
                             self.getVideoResponseData = data.data
                             self.TotalVideoPageNo = data.data?.totalPages ?? 0
                             self.totalInstaPage = data.data?.totalPages ?? 0
                         }
//                         self.getVideoResponseData = data.data
//                         print("soruce ====> \(data.data?.data?[0].videoID)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }

    }
    func getVideoDataApi(page: Int,params: GetVideoDataRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: GetVideoResponse?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getVideoData , parameter: params.dictionary ?? [:], method: .post) { (status: Result<GetVideoResponse>) in
                     switch status{
                     case .success(data: let data):
                         if page != 1{
                             self.getVideoResponseData?.data?.append(contentsOf: data.data?.data ?? [GetVideoData]())
                         }else{
                             self.getVideoResponseData = data.data
                             self.TotalVideoPageNo = data.data?.totalPages ?? 0
                             self.totalInstaPage = data.data?.totalPages ?? 0
                         }
//                         self.getVideoResponseData = data.data
//                         print("soruce ====> \(data.data?.data?[0].videoID)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }

    }

    func getInstaVideoDataApi(page: Int,params: GetVideoDataRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: CategoriesResponseModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getVideoData , parameter: params.dictionary ?? [:], method: .post) { (status: Result<CategoriesResponseModel>) in
                     switch status{
                     case .success(data: let data):
                         if page != 1{
                             self.getInstaVideoResponseData?.data?.data?.append(contentsOf: data.data?.data ?? [CategoryDatum]())
                         }else{
                             self.getInstaVideoResponseData = data
                             self.totalInstaPage = data.data?.totalPages ?? 0
                         }
//                         self.getVideoResponseData = data.data
//                         print("soruce ====> \(data.data?.data?[0].videoID)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }

    }
func getEmotionVideoDataApi(page: Int,params: GetVideoDataRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: GetVideoResponse?, _ message: String) -> ()){
    ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getEmotionVideoData , parameter: params.dictionary ?? [:], method: .post) { (status: Result<GetVideoResponse>) in
                 switch status{
                 case .success(data: let data):
                     if page != 1{
                         self.getVideoResponseData?.data?.append(contentsOf: data.data?.data ?? [GetVideoData]())
                     }else{
                         self.getVideoResponseData = data.data
                         self.TotalVideoPageNo = data.data?.totalPages ?? 0
                     }
//                         self.getVideoResponseData = data.data
//                         print("soruce ====> \(data.data?.data?[0].videoID)")
                     completion(.Success,data,data.message ?? "")
                 case .failure(message: let message):
                     completion(.Failure, nil, message)
                 case .error(message: let message):
                     completion(.Error, nil, message)
                 }
             }

}
}
