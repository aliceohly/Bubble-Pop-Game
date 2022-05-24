//
//  ViewController.swift
//  BubblePop
//
//  Created by Liying Wu on 16/4/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BubblePop"
        // Background music will be played
        MusicPlayer.shared.startBackgroundMusic()
    }
}

