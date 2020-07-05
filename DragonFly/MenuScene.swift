//
//  MenuScene.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 15/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class MenuScene: ParentScene {
    
    
    override func didMove(to view: SKView) {
        if !Assets.shared.isLoaded {
            Assets.shared.preloadAssets()
            Assets.shared.isLoaded = true
        }
        setHeader(withName: nil, andBackground: "header1")
        let spacingMenu = CGFloat(20)
        let buttonPlay = ButtonNode(titled: "play", backgroundName: "play")
        buttonPlay.position = CGPoint(x: self.frame.midX, y: self.frame.midY - (buttonPlay.size.height) * 0 - spacingMenu)
        buttonPlay.name = "play"
                
        addChild(buttonPlay)
        
        let buttonPlayEndless = ButtonNode(titled: "play", backgroundName: "play")
        buttonPlayEndless.position = CGPoint(x: self.frame.midX, y: buttonPlay.position.y  - (buttonPlay.size.height) - spacingMenu)//- CGFloat(spacing * 1))
        buttonPlayEndless.name = "play"
        addChild(buttonPlayEndless)
        
        let buttonOptions = ButtonNode(titled: "options", backgroundName: "options")
        buttonOptions.position = CGPoint(x: self.frame.midX, y: buttonPlayEndless.position.y  - (buttonPlay.size.height) - spacingMenu)//- CGFloat(spacing * 2))
        buttonOptions.name = "options"
        addChild(buttonOptions)
        
        let buttonBest = ButtonNode(titled: "best", backgroundName: "best")
        buttonBest.position = CGPoint(x: self.frame.midX, y: buttonOptions.position.y  - (buttonPlay.size.height) - spacingMenu)//- CGFloat(spacing * 3))
        buttonBest.name = "best"
        addChild(buttonBest)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "play" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }  else if node.name == "options" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let optionsScene = OptionsScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        }  else if node.name == "best" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(bestScene, transition: transition)
        }
    }
}
