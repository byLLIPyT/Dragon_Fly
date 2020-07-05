//
//  Cloud.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 20/04/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit
import GameplayKit



final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    static func populate(at point: CGPoint?) -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = 10
        cloud.name = "sprite"
        cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        cloud.run(move(from: cloud.position))
        
        return cloud
    }
    
    
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 6, highestValue: 7)
        let randomNumber = distribution.nextInt()
        let imageName = "cl" + "\(randomNumber)"
        
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 5, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -400)
        let moveDistance = point.y + 400
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
