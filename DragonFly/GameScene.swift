//
//  GameScene.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 19/04/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    var backgroundMusic: SKAudioNode!
    fileprivate var player: PlayerPlane!
    fileprivate let hud = HUD()
    fileprivate let screenSize = UIScreen.main.bounds.size
    fileprivate var lives = 5 {
        didSet {
            switch lives {
            case 5:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
                hud.life4.isHidden = false
                hud.life5.isHidden = false
            case 4:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
                hud.life4.isHidden = false
                hud.life5.isHidden = true
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
                hud.life4.isHidden = true
                hud.life5.isHidden = true
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
                hud.life4.isHidden = true
                hud.life5.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
                hud.life4.isHidden = true
                hud.life5.isHidden = true
            default:
                break
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        gameSettings.loadGameSettings()
        if gameSettings.isMusic && backgroundMusic == nil {
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a") {
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic)
            }
        }
        
        self.scene?.isPaused = false
        guard sceneManager.gameScene == nil else { return }
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        self.player.performFly()
        spawnPowerUp()
        spawnEnemiesSpiral()
        createHUD()
    }
    
    fileprivate func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
    }
    
    fileprivate func spawnPowerUp() {
        
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            if randomNumber == 0 {
                let powerUp = RedPowerUp()
                let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
                powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
                powerUp.startMovement()
                self.addChild(powerUp)
            } else if randomNumber == 1 {
                let powerUp = GreenPowerUp()
                let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
                powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
                powerUp.startMovement()
                self.addChild(powerUp)
            } else if randomNumber == 2 {
                let powerUp = YellowPowerUp()
                let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
                powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
                powerUp.startMovement()
                self.addChild(powerUp)
            } else if randomNumber == 3 {
                let powerUp = BluePowerUp()
                let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
                powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100)
                powerUp.startMovement()
                self.addChild(powerUp)
            }
        }
        
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
    }
    
    fileprivate func spawnEnemiesSpiral() {
        
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    fileprivate func spawnSpiralOfEnemies() {
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas//SKTextureAtlas(named: "Enemy_1")
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas//SKTextureAtlas(named: "Enemy_2")
        let enemyTextureAtlas3 = Assets.shared.enemy_3Atlas//SKTextureAtlas(named: "Enemy_2")
        let enemyTextureAtlas4 = Assets.shared.enemy_4Atlas//SKTextureAtlas(named: "Enemy_2")
        let enemyTextureAtlas5 = Assets.shared.enemy_5Atlas//SKTextureAtlas(named: "Enemy_2")
        let enemyTextureAtlas6 = Assets.shared.enemy_6Atlas//SKTextureAtlas(named: "Enemy_2")
        
        var arrayEnemies: [Enemy] = []
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2, enemyTextureAtlas3, enemyTextureAtlas4, enemyTextureAtlas5, enemyTextureAtlas6]) { [unowned self] in
            
            let randomNumber = Int(arc4random_uniform(6))
            print(randomNumber)
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2, enemyTextureAtlas3, enemyTextureAtlas4, enemyTextureAtlas5, enemyTextureAtlas6]
            let textureAtlas = arrayOfAtlases[randomNumber]
            
            let waitAction = SKAction.wait(forDuration: 3.0)
            let spawnEnemy = SKAction.run({ [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[4])
                let enemy = Enemy(enemyTexture: texture)//, currentNumber: )
                
                enemy.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.size.width - 30))), y: self.size.height + 110)
                self.addChild(enemy)
                arrayEnemies.append(enemy)
                enemy.flySpiral()
            })
            
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
    }
    
    fileprivate func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 1)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }
        
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence)
        run(spawnCloudForever)
    }
    
    fileprivate func spawnIslands() {
        let spawnIslandWait = SKAction.wait(forDuration: 5)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate(at: nil)
            self.addChild(island)
        }
        
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence)
        run(spawnIslandForever)
    }
    
    fileprivate func configureStartScene() {
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        
        let island1 = Island.populate(at: CGPoint(x: 100, y: 200))
        self.addChild(island1)
        
        let island2 = Island.populate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
        self.addChild(island2)
        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
    }
    
    override func didSimulatePhysics() {
        
        player.checkPosition()
        enumerateChildNodes(withName: "sprite") { (node, stop) in
            if node.position.y <= -400 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "bluePowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "greenPowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "yellowPowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "redPowerUp") { (node, stop) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "shotSprite") { (node, stop) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
    }
    
    fileprivate func playerFire() {
        
        let damageShot = DamageShot.shared
        
        let shot = YellowShot()
        let middleRightShot = YellowShot()
        let middleLeftShot = YellowShot()
        let seniorRightShot = YellowShot()
        let seniorLeftShot = YellowShot()
        
        if damageShot.typeDamage == .simple {
            shot.position = self.player.position
            shot.startMovement()
            self.addChild(shot)
        } else if damageShot.typeDamage == .middle {
            shot.position = self.player.position
            shot.startMovement()
            
            middleRightShot.position = CGPoint(x: self.player.position.x + 15, y: self.player.position.y)
            middleRightShot.startMovement()
            
            middleLeftShot.position = CGPoint(x: self.player.position.x - 15, y: self.player.position.y)
            middleLeftShot.startMovement()
            
            self.addChild(shot)
            self.addChild(middleRightShot)
            self.addChild(middleLeftShot)
        } else if damageShot.typeDamage == .senior {
            shot.position = self.player.position
            shot.startMovement()
            
            middleRightShot.position = CGPoint(x: self.player.position.x + 15, y: self.player.position.y)
            middleRightShot.startMovement()
            
            middleLeftShot.position = CGPoint(x: self.player.position.x - 15, y: self.player.position.y)
            middleLeftShot.startMovement()
            
            seniorRightShot.position = CGPoint(x: self.player.position.x + 30, y: self.player.position.y)
            seniorRightShot.startMovement()
            
            seniorLeftShot.position = CGPoint(x: self.player.position.x - 30, y: self.player.position.y)
            seniorLeftShot.startMovement()
            
            self.addChild(shot)
            self.addChild(middleRightShot)
            self.addChild(middleLeftShot)
            
            self.addChild(seniorRightShot)
            self.addChild(seniorLeftShot)
            
        } else {
            shot.position = self.player.position
            shot.startMovement()
        }        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "pause" {
            let transition = SKTransition.fade(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene!.view?.presentScene(pauseScene, transition: transition)
        } else {
            playerFire()
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let explosion = SKEmitterNode(fileNamed: "EnemyExplosion")
        let contactPoint = contact.contactPoint
        explosion?.position = contactPoint
        explosion?.zPosition = 25
        let waitForExplosionAction = SKAction.wait(forDuration: 2.0)
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.enemy, .player]:// print("enemy vs player")
            
            if contact.bodyA.node?.name == "sprite" {
                if contact.bodyA.node?.parent != nil {
                    contact.bodyA.node?.removeFromParent()
                    if !EndlessGame.shared.endlessGame {
                        lives -= 1
                    }
                }
            } else {
                if contact.bodyB.node?.parent != nil {
                    contact.bodyB.node?.removeFromParent()
                    if !EndlessGame.shared.endlessGame {
                        lives -= 1
                    }
                }
            }
            addChild(explosion!)
            self.run(waitForExplosionAction){ explosion?.removeFromParent() }
            
            if lives == 0 {
                
                gameSettings.currentScore = hud.score
                gameSettings.saveScores()
                
                let gameOverScene = GameOverScene(size: self.size)
                gameOverScene.scaleMode = .aspectFill
                let transition = SKTransition.fade(withDuration: 1.0)
                self.scene!.view?.presentScene(gameOverScene, transition: transition)
            }
            
        case [.powerUp, .player]: //print("powerUp vs player")
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                
                if contact.bodyA.node?.name == "redPowerUp" {//поймать синий усилитель
                    contact.bodyA.node?.removeFromParent()
                    lives = 5
                    player.redPowerUp()
                } else if contact.bodyB.node?.name == "redPowerUp" {//поймать синий усилитель
                    contact.bodyB.node?.removeFromParent()
                    lives = 5
                    player.redPowerUp()
                }
                
                if contact.bodyA.node?.name == "greenPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    let damageLevel = DamageShot.shared
                    damageLevel.upgradeDamage()
                    player.greenPowerUp()
                } else if contact.bodyB.node?.name == "greenPowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    let damageLevel = DamageShot.shared
                    damageLevel.upgradeDamage()
                    player.greenPowerUp()
                }
                
                if contact.bodyA.node?.name == "yellowPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    //                let damageLevel = DamageShot.shared
                    //                damageLevel.upgradeDamage()
                    player.yellowPowerUp()
                } else if contact.bodyB.node?.name == "yellowPowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    //                let damageLevel = DamageShot.shared
                    //                damageLevel.upgradeDamage()
                    player.yellowPowerUp()
                }
                
                if contact.bodyA.node?.name == "redPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    //                let damageLevel = DamageShot.shared
                    //                damageLevel.upgradeDamage()
                    player.redPowerUp()
                } else if contact.bodyB.node?.name == "redPowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    //                let damageLevel = DamageShot.shared
                    //                damageLevel.upgradeDamage()
                    player.redPowerUp()
                }
            }
            
        case [.enemy, .shot]: //print("enemy vs shot")
            
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil {
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                
                if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                }
                
                hud.score += 5
                addChild(explosion!)
                self.run(waitForExplosionAction){ explosion?.removeFromParent() }
            }
        default: preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
