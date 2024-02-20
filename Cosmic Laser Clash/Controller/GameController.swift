//
//  GameController.swift
//  Cosmic Laser Clash
//
//  Created by Ilia Ilia on 20.02.2024.
//

import SpriteKit

protocol GameControllerDelegate: AnyObject {
    func updateScore(_ score: Int)
    func updateTimeLeft(_ timeLeft: Int)
    func gameOver()
}

class GameController: NSObject, GameViewDelegate {
    weak var delegate: GameControllerDelegate?
    private var gameModel: GameModel
    
    init(gameModel: GameModel) {
        self.gameModel = gameModel
        super.init()
        self.gameModel.delegate = self
    }
    
    func startGame() {
        gameModel.startGame()
    }
    
    func handleNodeTap(_ node: SKNode) {
        gameModel.handleNodeTap(node)
    }
    
    func showReloadLabel() {
        gameModel.showReloadLabel()
    }
    
    func reloadLaser() {
        gameModel.reloadLaser()
    }
}

extension GameController: GameModelDelegate {
    func updateScore(_ score: Int) {
        delegate?.updateScore(score)
    }
    
    func updateTimeLeft(_ timeLeft: Int) {
        delegate?.updateTimeLeft(timeLeft)
    }
    
    func gameOver() {
        delegate?.gameOver()
    }
}
