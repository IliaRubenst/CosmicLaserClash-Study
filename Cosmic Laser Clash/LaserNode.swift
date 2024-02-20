//
//  LaserNode.swift
//  Cosmic Laser Clash
//
//  Created by Ilia Ilia on 30.07.2023.
//

import SpriteKit

class LaserNode: SKNode {
    var laser = [SKSpriteNode]()
    let fullLaser = SKTexture(imageNamed: "laser")
    let emptyLaser = SKTexture(imageNamed: "laserEmpty")
    var laserCount = 6
    
    func laserCounter(at position: CGPoint) {
        self.position = position
        
        laser.append(createLaser(x: 0))
        laser.append(createLaser(x: 25))
        laser.append(createLaser(x: 50))
        laser.append(createLaser(x: 75))
        laser.append(createLaser(x: 100))
        laser.append(createLaser(x: 125))
        
        let hide = SKSpriteNode()
        hide.size = CGSize(width: 10, height: 25)
        hide.position = CGPoint(x: -100, y: -75)
        addChild(hide)
    }
    
    func createLaser(x: Int) -> SKSpriteNode {
        let laser = SKSpriteNode(imageNamed: "laser")
        laser.position = CGPoint(x: x, y: 0)
        addChild(laser)
        return laser
    }
    
    func shot() {
        if laserCount <= 0 {
            return
        }
        laserCount -= 1
        laser[laserCount].texture = emptyLaser
    }
    
    func reload() {
        for laser in laser {
            laser.texture = fullLaser
        }
        laserCount = 6
    }
}
