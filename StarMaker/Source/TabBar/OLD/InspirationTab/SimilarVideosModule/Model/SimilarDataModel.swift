//
//  SimilarDataModel.swift
//  StarMaker
//
//  Created by Raghu on 27/07/23.
//

import Foundation

struct SimilarVideoRequestModel: Codable {
    var videoId: String?
    var currentPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case videoId = "video_id"
        case currentPage = "currentPage"
     
    }
}

// MARK: - SimilarVideoResponseModel
struct SimilarVideoResponseModel: Codable {
    var status: Int?
    var message: String?
    var data: SimilarVideoResponseData?
}

// MARK: - DataClass
struct SimilarVideoResponseData: Codable {
    var data: [SimilarVideoData]?
    var totalPages: Int?
}

// MARK: - Datum
struct SimilarVideoData: Codable {
    var gptTopics: String?
    var audioMlMale: String?
    var keywords,subTopic1, subTopic2: String?
    var mainTopic, summaryHi: String?
    var audioHiMale: String?
    var audioEnFmale: String?
    var audioEnMale: String?
    var acts: String?
    var audioTeMale: String?
    var summaryTa, summaryGu, summaryTe: String?
    var audioMlFemale: String?
    var categoryAnimetaGPT: String?
    var summaryKn, videoTitle, summaryBn: String?
    var creatorCountry: CreatorCountry?
    var audioGuFemale, audioTaFemale, audioTeFemale: String?
    var hashtags: String?
    var gender: Gender?
    var tone, title: String?
    var tubularVideoCategory: String?
    var platform: String?
    var videoURL: String?
    var numberOfMatching: String?
    var finalCategory: String?
    var audioGenerated: Bool?
    var humanEmotions: String?
    var audioBnFemale, audioMrFemale: String?
    var views, summary, videoIdea2, creator: String?
    var videoIdea1: String?
    var audioKnMale: String?
    var topics: String?
    var ageGroup, summaryMl: String?
    var audioGuMale, audioKnFemale: String?
    var summaryMr, tubularCreatorCategory, youtubeCategory, location: String?
    var audioMrMale, audioTaMale, audioBnMale: String?
    var publishedDate: String?
    var audioHiFemale: String?
    var videoID: String?

    enum CodingKeys: String, CodingKey {
        case audioEnMale = "summary_en_audio_male"
        case audioEnFmale = "summary_en_audio_female"
        case gptTopics = "gpt_topics"
        case audioMlMale = "audio_ml_male"
        case keywords
        case subTopic2 = "sub_topic_2"
        case subTopic1 = "sub_topic_1"
        case mainTopic = "main_topic"
        case summaryHi = "summary_hi"
        case audioHiMale = "audio_hi_male"
        case topics
        case acts
        case audioTeMale = "audio_te_male"
        case summaryTa = "summary_ta"
        case summaryGu = "summary_gu"
        case summaryTe = "summary_te"
        case audioMlFemale = "audio_ml_female"
        case categoryAnimetaGPT = "category_animeta_gpt"
        case summaryKn = "summary_kn"
        case videoTitle = "video_title"
        case summaryBn = "summary_bn"
        case creatorCountry = "creator_country"
        case audioGuFemale = "audio_gu_female"
        case audioTaFemale = "audio_ta_female"
        case audioTeFemale = "audio_te_female"
        case hashtags, gender, tone, title
        case tubularVideoCategory = "tubular_video_category"
        case platform
        case videoURL = "video_url"
        case numberOfMatching = "number_of_matching"
        case finalCategory = "final_category"
        case audioGenerated
        case humanEmotions = "human_emotions"
        case audioBnFemale = "audio_bn_female"
        case audioMrFemale = "audio_mr_female"
        case views, summary
        case videoIdea2 = "video_idea_2"
        case creator
        case videoIdea1 = "video_idea_1"
        case audioKnMale = "audio_kn_male"
        
        case ageGroup = "age_group"
        case summaryMl = "summary_ml"
        case audioGuMale = "audio_gu_male"
        case audioKnFemale = "audio_kn_female"
        case summaryMr = "summary_mr"
        case tubularCreatorCategory = "tubular_creator_category"
        case youtubeCategory = "youtube_category"
        case location
        case audioMrMale = "audio_mr_male"
        case audioTaMale = "audio_ta_male"
        case audioBnMale = "audio_bn_male"
        case publishedDate = "published_date"
        case audioHiFemale = "audio_hi_female"
        case videoID = "video_id"
    }
}



enum CreatorCountry: String, Codable {
    case india = "India"
    case unitedStates = "United States"
}

enum Gender: String, Codable {
    case all = "All"
    case allGenders = "All genders"
    case both = "Both"
    case female = "Female"
    case genderAllGenders = "All Genders"
    case male = "Male"
    case maleAndFemale = "Male and Female"
    case unisex = "Unisex"
}

struct InstaSimilarVideoResponseModel: Codable {
    var status: Int?
    var message: String?
    var data: InstaSimilarVideoResponseData?
}

// MARK: - DataClass
struct InstaSimilarVideoResponseData: Codable {
    var data: [InstaSimilarVideoData]?
    var totalPages: Int?
}

// MARK: - Datum
struct InstaSimilarVideoData: Codable {
    var gptTopics: String?
    var audioMlMale: String?
    var keywords,subTopic1, subTopic2: String?
    var mainTopic, summaryHi: String?
    var audioHiMale: String?
    var audioEnFmale: String?
    var audioEnMale: String?
    var acts: String?
    var audioTeMale: String?
    var summaryTa, summaryGu, summaryTe: String?
    var audioMlFemale: String?
    var categoryAnimetaGPT: String?
    var summaryKn, videoTitle, summaryBn: String?
    var creatorCountry: InstaCreatorCountry?
    var audioGuFemale, audioTaFemale, audioTeFemale: String?
    var hashtags: String?
    var gender: InstaGender?
    var tone, title: String?
    var tubularVideoCategory: String?
    var platform: String?
    var videoURL: String?
    var numberOfMatching: String?
    var finalCategory: String?
    var audioGenerated: Bool?
    var humanEmotions: String?
    var audioBnFemale, audioMrFemale: String?
    var views: String?
    var summary, videoIdea2, creator: String?
    var videoIdea1: String?
    var audioKnMale: String?
    var topics: String?
    var ageGroup, summaryMl: String?
    var audioGuMale, audioKnFemale: String?
    var summaryMr, tubularCreatorCategory, youtubeCategory, location: String?
    var audioMrMale, audioTaMale, audioBnMale: String?
    var publishedDate: String?
    var audioHiFemale: String?
    var videoID: String?

    enum CodingKeys: String, CodingKey {
        case audioEnMale = "summary_en_audio_male"
        case audioEnFmale = "summary_en_audio_female"
        case gptTopics = "gpt_topics"
        case audioMlMale = "audio_ml_male"
        case keywords
        case subTopic2 = "sub_topic_2"
        case subTopic1 = "sub_topic_1"
        case mainTopic = "main_topic"
        case summaryHi = "summary_hi"
        case audioHiMale = "audio_hi_male"
        case topics
        case acts
        case audioTeMale = "audio_te_male"
        case summaryTa = "summary_ta"
        case summaryGu = "summary_gu"
        case summaryTe = "summary_te"
        case audioMlFemale = "audio_ml_female"
        case categoryAnimetaGPT = "category_animeta_gpt"
        case summaryKn = "summary_kn"
        case videoTitle = "video_title"
        case summaryBn = "summary_bn"
        case creatorCountry = "creator_country"
        case audioGuFemale = "audio_gu_female"
        case audioTaFemale = "audio_ta_female"
        case audioTeFemale = "audio_te_female"
        case hashtags, gender, tone, title
        case tubularVideoCategory = "tubular_video_category"
        case platform
        case videoURL = "video_url"
        case numberOfMatching = "number_of_matching"
        case finalCategory = "final_category"
        case audioGenerated
        case humanEmotions = "human_emotions"
        case audioBnFemale = "audio_bn_female"
        case audioMrFemale = "audio_mr_female"
        case views, summary
        case videoIdea2 = "video_idea_2"
        case creator
        case videoIdea1 = "video_idea_1"
        case audioKnMale = "audio_kn_male"
        
        case ageGroup = "age_group"
        case summaryMl = "summary_ml"
        case audioGuMale = "audio_gu_male"
        case audioKnFemale = "audio_kn_female"
        case summaryMr = "summary_mr"
        case tubularCreatorCategory = "tubular_creator_category"
        case youtubeCategory = "youtube_category"
        case location
        case audioMrMale = "audio_mr_male"
        case audioTaMale = "audio_ta_male"
        case audioBnMale = "audio_bn_male"
        case publishedDate = "published_date"
        case audioHiFemale = "audio_hi_female"
        case videoID = "video_id"
    }
}



enum InstaCreatorCountry: String, Codable {
    case india = "India"
    case unitedStates = "United States"
}

enum InstaGender: String, Codable {
    case all = "All"
    case allGenders = "All genders"
    case both = "Both"
    case female = "Female"
    case genderAllGenders = "All Genders"
    case male = "Male"
    case maleAndFemale = "Male and Female"
    case unisex = "Unisex"
}

