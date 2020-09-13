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
    let enemy_3Atlas = SKTextureAtlas(named: "Enemy_3")
    let enemy_4Atlas = SKTextureAtlas(named: "Enemy_4")
    let enemy_5Atlas = SKTextureAtlas(named: "Enemy_5")
    let enemy_6Atlas = SKTextureAtlas(named: "Enemy_6")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let yellowPowerUpAtlas = SKTextureAtlas(named: "YellowPowerUp")
    let redPowerUpAtlas = SKTextureAtlas(named: "RedPowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    let playerPlanePremium = SKTextureAtlas(named: "PlayerPlanePremium")
        
    func preloadAssets() {
        yellowShotAtlas.preload {  }
        enemy_1Atlas.preload {  }
        enemy_2Atlas.preload {  }
        enemy_3Atlas.preload {  }
        enemy_4Atlas.preload {  }
        enemy_5Atlas.preload {  }
        enemy_6Atlas.preload {  }
        greenPowerUpAtlas.preload {  }
        bluePowerUpAtlas.preload {  }
        yellowPowerUpAtlas.preload {  }
        redPowerUpAtlas.preload {  }
        playerPlaneAtlas.preload {  }
    }
}
