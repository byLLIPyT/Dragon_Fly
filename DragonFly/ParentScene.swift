//
//  ParentScene.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 20/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class ParentScene: SKScene {
    
    let gameSettings = GameSettings()
    let sceneManager = SceneManager.shared
    var backScene: SKScene?
    
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        if backgroundName != "paywall" {
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        }
    }
    
    override init(size: CGSize) {
        
        super.init(size: size)
        backgroundColor = SKColor(red: 0.25, green: 0.75, blue: 0.94, alpha: 1.0)
//        let background = SKSpriteNode(imageNamed: "backgroundMenu")
//        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        background.zPosition = 99
//        background.size = self.size
//        self.addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
