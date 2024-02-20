//
//  GameScene.swift
//  Cosmic Laser Clash
//
//  Created by Ilia Ilia on 30.07.2023.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starField: SKEmitterNode!
    var ufoNode = ["goodUFO", "badUFO"]
    var createTimer: Timer?
    var player: AVAudioPlayer!
    var isGameOver = false
    var isEmpty = false
    var laser: LaserNode!
    var enemyTimer = Float.random(in: 2...7)
    var timerLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
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
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupStarField()
        setupLabels()
        setupLaser()
        setupPhysicsWorld()
        setupGame()
    }
    
    // MARK: - Setup Methods
    private func setupStarField() {
        backgroundColor = .black
        starField = SKEmitterNode(fileNamed: "starfield")!
        starField.position = CGPoint(x: 1024, y: 384)
        starField.advanceSimulationTime(10)
        starField.zPosition = -2
        starField.name = "background"
        addChild(starField)
    }
    
    private func setupLabels() {
        scoreLabel = createLabel(position: CGPoint(x: 16, y: 720), text: "Score: 0", alignment: .left)
        timerLabel = createLabel(position: CGPoint(x: 16, y: 680), text: "Time left: 60", alignment: .left)
        
        addChild(scoreLabel)
        addChild(timerLabel)
    }
    
    private func createLabel(position: CGPoint, text: String, alignment: SKLabelHorizontalAlignmentMode) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.position = position
        label.horizontalAlignmentMode = alignment
        label.text = text
        return label
    }
    
    private func setupLaser() {
        laser = LaserNode()
        laser.laserCounter(at: CGPoint(x: 860, y: 720))
        laser.name = "laser"
        addChild(laser)
    }
    
    private func setupPhysicsWorld() {
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    private func setupGame() {
        isGameOver = true
        showStartGameDetails()
    }
    
    private func showStartGameDetails() {
        let startGameLabel = createLabel(position: CGPoint(x: 500, y: 450),
                                         text: "> START GAME <",
                                         alignment: .center)
        startGameLabel.name = "startgame"
        startGameLabel.zPosition = 1
        addChild(startGameLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
        let blinkAction = SKAction.sequence([fadeOutAction, fadeInAction])

        startGameLabel.run(SKAction.repeatForever(blinkAction))
        
        let ufoBadLogo = ufoNode[1]
        let spriteEnemy = SKSpriteNode(imageNamed: ufoBadLogo)
        spriteEnemy.position = CGPoint(x: 100, y: 350)
        spriteEnemy.size = CGSize(width: 150, height: 150)
        spriteEnemy.name = "startgame"
        addChild(spriteEnemy)
        
        let badUfoDescription = createLabel(position: CGPoint(x: 180, y: 340),
                                            text: " - enemy starship. Attack him to get a score.",
                                            alignment: .left)
        badUfoDescription.name = "startgame"
        badUfoDescription.zPosition = 1
        addChild(badUfoDescription)
        
        let ufoGoodLogo = ufoNode[0]
        let spriteFrind = SKSpriteNode(imageNamed: ufoGoodLogo)
        spriteFrind.position = CGPoint(x: 100, y: 250)
        spriteFrind.size = CGSize(width: 150, height: 150)
        spriteFrind.name = "startgame"
        addChild(spriteFrind)
        
        let goodUfoDescription = createLabel(position: CGPoint(x: 180, y: 240),
                                             text: " - friendly spaceship. Don't attack him.",
                                             alignment: .left)
        goodUfoDescription.name = "startgame"
        goodUfoDescription.zPosition = 1
        addChild(goodUfoDescription)
    }
    
    // MARK: - Game Logic Methods
    @objc func createUfo() {
        guard let ufoTop = ufoNode.randomElement() else { return }
        let spriteTop = SKSpriteNode(imageNamed: ufoTop)
        spriteTop.position = CGPoint(x: 1200, y: Int.random(in: 500...700))
        spriteTop.physicsBody = SKPhysicsBody(texture: spriteTop.texture!, size: spriteTop.size)
        spriteTop.size = CGSize(width: 150, height: 150)
        spriteTop.physicsBody?.categoryBitMask = 1
        spriteTop.physicsBody?.velocity = CGVector(dx: -400, dy: 0)
        spriteTop.physicsBody?.angularVelocity = 0
        spriteTop.physicsBody?.linearDamping = 0
        spriteTop.physicsBody?.angularDamping = 0
        spriteTop.name = ufoTop
        
        if ufoTop == "badUFO" {
            spriteTop.size = CGSize(width: 100, height: 100)
            spriteTop.physicsBody?.velocity = CGVector(dx: -600, dy: 0)
            spriteTop.zPosition = -1
        }
        addChild(spriteTop)
        
        guard let ufoMid = ufoNode.randomElement() else { return }
        let spriteMiddle = SKSpriteNode(imageNamed: ufoMid)
        spriteMiddle.position = CGPoint(x: -100, y: Int.random(in: 250...400))
        spriteMiddle.physicsBody = SKPhysicsBody(texture: spriteMiddle.texture!, size: spriteMiddle.size)
        spriteMiddle.size = CGSize(width: 150, height: 150)
        spriteMiddle.physicsBody?.categoryBitMask = 1
        spriteMiddle.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
        spriteMiddle.physicsBody?.angularVelocity = 0
        spriteMiddle.physicsBody?.linearDamping = 0
        spriteMiddle.physicsBody?.angularDamping = 0
        spriteMiddle.name = ufoMid
        
        if ufoMid == "badUFO" {
            spriteMiddle.size = CGSize(width: 100, height: 100)
            
            spriteMiddle.physicsBody?.velocity = CGVector(dx: 200, dy: 0)
            spriteMiddle.zPosition = -1
        }
        addChild(spriteMiddle)
        
        guard let ufoLow = ufoNode.randomElement() else { return }
        let spriteLow = SKSpriteNode(imageNamed: ufoLow)
        spriteLow.position = CGPoint(x: 1200, y: Int.random(in: 20...150))
        spriteLow.physicsBody = SKPhysicsBody(texture: spriteLow.texture!, size: spriteLow.size)
        spriteLow.size = CGSize(width: 150, height: 150)
        spriteLow.physicsBody?.categoryBitMask = 1
        spriteLow.physicsBody?.velocity = CGVector(dx: -400, dy: 0)
        spriteLow.physicsBody?.angularVelocity = 0
        spriteLow.physicsBody?.linearDamping = 0
        spriteLow.physicsBody?.angularDamping = 0
        spriteLow.name = ufoLow
        
        if ufoLow == "badUFO" {
            spriteLow.size = CGSize(width: 100, height: 100)
            spriteLow.physicsBody?.velocity = CGVector(dx: -600, dy: 0)
            spriteLow.zPosition = -1
        }
        addChild(spriteLow)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        if !isGameOver {
            laser.shot()
            for node in tappedNodes {
                if !isEmpty {
                    switch node.name {
                    case "badUFO":
                        handleNodeTap(node)
                    case "goodUFO":
                        handleNodeTap(node)
                    case "background":
                        SoundManager.shared.playSound(soundName: .shoot)
                    default:
                        break
                    }
                } else {
                    SoundManager.shared.playSound(soundName: .empty)
                    showReloadLabel()
                }
            }
        }
        if laser.laserCount == 0 {
            isEmpty = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            switch node.name {
            case "RestartGame":
                restartGame()
            case "reload":
                reloadLaser()
            case "startgame":
                restartGame()
                removeNode(withName: "startgame")
                removeNode(withName: "badUfoLogo")
            default:
                break
            }
        }
        if laser.laserCount == 0 {
            showReloadLabel()
        }
    }
    
    private func handleNodeTap(_ node: SKNode) {
        switch node.name {
        case "badUFO":
            handleBadUFOTap(node)
        case "goodUFO":
            handleGoodUFOTap(node)
        case "background":
            SoundManager.shared.playSound(soundName: .shoot)
        default:
            break
        }
    }
    
    private func handleUFOTap(_ node: SKNode, isBad: Bool) {
        if let explosion = SKEmitterNode(fileNamed: "explosion") {
            explosion.position = node.position
            addChild(explosion)
        }
        node.removeFromParent()
        score += isBad ? 1: -1
        SoundManager.shared.playSound(soundName: .shoot)
    }
    
    private func handleGoodUFOTap(_ node: SKNode) {
        handleUFOTap(node, isBad: false)
    }
    
    private func handleBadUFOTap(_ node: SKNode) {
        handleUFOTap(node, isBad: true)
    }
    
    private func showReloadLabel() {
        let reloadLabel = createLabel(position: CGPoint(x: 500, y: 350),
                                      text: "R E L O A D",
                                      alignment: .center)
        reloadLabel.name = "reload"
        reloadLabel.zPosition = 1
        addChild(reloadLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.8)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.8)
        let blinkAction = SKAction.sequence([fadeOutAction, fadeInAction])

        reloadLabel.run(SKAction.repeatForever(blinkAction))
    }
    
    private func reloadLaser() {
        laser.reload()
        isEmpty = false
        SoundManager.shared.playSound(soundName: .reload)
        removeNode(withName: "reload")
    }
    
    private func removeNode(withName name: String) {
        children.forEach { node in
            if node.name == name {
                node.removeFromParent()
            }
        }
    }
    
    func gameOver() {
        isGameOver = true
        
        createTimer?.invalidate()
        
        let gameOverLabel = createLabel(position: CGPoint(x: 500, y: 350), text: "GAME OVER", alignment: .center)
        gameOverLabel.name = "GAME OVER"
        gameOverLabel.zPosition = 1
        addChild(gameOverLabel)
        
        let restartGameLabel = createLabel(position: CGPoint(x: 500, y: 300), text: "Restart game", alignment: .center)
        restartGameLabel.name = "RestartGame"
        addChild(restartGameLabel)
    }
    
    func restartGame() {
        score = 0
        timeLeft = 60
        isGameOver = false
        isEmpty = false
        laser.reload()
        restartTimers()
        
        for node in children {
            if node.name == "GAME OVER" {
                node.removeFromParent()
            }
            if node.name == "RestartGame" {
                node.removeFromParent()
            }
        }
    }
    
    func restartTimers() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timerLabel in
            timeLeft -= 1
            if timeLeft == 0 {
                gameOver()
                timerLabel.invalidate()
            }
        }
        
        createTimer = Timer.scheduledTimer(timeInterval: TimeInterval(enemyTimer), target: self, selector: #selector(createUfo), userInfo: nil, repeats: true)
    }
}
