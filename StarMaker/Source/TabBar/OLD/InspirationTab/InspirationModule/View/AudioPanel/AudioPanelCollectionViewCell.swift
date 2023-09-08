//
//  AudioPanelCollectionViewCell.swift
//  StarMaker
//
//  Created by Raghu on 21/07/23.
//

import UIKit
import MarqueeLabel
import AVFoundation
import AVFAudio

class AudioPanelCollectionViewCell: UICollectionViewCell, AVAudioPlayerDelegate {
    

    var audioPlayer: AVAudioPlayer?
   var isPlaying = false
    var closurePause: (()->())?
//    @IBOutlet weak var audioProgressView: UIProgressView!
    @IBOutlet weak var labelAudioTitle: MarqueeLabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var btnPausePlay: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }

    @IBAction func pause_playBtnAction(_ sender: UIButton) {
        if let action = closurePause{
            action()
        }
    }
    func playSound(_ sound: String) {
        

        
        do {
            let url = NSURL(string: sound)!
            let data = try Data(contentsOf: url as URL)
            audioPlayer = try AVAudioPlayer(data: data)
            guard let player = audioPlayer else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
}
