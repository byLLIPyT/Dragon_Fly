//
//  PayWallScene.swift
//  DragonFly
//
//  Created by Александр Уткин on 02.09.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import SpriteKit
import StoreKit


class PayWallScene: ParentScene {
    
    var dragonImage = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        setHeader(withName: "paywall", andBackground: "paywall")
        var newTitle = "Full version"
        if IAPManager.shared.products.count > 0 {
            newTitle = "Amazing dragon! / \((self.priceStringFor(product: IAPManager.shared.products[0])))"
        }
        
        let buttonADS = ButtonNode(titled: "remove", backgroundName: "emptyButton", newTitle: newTitle)
        let spacingMenu = CGFloat(20)
        
        
        
        
        
        let currentProducts = IAPManager.shared.products
        print("Количество найденных покупок - \(currentProducts.count)")
        
                
        
        let buttonRestore = ButtonNode(titled: "restorePurchases", backgroundName: "restorePurchases")
        let back = ButtonNode(titled: "back", backgroundName: "back")
        
        buttonADS.position = CGPoint(x: self.frame.midX, y: self.frame.minY + back.size.height + buttonRestore.size.height + buttonADS.size.height + spacingMenu * 3)
        buttonADS.name = "remove"
        buttonADS.label.name = "remove"
        addChild(buttonADS)
        
        //let buttonRestore = ButtonNode(titled: "restorePurchases", backgroundName: "restorePurchases")
        buttonRestore.position = CGPoint(x: self.frame.midX, y: self.frame.minY + back.size.height + buttonRestore.size.height + spacingMenu * 2)
        buttonRestore.name = "restorePurchases"
        addChild(buttonRestore)
        
        //let back = ButtonNode(titled: "back", backgroundName: "back")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.minY + back.size.height + spacingMenu)
        back.name = "back"
        addChild(back)
        
        let image = UIImage(named: "dragonImage")
        let heightDragon = image!.size.height
        let texture = SKTexture(image: image!)
        dragonImage =  SKSpriteNode(texture: texture)
        dragonImage.position = CGPoint(x: self.frame.midX, y: buttonADS.frame.midY + CGFloat(heightDragon / 2) + spacingMenu * 5)
        addChild(dragonImage)        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "play" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
        }  else if node.name == "endlessGame" {
            let transition = SKTransition.fade(withDuration: 1.0)
            EndlessGame.shared.endlessGame = true
            let optionsScene = GameScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
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
    
    private func priceStringFor(product: SKProduct) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        
        return numberFormatter.string(from: product.price)!
    }
}

