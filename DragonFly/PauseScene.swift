//
//  PauseScene.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 19/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class PauseScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        setHeader(withName: "pause", andBackground: "pause")
        let spacingMenu = CGFloat(20)
        let buttonRestart = ButtonNode(titled: "restart", backgroundName: "restart")
        buttonRestart.position = CGPoint(x: self.frame.midX, y: self.frame.midY - spacingMenu)
        buttonRestart.name = "restart"
        addChild(buttonRestart)
        
        let buttonOptions = ButtonNode(titled: "options", backgroundName: "options")
        buttonOptions.position = CGPoint(x: self.frame.midX, y: buttonRestart.position.y - buttonRestart.size.height - spacingMenu)
        buttonOptions.name = "options"
        addChild(buttonOptions)
        
        let buttonResume = ButtonNode(titled: "resume", backgroundName: "back")//нужен resume
        buttonResume.position = CGPoint(x: self.frame.midX, y: buttonOptions.position.y - buttonOptions.size.height - spacingMenu)
        buttonResume.name = "resume"
        //buttonResume.label.name = "resume"
        addChild(buttonResume)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused {
                gameScene.isPaused = true
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            sceneManager.gameScene = nil
            let transition = SKTransition.fade(withDuration: 1.0)//(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
            
        } else if node.name == "resume" {
            let transition = SKTransition.fade(withDuration: 1.0)
            guard let gameScene = sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }
    }
}
