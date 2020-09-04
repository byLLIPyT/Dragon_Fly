//
//  Enemy.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 11/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    //var currentNumber: Int
    
    init(enemyTexture: SKTexture) {
        
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 408, height: 204))
        self.xScale = 0.15
        self.yScale = -0.375
        self.zPosition = 20
        self.name = "sprite"
        
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 6 - offsetX, y: 70 - offsetY))
        path.addLine(to: CGPoint(x: 25 - offsetX, y: 76 - offsetY))
        path.addLine(to: CGPoint(x: 47 - offsetX, y: 75 - offsetY))
        path.addLine(to: CGPoint(x: 51 - offsetX, y: 96 - offsetY))
        path.addLine(to: CGPoint(x: 59 - offsetX, y: 95 - offsetY))
        path.addLine(to: CGPoint(x: 64 - offsetX, y: 77 - offsetY))
        path.addLine(to: CGPoint(x: 105 - offsetX, y: 68 - offsetY))
        path.addLine(to: CGPoint(x: 86  - offsetX, y: 55 - offsetY))
        path.addLine(to: CGPoint(x: 63 - offsetX, y: 50 - offsetY))
        path.addLine(to: CGPoint(x: 59 - offsetX, y: 23 - offsetY))
        path.addLine(to: CGPoint(x: 72 - offsetX, y: 18 - offsetY))
        path.addLine(to: CGPoint(x: 73 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 56 - offsetX, y: 2 - offsetY))
        path.addLine(to: CGPoint(x: 37 - offsetX, y: 8 - offsetY))
        path.addLine(to: CGPoint(x: 39 - offsetX, y: 19 - offsetY))
        path.addLine(to: CGPoint(x: 50 - offsetX, y: 23 - offsetY))
        path.addLine(to: CGPoint(x: 47  - offsetX, y: 50 - offsetY))
        path.addLine(to: CGPoint(x: 17  - offsetX, y: 56 - offsetY))
        path.addLine(to: CGPoint(x: 5  - offsetX, y: 68 - offsetY))
        
        path.closeSubpath()
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.none.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player.rawValue | BitMaskCategory.shot.rawValue
    }
    
    func flySpiral() {
        
        let screenSize = UIScreen.main.bounds
        let timeHorizontal: Double = 3
        let timeVertical: Double   = 5
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveRight.timingMode = .easeInEaseOut
        let randomNumber = Int(arc4random_uniform(2))
        let asideMovementSequence = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveRight]) : SKAction.sequence([moveRight, moveLeft])
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVertical)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum EnemyDirection: Int {
    case left = 0
    case right
}
