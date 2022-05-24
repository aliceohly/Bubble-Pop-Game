//
//  Score.swift
//  BubblePop
//
//  Created by Liying Wu on 23/4/21.
//

import Foundation

struct Score {
    
    // Each score board looks like [["player 1", "Score"], ["Player 2", "Score"], etc.]
    var scoreBoard: [[String]] = []
    var oldScoreBoard: [[String]] = []
    
    mutating func updateScore(newScore: [String]) {
        // Apend a new score to the scoreBoard
        scoreBoard.append(newScore)
        
        // Extract exisitng values from UserDefaults using key "ScoreBoard" and assign it to the old score board
        if let unwrappedScoreBoard = UserDefaults.standard.value(forKey: "ScoreBoard") as? [[String]] {
            oldScoreBoard = unwrappedScoreBoard
        } else {
            oldScoreBoard = []
        }
        
        // Generate a new score board, which is a combination of the old score board and the new score
        var newScoreBoard = scoreBoard + oldScoreBoard
        
        // Perform ranking from the highest score to the lowest socre based on all players' scores (no need to rank if there is only 1 existing score)
        if newScoreBoard.count > 1 {
            newScoreBoard.sort {Double($0[1])! > Double($1[1])!}
        }
        
        // Store the new score board into the UserDefaults using key "ScoreBoard"
        UserDefaults.standard.set(newScoreBoard, forKey: "ScoreBoard")
    }
}
