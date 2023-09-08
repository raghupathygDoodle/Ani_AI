//
//  CategoriesRequestModel.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import Foundation

struct SubCategoriesRequestModel: Codable{
    var category: String?
    enum CodingKeys: String, CodingKey {
        case category = "Category"
    }
}
struct KeywordRequestModel: Codable{
    var category: String?
    var currentPage: Int?
    enum CodingKeys: String, CodingKey {
        case category = "tubular_video_category"
        case currentPage = "currentPage"
    }
}
struct SubCategoriesRequest : Codable{
    var subcategories = [SubCategoryType]()
    enum CodingKeys: String, CodingKey {
        case subcategories = "main_topic"
      
    }
}
struct SubCategoryType : Codable{
    var subCatOne = String()
    var subCatSelectTwo = [String]()
    var subCatTwo = [SubCatTwoData]()
    var subCatIndex = [IndexPath]()
    var isSelect = Bool()
}
struct SubCatTwoData: Codable {
    var subCategoryTwo = String()
    var isSelect = Bool()
}
struct SubCateRequestModel:Codable {
    var primaryCategory = String()
    var subCat = [SubCategory]()
}
struct SubCategory: Codable{
    var subCategoryOne = String()
    var subCategoryTwo = [String]()
}
struct SelectedCategory: Codable {
    var displayName = String()
    var subCatOne = String()
    var subCatTwo = String()
}
//// MARK: - SubCategoriesModel
//struct SubCategoriesModel: Codable {
//    let status: Int?
//    let message: String?
//    let data: SubCategoriesModelData?
//}
//
//// MARK: - SubCategoriesModelData
//struct SubCategoriesModelData: Codable {
//    let data: SubCategoriesData?
//}
//
//// MARK: - DataData
//struct SubCategoriesData: Codable {
//    let subCategory1,keywords, subCategory2: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case subCategory1 = "Sub-category-1"
//        case subCategory2 = "Sub-category-2"
//        case keywords = "keywords"
//    }
//}


// MARK: - S
struct SubCategoriesModel: Codable {
    var status: Int?
    var message: String?
    var data: SubCategoriesModelData?
}

// MARK: - DataClass
struct SubCategoriesModelData: Codable {
    var data: [SubCategoriesData]?
}

// MARK: - Datum
struct SubCategoriesData: Codable {
    var isSelected : Bool?
    var isOpen : Bool?
//    var isSelected: Bool?
    var subcategory1: String?
    var thumbnail: String?
    var subCategory2: [String]?
}

//// MARK: - SubCategoriesModel
//struct SubCategoriesModel: Codable {
//    var status: Int?
//    var message: String?
//    var data: SubCategoriesModelData?
//}
//
//// MARK: - SData
//struct SubCategoriesModelData: Codable {
//    var data: SubCategoriesData?
//}
//
//// MARK: - DataData
//struct SubCategoriesData: Codable {
//    var data: [Datum]?
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    var isSelected: Bool?
//    var name: String?
//    var thumbnail: String?
//    var subCategory2: [String]?
//}

// MARK: - KeywordResponseModel
struct KeywordResponseModel: Codable {
    var status: Int?
    var message: String?
    var data: KeywordResponseData?
}

// MARK: - DataClass
struct KeywordResponseData: Codable {
    var keywords: [String]?
    var totalPages: Int?
}
