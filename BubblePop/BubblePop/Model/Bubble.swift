//
//  Bubble.swift
//  BubblePop
//
//  Created by Liying Wu on 16/4/21.
//

import UIKit

enum bubbleColor {
    case red 
    case pink
    case green
    case blue
    case black
}

// Create a bubble class
class Bubble: UIButton {
    
    var randomX = 0
    var randomY = 0
    let colour = Int.random(in: 1...100)
    var point = 0
    let gameVC: GameViewController
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, gameVC: GameViewController) {
        self.gameVC = gameVC
        super.init(frame: frame)
        // Randomly assign color
        self.setColour()
        // To make the UIbutton have a round shape like a bubble
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
    }
    
    func setColour() {
        
        // Switch statement to fulfill the Probability of Appearance in Table 1
        switch colour {
        
        // Red color: 40%, game points: 1
        case 1...40:
            self.backgroundColor = .red
            point = 1
            break
            
        // Pink color: 30%, game points: 2
        case 41...70:
            self.backgroundColor = UIColor(red: 255/255, green: 100/255, blue: 130/255, alpha: 1)
            point = 2
            break
            
        // Green color: 15%, game points: 5
        case 71...85:
            self.backgroundColor = .green
            point = 5
            break
            
        // Blue color: 10%, game points: 8
        case 86...96:
            self.backgroundColor = .blue
            point = 8
            break
            
        // Black color: 5%, game points: 10
        case 97...100:
            self.backgroundColor = .black
            point = 10
            break
            
        default:
            print("You shouldn't reach here, something is wrong")
            break
        }
    }
}





 
    





