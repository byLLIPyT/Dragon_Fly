//
//  GameOverScene.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 24/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class GameOverScene: ParentScene {
    override func didMove(to view: SKView) {
        
        setHeader(withName: "game over", andBackground: "gameOver")
        
        let buttonRestart = ButtonNode(titled: "restart", backgroundName: "restart")
        buttonRestart.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * 0))
        buttonRestart.name = "restart"
        addChild(buttonRestart)
        
        let buttonOptions = ButtonNode(titled: "options", backgroundName: "options")
        buttonOptions.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * 1))
        buttonOptions.name = "options"
        addChild(buttonOptions)
        
        let buttonBest = ButtonNode(titled: "best", backgroundName: "best")
        buttonBest.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * 2))
        buttonBest.name = "best"
        addChild(buttonBest)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "restart" {
            sceneManager.gameScene = nil
            let transition = SKTransition.fade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        } else if node.name == "options" {
            
            let transition = SKTransition.fade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
            
        } else if node.name == "best" {
            
            let transition = SKTransition.fade(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }        
    }
}
