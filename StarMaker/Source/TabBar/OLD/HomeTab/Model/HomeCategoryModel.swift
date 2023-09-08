//
//  File.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import Foundation

// MARK: - CategoriesModel
//struct CategoriesModel: Codable {
//    var status: Int?
//    var message: String?
//    var data: CategoriesModelData?
//}
//
//// MARK: - CategoriesModelData
//struct CategoriesModelData: Codable {
//    var data: DataData?
//}
//
//// MARK: - DataData
//struct DataData: Codable {
//    var category: [String]?
//    var isSelected: [Bool]?
//
//    enum CodingKeys: String, CodingKey {
//        case category = "Category"
//    }
//}

// MARK: - Categor
struct CategoriesModel: Codable {
    var status: Int?
    var message: String?
    var data: CategoriesModelData?
}

// MARK: - CategorData
struct CategoriesModelData: Codable {
    var data: DataData?
}

// MARK: - DataData
struct DataData: Codable {
    var category: [Category]?
}

// MARK: - Category
struct Category: Codable {
    var name: String?
    var isSubcategory: Bool?
    var displayName: String?
    var searchType: Int?
    var thumbnail, bannerImage: String?
}
struct GlobalSearchRequestModel: Codable {
    var searchQuery: String?
    var currentPage : Int?
    var platform: String?
}

// MARK: - CategoriesResponseModel
struct CategoriesResponseModel: Codable {
    var status: Int?
    var message: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var totalPages: Int?
    var data: [CategoryDatum]?
}

// MARK: - Datum
struct CategoryDatum: Codable {
    var gptTopics, hashtags, keywords: String?
    var gender: String?
    var tone, subTopic2, subTopic1, mainTopic: String?
    var title, acts: String?
    var tubularVideoCategory: String?
    var platform: String?
    var summaryEn: String?
    var videoURL: String?
    var numberOfMatching, finalCategory, humanEmotions: String?
      var views: Int?
    var videoIdea2, creator, videoIdea1, emotions: String?
    var categoryAnimetaGPT: String?
    var topics, ageGroup, tubularCreatorCategory, location: String?
    var titleEn: String?
    var creatorCountry: String?
    var videoID, level0, index, publishedDate: String?

    enum CodingKeys: String, CodingKey {
        case gptTopics = "gpt_topics"
        case hashtags, keywords, gender, tone
        case subTopic2 = "sub_topic_2"
        case subTopic1 = "sub_topic_1"
        case mainTopic = "main_topic"
        case title, acts
        case tubularVideoCategory = "tubular_video_category"
        case platform
        case summaryEn = "summary_en"
        case videoURL = "video_url"
        case numberOfMatching = "number_of_matching"
        case finalCategory = "final_category"
        case humanEmotions = "human_emotions"
        case views
        case videoIdea2 = "video_idea_2"
        case creator
        case videoIdea1 = "video_idea_1"
        case emotions
        case categoryAnimetaGPT = "category_animeta_gpt"
        case topics
        case ageGroup = "age_group"
        case tubularCreatorCategory = "tubular_creator_category"
        case location
        case titleEn = "title_en"
        case creatorCountry = "creator_country"
        case videoID = "video_id"
        case level0 = "level_0"
        case index
        case publishedDate = "published_date"
    }
}

struct SearchCategoriesResponseModel: Codable {
    var status: Int?
    var message: String?
    var data: SearchDataClass?
}

// MARK: - DataClass
struct SearchDataClass: Codable {
    var totalPages: Int?
    var data: [SearchCategoryDatum]?
}

// MARK: - Datum
struct SearchCategoryDatum: Codable {
    var gptTopics, hashtags, keywords: String?
    var gender: String?
    var tone, subTopic2, subTopic1, mainTopic: String?
    var title, acts: String?
    var tubularVideoCategory: String?
    var platform: String?
    var summaryEn: String?
    var videoURL: String?
    var numberOfMatching, finalCategory, humanEmotions: String?      
    var videoIdea2, creator, videoIdea1, emotions: String?
    var categoryAnimetaGPT: String?
    var topics, ageGroup, tubularCreatorCategory, location: String?
    var titleEn: String?
    var creatorCountry: String?
    var videoID, level0, index, publishedDate: String?

    enum CodingKeys: String, CodingKey {
        case gptTopics = "gpt_topics"
        case hashtags, keywords, gender, tone
        case subTopic2 = "sub_topic_2"
        case subTopic1 = "sub_topic_1"
        case mainTopic = "main_topic"
        case title, acts
        case tubularVideoCategory = "tubular_video_category"
        case platform
        case summaryEn = "summary_en"
        case videoURL = "video_url"
        case numberOfMatching = "number_of_matching"
        case finalCategory = "final_category"
        case humanEmotions = "human_emotions"
        case videoIdea2 = "video_idea_2"
        case creator
        case videoIdea1 = "video_idea_1"
        case emotions
        case categoryAnimetaGPT = "category_animeta_gpt"
        case topics
        case ageGroup = "age_group"
        case tubularCreatorCategory = "tubular_creator_category"
        case location
        case titleEn = "title_en"
        case creatorCountry = "creator_country"
        case videoID = "video_id"
        case level0 = "level_0"
        case index
        case publishedDate = "published_date"
    }
}
