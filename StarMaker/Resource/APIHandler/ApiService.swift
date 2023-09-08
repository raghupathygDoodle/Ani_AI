//
//  ApiService.swift
//  APIBase
//
//  Created by Raghu on 30/05/23.
//

import Foundation


class ApiService{
    static let sharedInstance:ApiService = {
        let instance = ApiService()
        return instance
    }()
    
    
    //----------------------------------------------------------------------------
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@ MARK:- ApiRequest @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    //----------------------------------------------------------------------------
    
    func apiRequest<T:Codable>(baseUrl:String,url:String,parameter: DictionaryType,method:HTTPMethod,completion: @escaping (Result<T>) -> ())
    {
        Internet.isAvailable(completion: { (status, message) in
            if status {
                debugPrint("Passed Parameter : \(parameter)")
                debugPrint("url",baseUrl+url)
                self.configRequest(baseUrl: baseUrl, url: url, method: method,parameter:parameter, completion: { (response) in
                    DispatchQueue.main.async {
                        completion(response)
                    }
                })
            }
            else{
                DispatchQueue.main.async {
                    completion(Result<T>.failure(message: message))
                }
            }
        })
    }
    
    
    //----------------------------------------------------------------------------
    // @@@@@@@@@@@@@@@@@@@@ MARK:- ApiRequest Multipart Data @@@@@@@@@@@@@@@@@@@@
    //----------------------------------------------------------------------------
    
    func ApiRequestWithMultipartData<T:Decodable>(baseUrl:String, url:String, images:imageParamArray, parameter: [String:Any], method:HTTPMethod, completion: @escaping (Result<T>) -> ())
    {
        Internet.isAvailable(completion: { (status, message) in
            if status{
                debugPrint("Passed Parameter : \(parameter)")
                debugPrint("url",url,HTTPMethod.self)
                let req = MultipartdataRequest()
                req.apiRequest(baseUrl: baseUrl, url: url, method: method, parameter: parameter, multipartData: images, completion: {(response) in
                    completion(response)
                })
            }
            else{
                completion(Result<T>.failure(message: message))
            }
        })

    }
    
    func apiRequestWithMultipartDataNew<T:Decodable>(baseUrl:String, url:String, parameter: [String:Any], method:HTTPMethod, completion: @escaping (Result<T>) -> ())
    {
        Internet.isAvailable(completion: { (status, message) in
            if status{
                debugPrint("Passed Parameter : \(parameter)")
                debugPrint("url",url,HTTPMethod.self)
                let req = MultipartdataRequest()
                req.apiRequestForNew(baseUrl: baseUrl, url: url, method: method, parameter: parameter, completion: {(response) in
                    completion(response)
                })
            }
            else{
                completion(Result<T>.failure(message: message))
            }
        })

    }
    
    
    
    //-----------------------------------------------------------------------------------
    //@@@@@@@@@@@@@@@@@@@@ MARK:- Configure Request Based on ApiType @@@@@@@@@@@@@@@@@@@@
    //-----------------------------------------------------------------------------------
    
    func configRequest<T:Codable>(baseUrl:String,url:String,method:HTTPMethod,parameter:Any,completion: @escaping (Result<T>) -> ())
    {
        
        guard let urlString = URL(string: baseUrl + url) else { return }
        var request = URLRequest(url: urlString)
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
    
        if AppUserdefault.accessToken != nil {
            request.setValue("Bearer \(AppUserdefault.accessToken ?? "")", forHTTPHeaderField: "Authorization")
           // let boundary = "Boundary-\(UUID().uuidString)"
            //request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
        

        print("Headers-------> : \(String(describing: request.allHTTPHeaderFields))")
        
        if method == .post || method == .delete || method == .patch || method == .put
        {
            request.httpBody  = try! JSONSerialization.data(withJSONObject: parameter as! DictionaryType, options:[])
        }
        URLSession.shared.dataTask(with:request ) { (data, response, error) in
            guard let data = data, error == nil else {
                debugPrint(error?.localizedDescription ?? "")
                completion(Result<T>.error(message: "Please try again later"))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                
                let code:Int = httpResponse.statusCode
                if let status = StatusCode(rawValue: code){
                    switch status{
                    case .logout:
//                        self.refreshAuthToken { (status, res, msg) in
//                            switch status{
//                            case .Success:
//                                debugPrint("Refresh Token Success")
//                                completion(Result<T>.authFailure(message: msg))
//                            case .AuthFailure:
//                                debugPrint("Refresh Token AuthFailure")
//                                AuthValidation().sessionLogout()
                        print("Session logged out")
//                            default:
//                                debugPrint("Refresh Token Failure")
//                                completion(Result<T>.failure(message: msg))
//                            }
//                        }
                    default:
                        let apiData = (data:data, response:response)
                        let model = responseDecode(response: apiData, modelType: T.self) //Get response of respective model class
                        completion(model)
                    }
                }
            }
        }.resume()
    }
    
    func refreshAuthToken(completion: @escaping (_ status:ApiStatus, _ response:Any, _ message:String) -> ()) {
        var message = ""
        guard let urlString = URL(string: Endpoint.baseURL) else { return }
        var request = URLRequest(url: urlString)
        request.timeoutInterval = 30
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.addValue("Bearer \(KeychainManager.getRefreshToken() as String? ?? "")", forHTTPHeaderField: "Authorization")
//        debugPrint("Refresh token", KeychainManager.getRefreshToken() as String? ?? "")
        debugPrint("Headers : \(String(describing: request.allHTTPHeaderFields))")
        
        URLSession.shared.dataTask(with:request ) { (data, response, error) in
            guard let data = data, error == nil else {
                debugPrint(error?.localizedDescription ?? "")
                completion(.Failure,"","Please Try Again Later")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let code:Int = httpResponse.statusCode
                if let status = StatusCode(rawValue: code){
                    let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                    if let messageValue = json?["message"] as? String{
                        message = messageValue
                        debugPrint("json= \(String(describing: json))")
                    }
                    if let dataValue = json?["data"] as? [String:Any] {
                        let accessToken = dataValue["accessToken"] as? String
//                        KeychainManager.saveAccessToken(token: accessToken as NSString? ?? "")
                        debugPrint("accessToken= \(String(describing: accessToken)))")
                    }
                    switch status{
                    case .success:
                        debugPrint("Refresh Success")
                        completion(.Success,"",message)
                    case .logout:
                        debugPrint("Refresh AuthFailure")
//                        completion(.AuthFailure,"",message)
                    default:
                        debugPrint("Refresh Failure")
                        completion(.Failure,"",message)
                    }
                }
            }
        }.resume()
    }
        
}
