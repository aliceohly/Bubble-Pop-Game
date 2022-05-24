//
//  GameViewController.swift
//  BubblePop
//
//  Created by Liying Wu on 16/4/21.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var effectiveAreaView: UIView!
    @IBOutlet weak var myScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var timesUpLabel: UILabel!
    @IBOutlet weak var preStartTimeLabel: UILabel!
    
    // When a bubble is pressed by the player, it will be removed from the view. The score will also be updated.
    @IBAction func bubblePressed(_ sender: Bubble) {
        let bubble = sender
        bubble.removeFromSuperview()
        calculateScore(bubble: bubble)
    }
    
    var name: String = ""
    var remainingTime = 0
    var maxBubbleAmount = 0
    var newBubbleAmount = 0
    var timer = Timer()
    var myScore: Double = 0.0
    let multiplier: Double = 1.5
    var lastBubble: Bubble?
    var currentBubbleBatch: BubbleBatch?
    var prepareTime = 3
    var score = Score()
    var playersScore: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BubblePop"
        self.fillInHighScore()
        self.warmUp()
    }
    
    func fillInHighScore() {
        // The high score label is defaulted to show "0", if there is no previous player record
        highScoreLabel.text = "0"
        // If there is/are previous player record(s), the highest score will be displayed
        if let unwrappedPlayersScore = UserDefaults.standard.value(forKey: "ScoreBoard") as? [[String]] {
            playersScore = unwrappedPlayersScore
            // Since the scores have been sorted in UserDefaults from the highest to the lowest (please refer to class Score), we take [0] to extract the highest-score player's details. [1] is referring to his/her score.
            
            // Note: this high score will be overwritten by the current score during gameplay if the latter shows higher value
            highScoreLabel.text = playersScore[0][1]
        }
    }
    
    func warmUp() {
        // Player's name and the initial time are populated in the corresponding labels
        nameLabel.text = name
        remainingTimeLabel.text = String(remainingTime)
        timesUpLabel.isHidden = true
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.preCountingDown()
        }
    }
    
    // Players will have 3 seconds to warm up (var prepareTime = 3). Flashing count down 3,2,1 at the beginning of play
    @objc func preCountingDown() {
        prepareTime -= 1
        preStartTimeLabel.text = String(prepareTime)
        
        // After the 3-second warm up period, the game will start
        if prepareTime == 0 {
            timer.invalidate()
            preStartTimeLabel.isHidden = true
            self.startGame()
        }
    }
    
    func startGame() {
        // When the game starts, a batch of bubbles will be generated (initial bubble quantity equals to the bubble amount set by the play on the setting screen).
        currentBubbleBatch = BubbleBatch(bubbleAmount: maxBubbleAmount, gameVC: self)
        
        // A timer will be initiated and start counting down. For every 1 sec, funciton countingDown() is called.
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.countingDown()
        }
    }
    
    // During each game second, firstly, the remaining time label will be updated. Secondly, the bubble batch will be updated using function updateBubbleBatch().
    @objc func countingDown() {
        remainingTime -= 1
        remainingTimeLabel.text = String(remainingTime)
        updateBubbleBatch()
        
        // When the game is finished (timer is invalidated), firstly, all bubbles will be removed from the screen so that players are not allowed to press any more bubbles. Secondly, a "Time's up" label will be shown. Thirdly, player score will be passed to function updateScore() in the Score class. Lastly, the player will be directed to the High Score View page using function loadHighScoreView().
        if remainingTime == 0 {
            currentBubbleBatch?.removeAllBubble()
            timesUpLabel.isHidden = false
            timer.invalidate()
            
            score.updateScore(newScore: [name,String(myScore)])
            
            self.loadHighScoreView()
        }
    }
    
    // A function used to calculate score
    func calculateScore(bubble: Bubble) {
        
        // Each bubble has its own game points
        var newAddedPoint = Double(bubble.point)
        
        // If the last / previous bubble has the same color of the current pressed bubble, a 1.5 times multiplier will be applied (the satisfied core functionality 8 - if two or more bubbles of the same colour are popped in a consecutive sequence, the bubbles after the first one will get 1.5 times their original game points).
        if let unwrappedLastBubble = lastBubble {
            if bubble.backgroundColor == unwrappedLastBubble.backgroundColor {
                newAddedPoint = newAddedPoint * multiplier
            }
        }
        myScore += newAddedPoint
        
        // Extract text from the high score label, convert it to double and compare it with the current score. If current score is higher than the record, high score label will be updated to reflect the highest score during gameplay.
        if let highScoreText = highScoreLabel.text,
           let existingHighScore = Double(highScoreText) {
            if myScore > existingHighScore {
                highScoreLabel.text = String(myScore)
            }
        }
        
        // The score label will be updated
        myScoreLabel.text = String(myScore)
        // The newly pressed bubble will be set to be the last bubble
        lastBubble = bubble
    }
    
    // This funciton is used to satisfied core functionality 9 - the app shall refresh bubbles displayed every game second.
    func updateBubbleBatch() {
        // This program will randomly remove different numbers of bubble on the screen
        currentBubbleBatch?.removeBubble()
        // After removal, a new set of bubble will be generated (please note that although the newest bubble amount shown on the screen will be set to the max. bubble amount, in reality it will not always display the max. bubble amount because if the newly generated bubble is overlapped with the exisiting bubble, this bubble will not be shown on the screen. Hence there may be more or less bubbles on the screen compared with the previous game second)
        newBubbleAmount = maxBubbleAmount - (currentBubbleBatch?.bubbleArray.count ?? 0)
        currentBubbleBatch?.addBubble(newBubbleAmt: newBubbleAmount)
    }
    
    // A function to direct players to the High Score View
    func loadHighScoreView() {
        // It will be actioned with a 2 second deplay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}









