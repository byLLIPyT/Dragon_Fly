//
//  YellowPowerUp.swift
//  DragonFly
//
//  Created by Utkin Aleksandr on 13/05/2020.
//  Copyright © 2020 Utkin Aleksandr. All rights reserved.
//

import SpriteKit

class YellowPowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.yellowPowerUpAtlas
        super.init(textureAtlas: textureAtlas)
        name = "yellowPowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
