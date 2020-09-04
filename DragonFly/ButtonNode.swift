//
//  ButtonNode.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 19/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
    
    let label: SKLabelNode = {
        let l = SKLabelNode(text: "")
        l.fontColor = UIColor.white//(red: 219 / 255, green: 226 / 255, blue: 215 / 255, alpha: 1.0)
        l.fontName = "Phenomena-Bold"       
        l.fontSize = 25
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.zPosition = 1
        return l
    }()
    
    init(titled title: String?, backgroundName: String, newTitle: String = "") {
        let texture = SKTexture(imageNamed: backgroundName)
        super.init(texture: texture, color: .clear, size: texture.size())
        if let title = title {
            if title == "remove"{
                label.text = newTitle.uppercased()
            }
        }
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
