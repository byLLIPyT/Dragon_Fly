//
//  Shot.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 15/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    let screenSize = UIScreen.main.bounds
    
    fileprivate let initialSize = CGSize(width: 187, height: 237)
    fileprivate let textureAtlas: SKTextureAtlas!
    fileprivate var textureNameBeingsWith = ""
    fileprivate var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        let damageLevel = DamageShot.shared
        self.textureAtlas = textureAtlas        
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeingsWith = String(textureName.dropLast(6))
        super.init(texture: texture, color: .clear, size: initialSize)
        if damageLevel.typeDamage == .simple {
            self.setScale(CGFloat(damageLevel.levelDamageSimple))
        } else if damageLevel.typeDamage == .middle {
            self.setScale(CGFloat(damageLevel.levelDamageMiddle))
        } else {
            self.setScale(CGFloat(damageLevel.levelDamageSenior))
        }
        
        self.name = "shotSprite"
        self.zPosition = 30
        
        let offsetX = self.frame.size.width * self.anchorPoint.x
        let offsetY = self.frame.size.height * self.anchorPoint.y
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 41 - offsetX, y: 113 - offsetY))
        path.addLine(to: CGPoint(x: 55 - offsetX, y: 114 - offsetY))
        path.addLine(to: CGPoint(x: 59 - offsetX, y: 32 - offsetY))
        path.addLine(to: CGPoint(x: 36 - offsetX, y: 33 - offsetY))
                
        path.closeSubpath()
        
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
    }
        
    func startMovement() {
        performRotation()
        
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        self.run(moveForward)
    }
    
    
    fileprivate func performRotation() {
        for i in 1...32 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeingsWith + number.description))
        }
        
        SKTexture.preload(animationSpriteArray) {
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
