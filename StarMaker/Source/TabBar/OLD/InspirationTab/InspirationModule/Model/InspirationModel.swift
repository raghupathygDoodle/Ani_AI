//
//  InspirationModel.swift
//  StarMaker
//
//  Created by Raghu on 19/07/23.
//

import Foundation

struct GetVideoDataRequestModel: Codable{
    var primaryCategory: String?
    var mainTopic = [SubCategoryType]()
    var subTopic: [String]?
    var keywords: [String]?
    var platform: String?
    var currentPage: Int?
    var videoId: String?
    enum CodingKeys: String, CodingKey {
        case primaryCategory = "tubular_video_category"
        case mainTopic = "main_topic"
        case subTopic = "sub_topic_1"
        case keywords = "keywords"
        case platform = "platform"
        case currentPage = "currentPage"
        case videoId = "video_id"
    }
}
struct TopicVideoRequestModel: Codable{
    var primaryCategory: String?
    var mainTopic = [TopicSubCategoryType]()
    var platform: String?
    var currentPage: Int?
    enum CodingKeys: String, CodingKey {
        case primaryCategory = "tubular_video_category"
        case mainTopic = "main_topic"
        case platform = "platform"
        case currentPage = "currentPage"
       
    }
}
struct TopicSubCategoryType: Codable {
    var subCatOne = String()
    var subCatTwo = [String]()
}
// MARK: - GetVideoResponse
struct GetVideoResponse: Codable {
    var status: Int?
    var message: String?
    var data: GetVideoResponseData?
}

// MARK: - DataClass
struct GetVideoResponseData: Codable {
    var totalPages: Int
    var data: [GetVideoData]?
}

// MARK: - Datum
struct GetVideoData: Codable {
    var summary: String?
    var hindi: String?
    var tamil: String?
    var bengali: String?
    var telugu: String?
    var marathi: String?
    var gujarathi: String?
    var kannada: String?
    var malayalam: String?
    var audTamML: String?
    var audTamFML: String?
    var audEngML: String?
    var audEngFML: String?
    var audHindiML: String?
    var audHindiFML: String?
    var audBengaliML: String?
    var audBengaliFML: String?
    var audTeluguML: String?
    var audTeluguFML: String?
    var audMarathiML: String?
    var audMarathiFML: String?
    var audGujarathiML: String?
    var audGujarathiFML: String?
    var audKannadaML: String?
    var audKannadaFML: String?
    var audMalayalamML: String?
    var audMalayalamFML: String?
    
    var videoIdea1_En: String?
    var videoIdea1_TeAudioMale: String?
    var videoIdea1_TeAudioFemale: String?
    var videoIdea1_BnAudioFemale: String?
    var videoIdea1_BnAudioMale: String?
    var videoIdea1_KnAudioFemale: String?
    var videoIdea1_KnAudioMale: String?
    var videoIdea1_MrAudioFemale: String?
    var videoIdea1_MrAudioMale: String?
    var videoIdea1_TaAudioFemale: String?
    var videoIdea1_TaAudioMale: String?
    var videoIdea1_HiAudioMale: String?
    var videoIdea1_HiAudioFemale : String?
    var videoIdea1_MlAudioMale: String?
    var videoIdea1_MlAudioFemale: String?
    var videoIdea1_GuAudioFemale: String?
    var videoIdea1_GuAudioMale: String?
    var videoIdea1_EnAudioMale: String?
    var videoIdea1_EnAudioFemale: String?
    var platform: String?
    var videoURL: String?
    var videoID, videoTitle: String?
//    var primaryCategory: PrimaryCategory?

    enum CodingKeys: String, CodingKey {
        case summary = "summary_en"
        case platform = "platform"
        case videoURL = "video_url"
        case videoID = "video_id"
        case videoTitle = "title_en"
//        case primaryCategory = "tubular_video_category"
        case hindi = "summary_hi"
        case tamil = "summary_ta"
        case bengali = "summary_bn"
        case telugu = "summary_te"
        case marathi = "summary_mr"
        case gujarathi = "summary_gu"
        case kannada = "summary_kn"
        case malayalam = "summary_ml"
        case audTamML = "audio_ta_male"
        case audTamFML = "audio_ta_female"
        case audEngML = "summary_en_audio_male"
        case audEngFML = "summary_en_audio_female"
        case audHindiML = "audio_hi_male"
        case audHindiFML = "audio_hi_female"
        case audBengaliML = "audio_bn_male"
        case audBengaliFML = "audio_bn_female"
        case audTeluguML = "audio_te_male"
        case audTeluguFML = "audio_te_female"
        case audMarathiML = "audio_mr_male"
        case audMarathiFML = "audio_mr_female"
        case audGujarathiML = "audio_gu_male"
        case audGujarathiFML = "audio_gu_female"
        case audKannadaML = "audio_kn_male"
        case audKannadaFML = "audio_kn_female"
        case audMalayalamML = "audio_ml_male"
        case audMalayalamFML = "audio_ml_female"
        
        case videoIdea1_EnAudioMale = "video_idea_1_en_audio_male"
        case videoIdea1_EnAudioFemale = "video_idea_1_en_audio_female"
        case videoIdea1_GuAudioMale = "video_idea_1_gu_audio_male"
        case videoIdea1_BnAudioMale = "video_idea_1_bn_audio_male"
        case videoIdea1_MlAudioFemale = "video_idea_1_ml_audio_female"
        case videoIdea1_HiAudioFemale = "video_idea_1_hi_audio_female"
        case videoIdea1_KnAudioMale = "video_idea_1_kn_audio_male"
        case videoIdea1_GuAudioFemale = "video_idea_1_gu_audio_female"
        case videoIdea1_MrAudioMale = "video_idea_1_mr_audio_male"
        case videoIdea1_MlAudioMale = "video_idea_1_ml_audio_male"
        case videoIdea1_HiAudioMale = "video_idea_1_hi_audio_male"
        case videoIdea1_TaAudioMale = "video_idea_1_ta_audio_male"
        case videoIdea1_TaAudioFemale = "video_idea_1_ta_audio_female"
        case videoIdea1_MrAudioFemale = "video_idea_1_mr_audio_female"
        case videoIdea1_TeAudioFemale = "video_idea_1_te_audio_female"
        case videoIdea1_BnAudioFemale = "video_idea_1_bn_audio_female"
        case videoIdea1_KnAudioFemale = "video_idea_1_kn_audio_female"
        case videoIdea1_TeAudioMale = "video_idea_1_te_audio_male"
        case videoIdea1_En = "video_idea_1_en"
    }
}

enum Platform: String, Codable {
    case youtube = "youtube"
}

//enum PrimaryCategory: String, Codable {
//    case beauty = "Beauty"
//}

struct TextLanguage: Codable {
    var English: String?
    var Hindi: String?
    var Tamil: String?
    var Bengali: String?
    var Telugu: String?
    var Marathi: String?
    var Gujarathi: String?
    var Kannada: String?
    var Malayalam: String?
}
struct AudioLanguages {
    var audioVoice: Voice?
    var audioLang: AudioLangType?
    var url: String?
}
enum Voice: String {
case male = "_male"
    case female = "_female"
}
enum AudioLangType: String {
case tamil = "ta"
case telugu = "te"
}
