//
//  Music.swift
//  BubblePop
//
//  Created by Liying Wu on 28/4/21.
//  Music >> name: Colorful Day, by APmuse, from melodyloops

import Foundation
import AVFoundation

class MusicPlayer {
    // Add a property to make it as a singleton class, which prevents from playing background music in double
    static let shared = MusicPlayer()
    
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                
                // Set the music to loop infinitely
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
}
