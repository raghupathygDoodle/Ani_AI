//
//  Constant.swift
//  StarMaker
//
//  Created by Raghu on 17/07/23.
//

import Foundation
import UIKit

struct Constants {
    struct StoryBoards{
       static let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
    }
    struct ViewController {
        static let similarVC = "SimilarCategoryViewController"
        static let instaVC = "InstagramPanelViewController"
    }
    struct Images{
        static let videoUnselect = UIImage(named: "VideoUnselect")
        static let audioUnselect = UIImage(named: "AudioUnselect")
        static let textUnselect = UIImage(named: "TextUnselect")
        static let videoSelect = UIImage(named: "VideoSelect")
        static let audioSelect = UIImage(named: "AudioSelect")
        static let textSelect = UIImage(named: "TextSelect")
        static let playButton = UIImage(named: "play")
        static let pauseButton = UIImage(named: "pause")
        static let audioIcon = UIImage(named: "AudioIcon")
        static let textIcon = UIImage(named: "TextIcon")
        static let similarIcon = UIImage(named: "SimilarIcon")
        static let bookMarkIcon = UIImage(named: "BookmarkIcon")
        static let videoIcon = UIImage(named: "VideoIcon")

    }

    struct Color {
        static let beautyColor = UIColor(named: "BeautyColor")
        static let beautyUnselect = UIColor(named: "BeautyUnSelect")
        static let animalPetsSD = UIColor(named: "Animal_Pts_SD")
        static let animalPetsDSD = UIColor(named: "Animal_Pts_DSD")
        static let automativeSD = UIColor(named: "Automative_SD")
        static let automativeDSD = UIColor(named: "Automative_DSD")
        static let businessSD = UIColor(named: "Business_SD")
        static let businessDSD = UIColor(named: "Business_DSD")
        static let familyPrntSD = UIColor(named: "Family_Prnt_SD")
        static let familyPrntDSD = UIColor(named: "Family_Prnt_DSD")
        static let fashionStlSD = UIColor(named: "Fashion_Lfty_SD")
        static let fashionStlDSD = UIColor(named: "Fashion_Lfty_DSD")
        static let foodDrinkSD = UIColor(named: "Food_Drinks_SD")
        static let foodDrinkDSD = UIColor(named: "Food_Drinks_DSD")
        static let healthFtnSD = UIColor(named: "Health_Ftn_SD")
        static let healthFtnDSD = UIColor(named: "Health_Ftn_DSD")
        static let scienceTechSD = UIColor(named: "Science_Tech_SD")
        static let scienceTechDSD = UIColor(named: "Science_Tech_DSD")
        
        static let entertainmentSD = UIColor(named: "Entertainment_SD")
        static let entertainmentDSD = UIColor(named: "Entertainment_DSD")
        static let homeSD = UIColor(named: "Home_SD")
        static let homeDSD = UIColor(named: "Home_DSD")
        static let peopleSD = UIColor(named: "People_SD")
        static let peopleDSD = UIColor(named: "People_DSD")
        static let gamingSD = UIColor(named: "Gaming_SD")
        static let gamingDSD = UIColor(named: "Gaming_DSD")
        static let sportSD = UIColor(named: "Sports_SD")
        static let sportDSD = UIColor(named: "Sports_DSD")
        static let kidSD = UIColor(named: "Kids_SD")
        static let kidDSD = UIColor(named: "Kids_DSD")
        static let educationSD = UIColor(named: "Education_SD")
        static let educationDSD = UIColor(named: "Education_DSD")
        static let travelSD = UIColor(named: "Travel_SD")
        static let travelDSD = UIColor(named: "Travel_DSD")
        static let musicSD = UIColor(named: "Music_SD")
        static let musicDSD = UIColor(named: "Music_DSD")
        static let movieSD = UIColor(named: "Movies_SD")
        static let movieDSD = UIColor(named: "Movies_DSD")
        
       
        static let subTextColor = UIColor(named: "SubTextColor")
        //MARK: - IDEA MODULE COLORs
        static let dropDownBG = UIColor(named: "DropDownBG")
        //MARK: - Inspiration Screen Colors
        static let menuColor = UIColor(named: "MenuColor")
    }
    struct Category {
        static let beauty = "Beauty"
        static let fashion = "Fashion"
        static let familyPrnt = "Family & Parenting"
        static let businessFin = "Business & Finance"
        static let carVehicle = "Cars & Vehicles"
        static let scienceTech = "Science & Technology"
        static let foodDrink = "Food & Drink"
        static let animalPets = "Animals & Pets"
        static let healthFitness = "Health & Fitness"
        static let entertainment = "Pop Culture & Entertainment"
        static let home = "Home"
        static let people = "People & lifestyles"
        static let games = "Video Games"
        static let sports = "Sports"
        static let kids = "Kids Entertainment & Toys"
        static let education = "Career & Education"
        static let travel = "Travel & Destinations"
        static let music = "Music"
        static let movie = "Movies & TV"
        
        
    }
}
struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
extension UIViewController{
    func getWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate else { return nil }
                        return sceneDelegate.window
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                return appDelegate.window
            } else {
                return nil
            }
        }
    }
}
