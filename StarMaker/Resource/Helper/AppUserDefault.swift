//
//  AppUserDefault.swift
//  APIBase
//
//  Created by Raghu on 30/05/23.
//

import Foundation

struct AppUserdefault  {
    
    private static var shared = UserDefaults.standard
    private init() {}
    
    
    static var accessToken:String? {
        get {
            return shared.value(forKey: "accessToken") as? String
        }
        set {
            shared.set((newValue ?? ""), forKey: "accessToken")
            shared.synchronize()
        }
    }
}
