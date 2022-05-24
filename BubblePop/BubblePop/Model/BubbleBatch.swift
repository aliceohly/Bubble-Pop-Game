//
//  BubbleBatch.swift
//  BubblePop
//
//  Created by Liying Wu on 17/4/21.
//

import Foundation
import UIKit

// Create a BubbleBatch class to generate a batch of bubbles
class BubbleBatch {
    
    // Each bubble will be stored in an array
    var bubbleArray: [Bubble] = []
    var gameVC: GameViewController
    
    init(bubbleAmount: Int, gameVC: GameViewController) {
        self.gameVC = gameVC
        self.createBatch(bubbleAmount: bubbleAmount, gameVC: gameVC)
    }
    
    func createBatch(bubbleAmount: Int, gameVC: GameViewController) {
        for _ in 0...(bubbleAmount-1) {
            self.createBubble()
        }
    }
    
    func createBubble() {
        // To ensure that every bubble is located inside the Effective Area View
        let effectiveArea = gameVC.effectiveAreaView.frame.size
        
        // Minus 50 from both x axis and y axis (why 50? Each bubble's height and width are default to be 50)
        let randomX = arc4random_uniform(UInt32(effectiveArea.width) - 50)
        let randomY = arc4random_uniform(UInt32(effectiveArea.height) - 50)
        
        // Each bubble is displayed at random position
        let bubbleFrame = CGRect(x: Int(randomX), y: Int(randomY), width: 50, height: 50)
        
        // Function checkOverlap is called in the while statement. The bubble will be generated and displayed on the screen only if it is not overlapped with the existing bubbles.
        while self.checkOverlap(bubbleFrame: bubbleFrame) == false {
            let bubble = Bubble(frame: bubbleFrame, gameVC: gameVC)
            bubble.setColour()
            // Add the bubble to the screen
            gameVC.effectiveAreaView.addSubview(bubble)
            // If a bubble is being touch, IBAction bubblePressed will be triggered
            bubble.addTarget(gameVC, action: #selector(gameVC.bubblePressed), for: .touchUpInside)
            // Append the bubble to the bubble array
            bubbleArray.append(bubble)
        }
    }
    
    // A function to check whehter the new bubble will be overlapped with the old ones
    func checkOverlap(bubbleFrame: CGRect) -> Bool {
        var overlap: Bool = false
        
        // If the array is empty, no need to check overlap
        if bubbleArray.count == 0 {
            overlap = false
        } else {
            for i in bubbleArray {
                // If intersect, set overlap to true
                if i.frame.intersects(bubbleFrame) {
                    overlap = true
                    break
                } else {
                    overlap = false
                }
            }
        }
        return overlap
    }
    
    // Randomly remove a number of bubbles (between 0 to all)
    func removeBubble() {
        let randomQuantity: Int = Int.random(in: 0...(bubbleArray.count-1))
        for i in 0...randomQuantity {
            bubbleArray[i].removeFromSuperview()
        }
        // If all bubbles need to be removed, clear the array. Otherwise set it to a new array.
        if randomQuantity == bubbleArray.count - 1 {
            bubbleArray = []
        } else {
            bubbleArray = Array(bubbleArray[(randomQuantity+1)...(bubbleArray.count-1)])
        }
    }
    
    // Generate a specific amount of bubbles
    func addBubble(newBubbleAmt: Int) {
        for _ in 0...(newBubbleAmt - 1) {
            self.createBubble()
        }
    }
    
    // A funciton to remove all bubbles - it is called when the game finishes to stop players earning more scores
    func removeAllBubble() {
        for i in 0..<bubbleArray.count {
            bubbleArray[i].removeFromSuperview()
        }
    }
}
