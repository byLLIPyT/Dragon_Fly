//
//  OptionsScene.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 20/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    var isMusic: Bool!
    var isSound: Bool!
    
    override func didMove(to view: SKView) {        
        isMusic = gameSettings.isMusic
        isSound = gameSettings.isSound
        
        setHeader(withName: "options", andBackground: "options")
        
        let backgroundNameForMusic = isMusic == true ? "music" : "nomusic"
        
        let music = ButtonNode(titled: nil, backgroundName: backgroundNameForMusic)
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        music.name = "music"
        music.label.isHidden = true
        addChild(music)
        
        let backgroundNameForSound = isSound == true ? "sound" : "nosound"
        
        let sound = ButtonNode(titled: nil, backgroundName: backgroundNameForSound)
        sound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        sound.name = "sound"
        sound.label.isHidden = true
        addChild(sound)
        let spacingMenu = CGFloat(20)
        let buttonADS = ButtonNode(titled: "remove", backgroundName: "remove")
        buttonADS.position = CGPoint(x: self.frame.midX, y: sound.position.y - sound.size.height - spacingMenu)
        buttonADS.name = "remove"
        addChild(buttonADS)
        
        let buttonRestore = ButtonNode(titled: "restorePurchases", backgroundName: "restorePurchases")
        buttonRestore.position = CGPoint(x: self.frame.midX, y: buttonADS.position.y - buttonADS.size.height - spacingMenu)
        buttonRestore.name = "restorePurchases"
        addChild(buttonRestore)
        
        let back = ButtonNode(titled: "back", backgroundName: "back")
        back.position = CGPoint(x: self.frame.midX, y: buttonRestore.position.y - buttonRestore.size.height - spacingMenu)
        back.name = "back"
        back.label.name = "back"
        addChild(back)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "music" {
            isMusic = !isMusic
            update(node: node as! SKSpriteNode, property: isMusic)
        } else if node.name == "sound" {
            isSound = !isSound
            update(node: node as! SKSpriteNode, property: isSound)
        } else if node.name == "back" {
            
            gameSettings.isSound = isSound
            gameSettings.isMusic = isMusic
            gameSettings.saveGameSettings()
            
            let transition = SKTransition.fade(withDuration: 1.0)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(backScene, transition: transition)
        }
    }
    
    func update(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}
