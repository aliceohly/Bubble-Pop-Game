//
//  SettingViewController.swift
//  BubblePop
//
//  Created by Liying Wu on 16/4/21.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var bubbleSlider: UISlider!
    @IBOutlet weak var gameTimeLabel: UILabel!
    @IBOutlet weak var gameBubbleLabel: UILabel!
    
    // The game time will be updated when the circle icon is dragged by the player along the time slider
    @IBAction func timeUpdateSlider(_ sender: UISlider) {
        gameTimeLabel.text = String(Int(sender.value))
    }
    // The bubble amount will be updated when the the circle icon is dragged by the player along the time slider
    @IBAction func bubbleUpdateSlider(_ sender: UISlider) {
        gameBubbleLabel.text = String(Int(sender.value))
    }
    
    // When the view is loaded, the game time is defaulted to be 60s and the maximum number of bubbles displayed on the screen is defaulted to 15.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        self.timeSlider.value = 60
        self.bubbleSlider.value = 15
    }
    
    // The function will be called when the segue is activated
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            
            // Passing data (player's name, time and max. bubble amount) to the Game View Controller
            let vc = segue.destination as! GameViewController
            if let unwrappedNameTextField = nameTextField.text {
                vc.name = unwrappedNameTextField
            }
            vc.remainingTime = Int(timeSlider.value)
            vc.maxBubbleAmount = Int(bubbleSlider.value)
        }
    }
}
