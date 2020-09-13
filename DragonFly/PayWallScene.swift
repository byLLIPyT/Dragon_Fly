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
        var newTitle = "Amazing dragon!"
        if IAPManager.shared.products.count > 0 {
            newTitle = "Amazing dragon! / \((self.priceStringFor(product: IAPManager.shared.products[0])))"
        }
        let buttonADS = ButtonNode(titled: "remove", backgroundName: "emptyButton", newTitle: newTitle)
        let spacingMenu = CGFloat(20)        
        let buttonRestore = ButtonNode(titled: "restorePurchases", backgroundName: "restorePurchases")
        let back = ButtonNode(titled: "back", backgroundName: "back")
        
        buttonADS.position = CGPoint(x: self.frame.midX, y: self.frame.minY + back.size.height + buttonRestore.size.height + buttonADS.size.height + spacingMenu * 3)
        buttonADS.name = "remove"
        buttonADS.label.name = "remove"
        addChild(buttonADS)
        
        buttonRestore.position = CGPoint(x: self.frame.midX, y: self.frame.minY + back.size.height + buttonRestore.size.height + spacingMenu * 2)
        buttonRestore.name = "restorePurchases"
        addChild(buttonRestore)
        
        back.position = CGPoint(x: self.frame.midX, y: self.frame.minY + back.size.height + spacingMenu)
        back.name = "back"
        addChild(back)
        
        let image = UIImage(named: "MobileDragon")
        let texture = SKTexture(image: image!)
        dragonImage =  SKSpriteNode(texture: texture)
        let ratio = image!.size.height / image!.size.width
        let heightButtons = back.size.height + buttonRestore.size.height + spacingMenu * 3
        var heightD = (self.frame.height - heightButtons - spacingMenu * 2) * 0.8
        var widthD = heightD / ratio
        if widthD > self.frame.width * 0.9 {
            widthD = self.frame.width * 0.9
            heightD = widthD * ratio
        }
        dragonImage.anchorPoint = CGPoint(x: 0.5, y: 1)
        dragonImage.position = CGPoint(x: self.frame.width / 2, y: self.frame.height - spacingMenu * 3)
        dragonImage.size = CGSize(width: heightD / ratio, height: heightD)
        addChild(dragonImage)        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "remove" {
            
            if IAPManager.shared.products.count > 0 {
                let identifier = IAPManager.shared.products[0].productIdentifier
                IAPManager.shared.purchase(productWith: identifier)
            }
        }  else if node.name == "restorePurchases" {
            
            IAPManager.shared.restoreCompletedTransactions()
            let alertController = UIAlertController(title: "Покупки восстановлены", message: nil, preferredStyle:  .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }  else if node.name == "back" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let optionsScene = PauseScene(size: self.size)
            optionsScene.backScene = self
            optionsScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(optionsScene, transition: transition)
        }
    }
    
    private func priceStringFor(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price)!
    }
}

