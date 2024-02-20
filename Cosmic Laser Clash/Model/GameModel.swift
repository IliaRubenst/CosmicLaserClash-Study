//
//  GameModel.swift
//  Cosmic Laser Clash
//
//  Created by Ilia Ilia on 20.02.2024.
//

import Foundation


protocol GameModelDelegate: AnyObject {
    func updateScore(_ score: Int)
    func updateTimeLeft(_ timeLeft: Int)
    func gameOver()
}

class GameModel {
    
    weak var delegate: GameModelDelegate?
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var timeLeft = 60 {
        didSet {
            timerLabel.text = "Time left:\(timeLeft)"
        }
    }
}
