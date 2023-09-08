//
//  ApiList.swift
//  APIBase
//
//  Created by Raghu on 30/05/23.
//

import Foundation

typealias ApiResponse = (status:Status,data:Any,message:String)
typealias ApiData = (data:Data, response:URLResponse?)

enum Result<T:Decodable> {
    case success(data:T) //Success response
    case failure(message:String)//APi call error
    case error(message:String) //Network error
//    case authFailure(message:String)
}

enum ApiStatus {
    case NoData
    case NetworkError
    case Success
    case Error
    case Failure
//    case AuthFailure
}



// @@@@@@@@ MARK:- Enum @@@@@@@@@@

public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum Status{
    case success,failure
}


struct Endpoint  {
    
    // MARK: - Staging
//    static var baseURL = "http://starmaker-backend.animeta.ai/"


    // MARK: - Dev URLs
    static var baseURL = "https://dev-backend-apps.animeta.ai/starmaker/"
    
   
    // MARK: - API lists
    static var getTaxonomy = "api/v1/taxonomy/list"
    static var getSubCategories = "api/v1/taxonomy/Category"
    static var getVideoData = "api/v1/video/list"
    static var getKeywordsData = "api/v1/video/keywordList"
    static var getSimilarVideoData = "api/v1/video/getSimilarVideo"
    static var getListEmotion = "api/v1/video/emotionsList"
    static var getEmotionVideoData = "api/v1/video/listByEmotions"
    static var globalSearch = "api/v1/video/globalSearch"
}


enum StatusCode:Int {
    case success = 200
    case error = 202
    case notFound = 404
    case passError = 403
    case badRequest = 400
    case bad = 503
    case logout = 401
    case noInternet = 0
    case internalServerError = 500
    case badReq = 406
    case userNot = 405
    case profileUpdate = 502
    case profUpdate = 413
    case mobileExist = 422
    case conflict = 409
    case resetContent = 205
    case timeOut = -1001
}

protocol APIResponseDelegate {
    func onSuccess()
    func onFailure(message:String)
}


