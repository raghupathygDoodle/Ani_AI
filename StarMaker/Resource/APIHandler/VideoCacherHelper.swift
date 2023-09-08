////
////  VideoCacherHelper.swift
////  StarMaker
////
////  Created by Raghu on 26/06/23.
////
//
//import Foundation
//import UIKit
//
//public enum Results<T> {
//    case success(T)
//    case failure(NSError)
//}
//class CacheManager {
//
//    static let shared = CacheManager()
//
//    private let fileManager = FileManager.default
//
//    private lazy var mainDirectoryUrl: URL = {
//
//        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
//        return documentsUrl
//    }()
//
//    func getFileWith(stringUrl: String, completionHandler: @escaping (Results<URL>) -> Void ) {
//
//
//        let file = directoryFor(stringUrl: stringUrl)
//
//        //return file path if already exists in cache directory
//        guard !fileManager.fileExists(atPath: file.path)  else {
//            completionHandler(Results.success(file))
//            return
//        }
//
//        DispatchQueue.global().async {
//
//            if let videoData = NSData(contentsOf: URL(string: stringUrl)!) {
//                videoData.write(to: file, atomically: true)
//
//                DispatchQueue.main.async {
//                    completionHandler(Results.success(file))
//                }
//            } else {
//                DispatchQueue.main.async {
//                    print(Results.failure(NSErrorDomain(string: <#T##String#>)))
////                    print(Results<Any>.error(message: "cont"))
////                    completionHandler(Results.failure(NSError.errorWith(text: "Can't download video")))
//                }
//            }
//        }
//    }
//
//    private func directoryFor(stringUrl: String) -> URL {
//
//        let fileURL = URL(string: stringUrl)!.lastPathComponent
//
//        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)
//
//        return file
//    }
//}
