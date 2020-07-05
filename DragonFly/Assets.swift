//
//  Assets.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 15/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class Assets {
    static let shared = Assets()
    var isLoaded = false
    let yellowShotAtlas = SKTextureAtlas(named: "YellowShot")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let yellowPowerUpAtlas = SKTextureAtlas(named: "YellowPowerUp")
    let redPowerUpAtlas = SKTextureAtlas(named: "RedPowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets() {
        yellowShotAtlas.preload {  }
        enemy_1Atlas.preload {  }
        enemy_2Atlas.preload {  }
        greenPowerUpAtlas.preload {  }
        bluePowerUpAtlas.preload {  }
        yellowPowerUpAtlas.preload {  }
        redPowerUpAtlas.preload {  }
        playerPlaneAtlas.preload {  }
    }
}
