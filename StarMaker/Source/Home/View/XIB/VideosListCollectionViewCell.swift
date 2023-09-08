//
//  VideosListCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 21/06/23.
//

import UIKit
import AVKit
import AVFoundation
import Foundation
import GSPlayer
import youtube_ios_player_helper

class VideosListCollectionViewCell: UICollectionViewCell,UIApplicationDelegate, YTPlayerViewDelegate {
    
    @IBOutlet weak var ytPlayer: YTPlayerView!
    var playerLayer: AVPlayerLayer?
    var closureDescription:(()->())?
    var url: URL!

    override func prepareForReuse() {
               super.prepareForReuse()
        ytPlayer.isHidden = true

           }
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    

        //MARK: - Orginal value
    func ytConfig(_ urlID: String){
        ytPlayer.delegate = self
        
        ytPlayer.load(withVideoId: urlID)
    }

 
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        ytPlayer.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .ended{
            ytPlayer.playVideo()
        }
    }
    
    
    
    
    
    
    
    func play(){
            ytPlayer.playVideo()
            ytPlayer.isHidden = false
        }
        func pause(){
            ytPlayer.pauseVideo()
        }
    

    @IBAction func buttonPause(_ sender: UIButton) {
        if let action = closureDescription{
            action()
        }
    }
}
