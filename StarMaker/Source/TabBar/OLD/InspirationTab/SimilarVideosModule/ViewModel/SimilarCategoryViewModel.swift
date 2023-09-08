//
//  SimilarCategoryViewModel.swift
//  StarMaker
//
//  Created by Raghu on 27/07/23.
//

import UIKit

class SimilarCategoryViewModel: NSObject {

    var getSimilarVideoData: SimilarVideoResponseData?
    var getInstaSimilarVideoData: InstaSimilarVideoResponseData?
    var TotalSimilarPageNo = 1
    var instaPageNo = 1
    var totalInstaPageNo = Int()
    func registerCollectionviewNib(collectionview: UICollectionView,completion : @escaping()->()){
        collectionview.register(UINib(nibName: "TextContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TextContentCollectionViewCell")
        collectionview.register(UINib(nibName: "AudioPanelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AudioPanelCollectionViewCell")
        collectionview.register(UINib(nibName: "ThumbNailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ThumbNailCollectionViewCell")
        completion()
    }
    func registerTableviewNib(tableview: UITableView,completion: @escaping()->()){
        tableview.register(UINib(nibName: "ContentTextTableViewCell", bundle: nil), forCellReuseIdentifier: "ContentTextTableViewCell")
        tableview.register(UINib(nibName: "AudioDropDownTableViewCell", bundle: nil), forCellReuseIdentifier: "AudioDropDownTableViewCell")
        completion()
    }
    
    func getSimilarVideoListAPI(page: Int,params: SimilarVideoRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: SimilarVideoResponseModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getSimilarVideoData , parameter: params.dictionary ?? [:], method: .post) { (status: Result<SimilarVideoResponseModel>) in
                     switch status{
                     case .success(data: let data):
                         if page != 1{
                             self.getSimilarVideoData?.data?.append(contentsOf: data.data?.data ?? [SimilarVideoData]())
                         }else{
                             self.getSimilarVideoData = data.data
                             self.TotalSimilarPageNo = data.data?.totalPages ?? 0
                             self.totalInstaPageNo = data.data?.totalPages ?? 0
                         }
//                         self.getSimilarVideoData = data.data
//                         print("soruce ====> \(data.data?.data?[0].videoID)")
                         completion(.Success,data,data.message ?? "")
                     case .failure(message: let message):
                         completion(.Failure, nil, message)
                     case .error(message: let message):
                         completion(.Error, nil, message)
                     }
                 }
        
    }
    func getInstaSimilarVideoListAPI(page: Int,params: SimilarVideoRequestModel,completion: @escaping(_ status: ApiStatus,  _ data: InstaSimilarVideoResponseModel?, _ message: String) -> ()){
        ApiService.sharedInstance.apiRequest(baseUrl: Endpoint.baseURL, url: Endpoint.getSimilarVideoData , parameter: params.dictionary ?? [:], method: .post) { (status: Result<InstaSimilarVideoResponseModel>) in
                     switch status{
                     case .success(data: let data):
                         if page != 1{
                             self.getInstaSimilarVideoData?.data?.append(contentsOf: data.data?.data ?? [InstaSimilarVideoData]())
                         }else{
                             self.getInstaSimilarVideoData = data.data
                             self.TotalSimilarPageNo = data.data?.totalPages ?? 0
                             self.totalInstaPageNo = data.data?.totalPages ?? 0
                         }
//                         self.getSimilarVideoData = data.data
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
